/*
 * RTS auto-save draft - common to all citizen application forms (loaded by pages/core-pages/rtsdraft/rtsDraft.jspf).
 * The form page is not changed. Nothing is stored in the browser (no localStorage / IndexedDB / cookies): the draft
 * is kept on the server only.
 *
 *   - the values entered are sent to /ws/rtsdraft/save.do a few seconds after the citizen stops typing, at most
 *     once every 15 seconds, and once more when the page is closed;
 *   - every document chosen (up to 5 MB) is sent to the draft once (/ws/rtsdraft/uploadFile.do), one at a time.
 *
 * When the form is opened again (after a power failure, lost internet, session expiry or an error), the citizen can
 * Resume - values and documents are put back into the form, so the form's own submit works unchanged - or Start new.
 * After the application is submitted (success page), the draft is deleted.
 *
 * Safety: only one request at a time, each with a time limit; it stops completely when the session has expired or
 * the draft is switched off on the server; every error is caught - the form always works as before.
 */
(function () {
	'use strict';
	try {
		var C = window.RTS_DRAFT;
		if (!C || !C.formKey || !window.JSON || !window.XMLHttpRequest || !document.querySelector || !document.addEventListener) {
			return;
		}
	} catch (ignore) {
		return;
	}
	var URL = C.ctx + '/ws/rtsdraft/';
	var SKIP = /captcha|otp|password|passwd|csrf|token/i;
	var MAX_FILE = 5 * 1024 * 1024; // the server keeps documents up to 5 MB
	var WAIT_AFTER_TYPING = 4000; // ms after the last change
	var MIN_GAP = 15000; // ms between two saves
	var TIME_LIMIT = 30000; // ms per request (60 s for a document)

	// ------------------------------------------------------------------ requests (one at a time)

	function parse(text) {
		try {
			return JSON.parse(text);
		} catch (e) {
			return null;
		}
	}

	function encode(params) {
		var parts = [];
		for (var name in params) {
			if (params.hasOwnProperty(name) && params[name] !== undefined && params[name] !== null) {
				parts.push(encodeURIComponent(name) + '=' + encodeURIComponent(params[name]));
			}
		}
		return parts.join('&');
	}

	var queue = [];
	var busy = false;
	var stopped = null; // 'login' / 'off': no more requests on this page

	/** callback(result): result.ok, or {ok:false, login:true} / {ok:false, off:true} / {ok:false, offline:true}. */
	function request(method, action, body, callback, isForm) {
		if (stopped) {
			if (callback) {
				callback({ ok: false, stopped: true });
			}
			return;
		}
		queue.push([method, action, body, callback, isForm]);
		next();
	}

	function next() {
		if (busy || !queue.length) {
			return;
		}
		busy = true;
		var job = queue.shift();
		var done = false;
		function finish(result) {
			if (done) {
				return;
			}
			done = true;
			busy = false;
			if (result.login || result.off) {
				stopped = result.login ? 'login' : 'off';
				var waiting = queue;
				queue = [];
				for (var i = 0; i < waiting.length; i++) {
					if (waiting[i][3]) {
						try {
							waiting[i][3]({ ok: false, stopped: true });
						} catch (e) {
							// ignore
						}
					}
				}
			}
			try {
				if (job[3]) {
					job[3](result);
				}
			} catch (e) {
				// never break the form
			}
			next();
		}
		try {
			var xhr = new XMLHttpRequest();
			xhr.open(job[0], URL + job[1], true);
			xhr.timeout = job[4] ? 2 * TIME_LIMIT : TIME_LIMIT;
			if (job[2] && !job[4]) {
				xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8');
			}
			xhr.onreadystatechange = function () {
				if (xhr.readyState !== 4) {
					return;
				}
				var result = xhr.status === 200 ? parse(xhr.responseText) : null;
				if (!result) {
					// no answer: offline; an HTML page instead of JSON: redirected to the login page
					result = xhr.status === 0 ? { ok: false, offline: true } : { ok: false, login: xhr.status === 200 || xhr.status === 401 || xhr.status === 403 };
				}
				finish(result);
			};
			xhr.ontimeout = function () {
				finish({ ok: false, offline: true });
			};
			xhr.send(job[2] || null);
		} catch (e) {
			finish({ ok: false, offline: true });
		}
	}

	/** When the page is closed: last save without waiting for an answer (not queued). */
	function beacon(action, params) {
		if (stopped || !navigator.sendBeacon) {
			return;
		}
		try {
			navigator.sendBeacon(URL + action, new Blob([encode(params)], { type: 'application/x-www-form-urlencoded' }));
		} catch (e) {
			// ignore
		}
	}

	function formatTime(ms) {
		var d = new Date(ms);
		function two(n) {
			return (n < 10 ? '0' : '') + n;
		}
		return two(d.getDate()) + '/' + two(d.getMonth() + 1) + '/' + d.getFullYear() + ' ' + two(d.getHours()) + ':' + two(d.getMinutes());
	}

	// ------------------------------------------------------------------ success page: the application was submitted

	if (C.mode === 'success') {
		var derived = C.formKey.replace(/suc+ess$/i, '');
		request('POST', 'discard.do', encode({ formKey: derived, submitted: '1' }), null);
		return;
	}

	// ------------------------------------------------------------------ the form

	var form = document.frmPage || document.forms[0];
	if (!form) {
		return;
	}
	var state = {
		active: false, // auto-save running (after Resume / Start new, or when there is no draft)
		dirty: false, // changed since the last save
		restoring: false,
		submitting: false,
		lastSaved: null, // JSON of the values last saved
		lastSentAt: 0,
		lastOkAt: 0, // time of the last successful save
		timer: null,
		offlineTries: 0,
		initial: null, // the form as the page opened it
		earlyFiles: [] // documents chosen before auto-save started (sent when it starts)
	};

	/** Name of the form for "My Drafts", from the form page name: newRTIBirthApplication -> Birth Application. */
	function title() {
		return C.formKey.replace(/^new(RTI|RTS)?/i, '').replace(/([a-z])([A-Z])/g, '$1 $2').replace(/([A-Z]+)([A-Z][a-z])/g, '$1 $2');
	}

	function keyOf(el) {
		if (el.name) {
			return el.name;
		}
		if (el.id) {
			return '#' + el.id;
		}
		if (el.type === 'file') {
			var all = form.querySelectorAll('input[type=file]');
			for (var i = 0; i < all.length; i++) {
				if (all[i] === el) {
					return '@file' + i;
				}
			}
		}
		return null;
	}

	function controls() {
		var list = [];
		var elements = form.elements;
		for (var i = 0; i < elements.length; i++) {
			var el = elements[i];
			var tag = (el.tagName || '').toUpperCase();
			if (tag !== 'INPUT' && tag !== 'SELECT' && tag !== 'TEXTAREA') {
				continue;
			}
			var type = (el.type || '').toLowerCase();
			if (/^(hidden|password|submit|button|reset|image|file)$/.test(type) || el.disabled) {
				continue;
			}
			var key = keyOf(el);
			if (!key || SKIP.test(key) || el.getAttribute('data-rts-draft') === 'off') {
				continue;
			}
			list.push({ el: el, key: key, type: type });
		}
		return list;
	}

	function fileInputs() {
		var list = [];
		var inputs = form.querySelectorAll('input[type=file]');
		for (var i = 0; i < inputs.length; i++) {
			var key = keyOf(inputs[i]);
			if (key && !SKIP.test(key)) {
				list.push({ el: inputs[i], key: key });
			}
		}
		return list;
	}

	/** {key: {t:'v'|'r'|'c'|'m', v:...}} in the order of the form. */
	function collect() {
		var fields = {};
		var list = controls();
		for (var i = 0; i < list.length; i++) {
			var c = list[i];
			var g = fields[c.key];
			if (c.type === 'radio') {
				g = fields[c.key] = g || { t: 'r', v: null };
				if (c.el.checked) {
					g.v = c.el.value;
				}
			} else if (c.type === 'checkbox') {
				g = fields[c.key] = g || { t: 'c', v: [] };
				g.v.push(c.el.checked);
			} else if (c.el.tagName.toUpperCase() === 'SELECT' && c.el.multiple) {
				g = fields[c.key] = g || { t: 'm', v: [] };
				var selected = [];
				for (var o = 0; o < c.el.options.length; o++) {
					if (c.el.options[o].selected) {
						selected.push(c.el.options[o].value);
					}
				}
				g.v.push(selected);
			} else {
				g = fields[c.key] = g || { t: 'v', v: [] };
				g.v.push(c.el.value);
			}
		}
		return fields;
	}

	function fire(el, type) {
		var event;
		try {
			event = new Event(type, { bubbles: true });
		} catch (e) {
			event = document.createEvent('HTMLEvents');
			event.initEvent(type, true, false);
		}
		el.dispatchEvent(event);
	}

	/** Puts the saved values into the form; returns how many still could not be set (e.g. a list not loaded yet). */
	function apply(fields) {
		var missing = 0;
		var list = controls();
		var seen = {};
		for (var i = 0; i < list.length; i++) {
			var c = list[i];
			var g = fields[c.key];
			if (!g) {
				continue;
			}
			var n = seen[c.key] = (seen[c.key] || 0) + 1;
			var el = c.el;
			try {
				if (g.t === 'r') {
					if (g.v !== null && el.value === g.v && !el.checked) {
						el.click();
					}
				} else if (g.t === 'c') {
					var want = g.v[n - 1];
					if (typeof want === 'boolean' && el.checked !== want) {
						el.click();
					}
				} else if (g.t === 'm') {
					var values = g.v[n - 1] || [];
					var changedSel = false;
					for (var o = 0; o < el.options.length; o++) {
						var sel = values.indexOf(el.options[o].value) >= 0;
						if (el.options[o].selected !== sel) {
							el.options[o].selected = sel;
							changedSel = true;
						}
					}
					if (changedSel) {
						fire(el, 'change');
					}
				} else {
					var value = g.v[n - 1];
					if (value === undefined || value === null || el.value === value) {
						continue;
					}
					if (el.tagName.toUpperCase() === 'SELECT') {
						var exists = false;
						for (var p = 0; p < el.options.length; p++) {
							exists = exists || el.options[p].value === value;
						}
						if (!exists) {
							missing++; // e.g. a ward list that is loaded after the zone is chosen
							continue;
						}
					}
					el.value = value;
					fire(el, 'input');
					fire(el, 'change');
				}
			} catch (e) {
				// a page script failed on this field: the next fields are still restored
			}
		}
		return missing;
	}

	// ------------------------------------------------------------------ message bar and badge (created only when needed)

	var bar, barText, barButtons, badge;

	function makeBar() {
		if (bar) {
			return;
		}
		bar = document.createElement('div');
		bar.setAttribute('data-rts-draft', 'off');
		bar.style.cssText = 'border:1px solid #93c5fd;background:#eff6ff;color:#1e3a8a;border-radius:6px;padding:10px 14px;'
			+ 'margin:10px;font:14px Arial,sans-serif;display:none;align-items:center;justify-content:space-between;gap:10px;flex-wrap:wrap';
		barText = document.createElement('span');
		barButtons = document.createElement('span');
		bar.appendChild(barText);
		bar.appendChild(barButtons);
		form.insertBefore(bar, form.firstChild);
		badge = document.createElement('div');
		badge.style.cssText = 'position:fixed;right:12px;bottom:12px;z-index:99999;padding:6px 12px;border-radius:16px;'
			+ 'font:12px Arial,sans-serif;box-shadow:0 1px 4px rgba(0,0,0,.25);display:none;max-width:80%';
		document.body.appendChild(badge);
	}

	function showBar(text, buttons) {
		makeBar();
		barText.innerHTML = '';
		barText.appendChild(document.createTextNode(text));
		barButtons.innerHTML = '';
		for (var i = 0; buttons && i < buttons.length; i++) {
			var b = document.createElement('button');
			b.type = 'button';
			b.appendChild(document.createTextNode(buttons[i][0]));
			b.style.cssText = 'margin-left:6px;padding:6px 14px;border:0;border-radius:4px;color:#fff;cursor:pointer;font-weight:bold;background:' + buttons[i][1];
			b.onclick = buttons[i][2];
			barButtons.appendChild(b);
		}
		bar.style.display = 'flex';
	}

	function hideBar() {
		if (bar) {
			bar.style.display = 'none';
		}
	}

	function setBadge(text, kind) {
		makeBar();
		var colors = { ok: ['#dcfce7', '#166534'], busy: ['#e0edfb', '#0f3d6e'], warn: ['#fef3c7', '#92400e'], err: ['#fee2e2', '#991b1b'] };
		var pair = colors[kind] || colors.busy;
		badge.style.background = pair[0];
		badge.style.color = pair[1];
		badge.innerHTML = '';
		badge.appendChild(document.createTextNode(text));
		badge.style.display = 'block';
	}

	function hideBadge() {
		if (badge) {
			badge.style.display = 'none';
		}
	}

	// ------------------------------------------------------------------ saving

	function snapshot() {
		return JSON.stringify(collect());
	}

	function failed(result) {
		if (result.off || result.stopped && stopped === 'off') {
			hideBadge(); // switched off on the server: the form simply works as before
		} else if (result.login || stopped === 'login') {
			setBadge('Your session has expired - ' + (state.lastOkAt ? 'the draft was saved at ' + formatTime(state.lastOkAt) : 'the draft could not be saved')
				+ '. Please log in again and reopen this form to continue.', 'err');
		} else if (result.offline) {
			setBadge('No connection - the draft will be saved when you are back online.', 'warn');
			if (state.offlineTries++ < 20) {
				schedule(30000);
			}
		} else if (result.message) {
			setBadge(result.message, 'warn');
		}
	}

	function schedule(delay) {
		if (state.timer || stopped) {
			return;
		}
		state.timer = setTimeout(function () {
			state.timer = null;
			saveServer();
		}, delay);
	}

	function saveServer() {
		if (!state.active || state.submitting || stopped) {
			return;
		}
		var wait = state.lastSentAt + MIN_GAP - Date.now();
		if (wait > 0) {
			schedule(wait);
			return;
		}
		var json = snapshot();
		if (json === state.lastSaved) {
			state.dirty = false;
			return;
		}
		state.lastSentAt = Date.now();
		request('POST', 'save.do', encode({ formKey: C.formKey, formTitle: title(), pageUrl: C.pageUrl, data: json }), function (result) {
			if (result.ok) {
				state.lastSaved = json;
				state.offlineTries = 0;
				state.lastOkAt = Date.now();
				state.dirty = snapshot() !== json;
				setBadge('Draft saved ' + formatTime(result.savedOn || Date.now()), 'ok');
				if (state.dirty) {
					schedule(WAIT_AFTER_TYPING);
				}
			} else {
				failed(result);
			}
		});
	}

	function changed() {
		if (!state.active || state.restoring || state.submitting || stopped) {
			return;
		}
		state.dirty = true;
		clearTimeout(state.timer);
		state.timer = null;
		schedule(Math.max(WAIT_AFTER_TYPING, state.lastSentAt + MIN_GAP - Date.now()));
	}

	function flush() {
		if (!state.active || state.submitting || !state.dirty || stopped) {
			return;
		}
		var json = snapshot();
		if (json !== state.lastSaved) {
			beacon('save.do', { formKey: C.formKey, formTitle: title(), pageUrl: C.pageUrl, data: json });
			state.lastSaved = json;
			state.dirty = false;
		}
	}

	// ------------------------------------------------------------------ documents

	function fileChanged(input) {
		if (state.restoring || state.submitting || stopped) {
			return;
		}
		if (!state.active) {
			if (state.earlyFiles.indexOf(input) < 0) {
				state.earlyFiles.push(input); // sent when auto-save starts
			}
			return;
		}
		var key = keyOf(input);
		if (!key || SKIP.test(key)) {
			return;
		}
		// after the page's own checks (they may clear a wrong file)
		setTimeout(function () {
			var files = input.files || [];
			if (!files.length) {
				request('POST', 'clearFile.do', encode({ formKey: C.formKey, field: key }), null);
				return;
			}
			var skipped = [];
			for (var i = 0; i < files.length && i < 20; i++) {
				if (files[i].size > MAX_FILE) {
					skipped.push(files[i].name);
				} else {
					uploadOne(key, i, files[i]);
				}
			}
			if (skipped.length) {
				setBadge('Larger than 5 MB, not kept in the draft (the form is not affected): ' + skipped.join(', '), 'warn');
			} else {
				setBadge('Saving document in the draft...', 'busy');
			}
		}, 0);
	}

	function uploadOne(key, index, file) {
		if (!window.FormData) {
			return;
		}
		var data = new FormData();
		data.append('formKey', C.formKey);
		data.append('formTitle', title());
		data.append('pageUrl', C.pageUrl);
		data.append('field', key);
		data.append('index', String(index));
		data.append('file', file, file.name);
		request('POST', 'uploadFile.do', data, function (result) {
			if (result.ok) {
				setBadge('Draft saved ' + formatTime(Date.now()) + ' (documents included)', 'ok');
			} else if (result.message) {
				setBadge('Document not kept in the draft: ' + result.message, 'warn');
			} else {
				failed(result);
			}
		}, true);
	}

	function toFile(blob, name, type) {
		try {
			return new File([blob], name, { type: type || blob.type });
		} catch (e) {
			return blob;
		}
	}

	/** Puts documents back into a file input (works in current Chrome, Edge and Firefox). */
	function setFiles(input, files) {
		if (!files.length || !window.DataTransfer) {
			return false;
		}
		try {
			var transfer = new DataTransfer();
			for (var i = 0; i < files.length && (i === 0 || input.multiple); i++) {
				transfer.items.add(files[i]);
			}
			input.files = transfer.files;
			fire(input, 'change'); // the page's own preview / checks
			return input.files.length > 0;
		} catch (e) {
			return false;
		}
	}

	/** Downloads the draft's documents one at a time and puts them back into the file inputs. */
	function restoreFiles(serverFiles, done) {
		var inputs = fileInputs();
		var byField = {};
		for (var i = 0; i < serverFiles.length; i++) {
			(byField[serverFiles[i].field] = byField[serverFiles[i].field] || []).push(serverFiles[i]);
		}
		var failedNames = [];
		var n = 0;
		function nextInput() {
			if (n >= inputs.length) {
				done(failedNames);
				return;
			}
			var input = inputs[n++];
			var saved = byField[input.key];
			if (!saved || !saved.length || !window.DataTransfer) {
				if (saved && saved.length) {
					failedNames.push(saved[0].name);
				}
				nextInput();
				return;
			}
			saved.sort(function (a, b) {
				return a.index - b.index;
			});
			var got = [];
			var s = 0;
			function nextFile() {
				if (s >= saved.length) {
					if (got.length < saved.length || !setFiles(input.el, got)) {
						failedNames.push(saved[0].name);
					}
					nextInput();
					return;
				}
				var item = saved[s++];
				download(item, function (file) {
					if (file) {
						got.push(file);
					}
					nextFile();
				});
			}
			nextFile();
		}
		nextInput();
	}

	function download(item, done) {
		var finished = false;
		function finish(file) {
			if (!finished) {
				finished = true;
				done(file);
			}
		}
		try {
			var xhr = new XMLHttpRequest();
			xhr.open('GET', URL + 'file.do?id=' + encodeURIComponent(item.id), true);
			xhr.responseType = 'blob';
			xhr.timeout = 2 * TIME_LIMIT;
			xhr.onreadystatechange = function () {
				if (xhr.readyState === 4) {
					finish(xhr.status === 200 && xhr.response ? toFile(xhr.response, item.name, item.type) : null);
				}
			};
			xhr.ontimeout = function () {
				finish(null);
			};
			xhr.send();
		} catch (e) {
			finish(null);
		}
	}

	// ------------------------------------------------------------------ resume / start new

	/** Auto-save on. baseline = the values already saved on the server; null = the form as the page opened it. */
	function start(baseline) {
		state.active = true;
		state.lastSaved = baseline !== null && baseline !== undefined ? baseline : state.initial;
		state.dirty = false;
		var early = state.earlyFiles;
		state.earlyFiles = [];
		for (var i = 0; i < early.length; i++) {
			fileChanged(early[i]);
		}
		if (snapshot() !== state.lastSaved) {
			changed();
		}
	}

	function resume(draft) {
		hideBar();
		state.restoring = true;
		setBadge('Restoring your draft...', 'busy');
		var fields = draft.fields || {};
		var delays = [0, 300, 900, 1800, 3000, 5000];
		var step = 0;
		function pass() {
			var missing = apply(fields);
			step++;
			if (step < delays.length && (missing > 0 || step < 3)) {
				setTimeout(pass, delays[step] - delays[step - 1]);
				return;
			}
			restoreFiles(draft.files || [], function (failedNames) {
				apply(fields); // once more: values a page script reset after a list / document change
				state.restoring = false;
				state.earlyFiles = []; // replaced by the draft's documents
				start(JSON.stringify(fields));
				if (failedNames.length) {
					showBar('Your draft is restored. Please choose these documents again: ' + failedNames.join(', '), [['OK', '#2563eb', hideBar]]);
				} else {
					setBadge('Draft restored - continue where you left off', 'ok');
				}
			});
		}
		pass();
	}

	function startNew() {
		hideBar();
		request('POST', 'discard.do', encode({ formKey: C.formKey }), null);
		start(null);
		setBadge('Auto-save is on', 'ok');
	}

	function hasValues(fields) {
		for (var k in fields) {
			if (fields.hasOwnProperty(k)) {
				var g = fields[k];
				var v = g.t === 'r' ? g.v : (g.v || []).join('');
				if (v && v !== 'false' && !/^(false,?)+$/.test(String(g.v))) {
					return true;
				}
			}
		}
		return false;
	}

	function init() {
		state.initial = snapshot();
		var onEdit = function (e) {
			try {
				var target = e.target;
				// only the citizen's own changes (C.testEvents: automated test only, never set by rtsDraft.jspf)
				if (!target || !target.tagName || state.restoring || stopped || (e.isTrusted === false && !C.testEvents)) {
					return;
				}
				if (bar && bar.contains && bar.contains(target)) {
					return;
				}
				if (target.type === 'file') {
					if (e.type === 'change') {
						fileChanged(target);
					}
					return;
				}
				changed();
			} catch (err) {
				// never break the form
			}
		};
		document.addEventListener('input', onEdit, false);
		document.addEventListener('change', onEdit, false);
		window.addEventListener('pagehide', flush, false);
		document.addEventListener('visibilitychange', function () {
			if (document.visibilityState === 'hidden') {
				flush();
			}
		}, false);
		window.addEventListener('online', function () {
			if (state.dirty) {
				state.offlineTries = 0;
				saveServer();
			}
		}, false);
		watchSubmit();

		request('GET', 'load.do?formKey=' + encodeURIComponent(C.formKey) + '&t=' + Date.now(), null, function (result) {
			if (!result.ok) {
				if (result.offline) {
					start(null); // the draft could not be checked: save from now on
				}
				return; // session expired / switched off: nothing at all on the page
			}
			var server = result.draft;
			var fields = server ? parse(server.data) || {} : {};
			var files = server && server.files ? server.files : [];
			if (server && (hasValues(fields) || files.length)) {
				var draft = { ts: server.savedOn, fields: fields, files: files };
				showBar('You have an unfinished application saved on ' + formatTime(draft.ts) + (files.length ? ' with ' + files.length + ' document(s)' : '')
					+ '. Resume it, or start a new one? (Auto-save is paused until you choose.)',
					[['Resume', '#16a34a', function () {
						resume(draft);
					}], ['Start new', '#64748b', function () {
						if (window.confirm('Delete the saved draft and start a new application?')) {
							startNew();
						}
					}]]);
			} else {
				start(null);
			}
		});
	}

	/** The application is being submitted: stop saving; the success page deletes the draft. */
	function watchSubmit() {
		function submitting() {
			if (state.submitting) {
				return;
			}
			flush();
			state.submitting = true;
			clearTimeout(state.timer);
			state.timer = null;
			beacon('submitted.do', { formKey: C.formKey });
			// still on the form after a while (the page did not go on, e.g. a check failed): saving continues
			setTimeout(function () {
				state.submitting = false;
			}, 15000);
		}
		var nativeSubmit = window.HTMLFormElement && HTMLFormElement.prototype.submit;
		if (nativeSubmit && typeof form.submit === 'function') {
			try {
				form.submit = function () {
					try {
						submitting();
					} catch (e) {
						// the form is submitted anyway
					}
					return nativeSubmit.apply(form, arguments);
				};
			} catch (e) {
				// the page keeps its own submit
			}
		}
		form.addEventListener('submit', function (e) {
			setTimeout(function () {
				try {
					if (!e.defaultPrevented) {
						submitting();
					}
				} catch (err) {
					// ignore
				}
			}, 0);
		}, false);
	}

	try {
		if (document.readyState === 'loading') {
			document.addEventListener('DOMContentLoaded', function () {
				try {
					init();
				} catch (e) {
					// never break the form
				}
			}, false);
		} else {
			init();
		}
	} catch (e) {
		// never break the form
	}
})();
