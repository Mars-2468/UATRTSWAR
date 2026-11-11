<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.include file="/pages/core-pages/nmc_user/dashboard/header.jsp" />
<jsp:directive.include file="/pages/core-pages/rtsappeal/rtsAppealStyles.jspf" />
<%-- Citizen: appeal form = the complete application form (editable, documents replaceable) + reason for appeal --%>

<c:set var="app" value="${row.application}"/>
<c:set var="levelLabel" value="${row.appealLevelAllowed == 2 ? 'Second Appeal' : 'First Appeal'}"/>
<c:set var="baseNo" value="${fn:replace(fn:replace(app.rtiApplnNumber, '_SA', ''), '_FA', '')}"/>

<div class="ap-page">
	<div class="ap-head">
		<div>
			<h2><c:out value="${levelLabel}"/> - <c:out value="${row.serviceName}"/></h2>
			<p class="ap-sub">Application <b><c:out value="${app.rtiApplnNumber}"/></b> will continue as
				<b><c:out value="${baseNo}"/><c:out value="${row.appealLevelAllowed == 2 ? '_SA' : '_FA'}"/></b>.
				You can correct the form and replace documents before submitting the appeal.</p>
		</div>
		<a class="ap-btn ap-btn-light" href="<c:out value='${contextRoot}'/>/ws/dashboard/myapplication.do">Back</a>
	</div>

	<c:if test="${not empty errMessage}">
		<div class="ap-alert ap-alert-error"><c:out value="${errMessage}"/></div>
	</c:if>

	<div class="ap-card">
		<div class="ap-card-head">Application Details</div>
		<div class="ap-card-body">
			<div class="ap-grid">
				<div class="ap-field"><label>Application Id</label><div><c:out value="${app.rtiApplnNumber}"/></div></div>
				<div class="ap-field"><label>Service Name</label><div><c:out value="${row.serviceName}"/></div></div>
				<div class="ap-field"><label>Applicant Name</label><div><c:out value="${app.applicantName}"/></div></div>
				<div class="ap-field"><label>Mobile Number</label><div><c:out value="${app.mobileNumber}"/></div></div>
				<div class="ap-field"><label>Application Date</label><div><c:out value="${app.createdDate}"/></div></div>
				<div class="ap-field"><label>Current Status</label><div><c:out value="${row.statusLabel}"/></div></div>
				<div class="ap-field"><label>Maximum days for issuing certificate</label><div><c:out value="${row.maxDays}"/></div></div>
				<div class="ap-field"><label>Expected service Delivery date</label><div><c:out value="${row.expectedDeliveryDate}"/></div></div>
				<c:if test="${row.rejected}">
					<div class="ap-field" style="grid-column: 1 / -1"><label>Rejection reason</label>
						<div class="ap-err-text"><c:out value="${empty row.rejectionReason ? '-' : row.rejectionReason}"/></div></div>
				</c:if>
			</div>
		</div>
	</div>

	<c:if test="${row.appealLevelAllowed == 2 and not empty row.firstAppeal}">
		<div class="ap-card">
			<div class="ap-card-head">First Appeal <c:out value="${row.firstAppeal.appealNumber}"/></div>
			<div class="ap-card-body">
				<div class="ap-grid">
					<div class="ap-field"><label>Status</label><div><c:out value="${row.firstAppeal.statusLabel}"/></div></div>
					<div class="ap-field" style="grid-column: span 2"><label>Decision of the First Appellate Officer</label>
						<div><c:out value="${empty row.firstAppeal.closedRemark ? row.firstAppeal.appellateRemark : row.firstAppeal.closedRemark}"/></div></div>
				</div>
			</div>
		</div>
	</c:if>

	<input type="hidden" name="rtiApplnNumber" value="<c:out value='${app.rtiApplnNumber}'/>"/>

	<%-- the application form, section by section --%>
	<c:forEach items="${sections}" var="section">
		<c:if test="${section.key != 'Documents' and not empty section.value}">
			<div class="ap-card">
				<div class="ap-card-head"><c:out value="${section.key}"/></div>
				<div class="ap-card-body">
					<div class="ap-form-grid">
						<c:forEach items="${section.value}" var="f">
							<c:set var="fv" value="${not empty posted[f.name] ? posted[f.name] : f.value}"/>
							<%-- rules of the citizen application form, checked by apFieldError() and again on the server --%>
							<c:set var="rules">data-label="<c:out value='${f.label}'/>" data-orig="<c:out value='${f.value}'/>"<c:if
								test="${f.required}"> data-req="1" required="required"</c:if><c:if
								test="${not empty f.message}"> data-msg="<c:out value='${f.message}'/>"</c:if><c:if
								test="${not empty f.pattern}"> data-pattern="<c:out value='${f.pattern}'/>"</c:if><c:if
								test="${not empty f.minLength}"> minlength="${f.minLength}"</c:if><c:if
								test="${not empty f.min}"> min="<c:out value='${f.min}'/>"</c:if><c:if
								test="${not empty f.max}"> max="<c:out value='${f.max}'/>"</c:if><c:if
								test="${not empty f.minAge}"> data-minage="${f.minAge}"</c:if><c:if
								test="${not empty f.ageTarget}"> data-age-target="<c:out value='${f.ageTarget}'/>"</c:if></c:set>
							<div class="ap-form-row ${f.type == 'TEXTAREA' ? 'ap-span-2' : ''}">
								<label for="${f.name}"><c:out value="${f.label}"/><c:if test="${f.required}"> <span class="ap-req">*</span></c:if></label>
								<c:choose>
									<c:when test="${not f.editable}">
										<input type="text" id="${f.name}" name="${f.name}" class="ap-readonly" readonly="readonly"
											value="<c:out value='${f.value}'/>"<c:if test="${not empty f.joinOf}"> data-join="<c:out value='${f.joinOf}'/>"</c:if>/>
									</c:when>
									<c:when test="${f.type == 'SELECT'}">
										<select id="${f.name}" name="${f.name}" ${rules}>
											<option value="">-- Select --</option>
											<c:forEach items="${f.choices}" var="o">
												<option value="<c:out value='${o[0]}'/>" ${o[0] == fv ? 'selected="selected"' : ''}><c:out value="${o[1]}"/></option>
											</c:forEach>
										</select>
									</c:when>
									<c:when test="${f.type == 'RADIO'}">
										<div class="ap-radios">
											<c:forEach items="${f.choices}" var="o" varStatus="os">
												<label class="ap-radio"><input type="radio" id="${f.name}${os.first ? '' : os.index}" name="${f.name}"
													value="<c:out value='${o[0]}'/>" ${o[0] == fv ? 'checked="checked"' : ''} ${rules}/> <c:out value="${o[1]}"/></label>
											</c:forEach>
										</div>
									</c:when>
									<c:when test="${f.type == 'TEXTAREA'}">
										<textarea id="${f.name}" name="${f.name}" maxlength="${f.maxLength > 0 ? f.maxLength : 2000}" ${rules}><c:out value="${fv}"/></textarea>
									</c:when>
									<c:when test="${f.type == 'DATE'}">
										<input type="date" id="${f.name}" name="${f.name}" value="<c:out value='${fv}'/>" ${rules}/>
									</c:when>
									<c:when test="${f.type == 'NUMBER'}">
										<input type="number" step="any" id="${f.name}" name="${f.name}" value="<c:out value='${fv}'/>" ${rules}/>
									</c:when>
									<c:otherwise>
										<input type="${f.inputType == 'email' ? 'email' : 'text'}" id="${f.name}" name="${f.name}"
											maxlength="${f.maxLength > 0 ? f.maxLength : 250}" value="<c:out value='${fv}'/>" ${rules}/>
									</c:otherwise>
								</c:choose>
								<div class="ap-field-err" id="err_${f.name}"></div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</c:if>
	</c:forEach>

	<%-- documents: view the uploaded one, choose a file only to replace it --%>
	<div class="ap-card">
		<div class="ap-card-head">Documents</div>
		<div class="ap-card-body">
			<c:forEach items="${sections['Documents']}" var="d">
				<div class="ap-doc">
					<span class="ap-doc-name"><c:out value="${d.label}"/></span>
					<c:choose>
						<c:when test="${not empty d.files}">
							<%-- by field name and file number: the server path is never put in the page --%>
							<c:forEach items="${d.files}" varStatus="fs">
								<a class="ap-btn ap-btn-light ap-btn-xs" href="#" data-doc="<c:out value='${d.name}'/>" data-i="${fs.index}"
									onclick="apDocView(this); return false;">View<c:if test="${fn:length(d.files) > 1}"> ${fs.count}</c:if></a>
							</c:forEach>
						</c:when>
						<c:otherwise><span class="ap-small ap-muted">Not uploaded</span></c:otherwise>
					</c:choose>
					<span class="ap-small">Replace:</span>
					<input type="file" name="${d.name}" accept=".pdf,.jpg,.jpeg,.png"/>
				</div>
			</c:forEach>
			<div class="ap-doc">
				<span class="ap-doc-name">Additional documents (optional)</span>
				<input type="file" name="file_portalDocNew" accept=".pdf,.jpg,.jpeg,.png" multiple="multiple"/>
			</div>
			<p class="ap-small ap-muted" style="margin: 8px 0 0">PDF, JPG or PNG, up to 10 MB each. Leave a file empty to keep the uploaded document.</p>
		</div>
	</div>

	<div class="ap-card">
		<div class="ap-card-head">Appeal</div>
		<div class="ap-card-body">
			<div class="ap-form-row">
				<label for="appealReasonCode">Reason for Appeal <span class="ap-req">*</span></label>
				<select id="appealReasonCode" name="appealReasonCode">
					<option value="">-- Select --</option>
					<option value="1" ${selectedReasonCode == 1 ? 'selected="selected"' : ''} ${row.rejected ? 'disabled="disabled"' : ''}>
						1. Public service not provided within stipulated time period</option>
					<option value="2" ${selectedReasonCode == 2 ? 'selected="selected"' : ''} ${row.rejected ? '' : 'disabled="disabled"'}>
						2. Rejection of application</option>
				</select>
			</div>
			<div class="ap-form-row">
				<label for="citizenRemarks">Remarks (optional)</label>
				<textarea id="citizenRemarks" name="citizenRemarks" maxlength="2000"
					placeholder="Explain why you are filing this appeal"><c:out value="${citizenRemarks}"/></textarea>
			</div>
			<div class="ap-form-row ap-small">
				The appeal will be sent to the <b><c:out value="${row.appealLevelAllowed == 2 ? sla.secondAppellateOfficer : sla.firstAppellateOfficer}"/></b>
				(<c:out value="${row.appealLevelAllowed == 2 ? 'Second' : 'First'}"/> Appellate Officer). After the officer's remark / order the
				application continues with the department from where it stopped.
			</div>
			<div class="ap-actions">
				<button type="button" id="apSubmitBtn" class="ap-btn ap-btn-green" onclick="apSubmitAppeal()">Submit Appeal</button>
				<a class="ap-btn ap-btn-light" href="<c:out value='${contextRoot}'/>/ws/dashboard/myapplication.do">Cancel</a>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	function apDocView(link) {
		window.open('<c:out value="${contextRoot}"/>/ws/rtsappeal/viewDocument.do?rtiApplnNumber='
				+ encodeURIComponent(document.querySelector('input[name="rtiApplnNumber"]').value)
				+ '&doc=' + encodeURIComponent(link.getAttribute('data-doc'))
				+ '&i=' + encodeURIComponent(link.getAttribute('data-i')), '_blank');
	}

	<%-- the validations of the citizen application form; only values the citizen changed are checked
	     (the same checks run again on the server) --%>
	function apFieldValue(el) {
		if (el.type === 'radio') {
			var checked = document.querySelector('input[name="' + el.name + '"]:checked');
			return checked ? checked.value : '';
		}
		return (el.value || '').replace(/^\s+|\s+$/g, '');
	}

	function apAge(value) {
		var dob = new Date(value + 'T00:00:00');
		var now = new Date();
		var years = now.getFullYear() - dob.getFullYear();
		var months = now.getMonth() - dob.getMonth();
		if (now.getDate() < dob.getDate()) { months--; }
		if (months < 0) { years--; months += 12; }
		return [years, months];
	}

	function apFieldError(el) {
		var v = apFieldValue(el);
		var orig = el.getAttribute('data-orig') || '';
		if (v === orig) {
			return null;
		}
		var label = el.getAttribute('data-label') || el.name;
		var msg = el.getAttribute('data-msg');
		var invalid = msg ? label + ': ' + msg : 'Please enter a valid value for "' + label + '".';
		if (!v) {
			return el.getAttribute('data-req') ? '"' + label + '" is required and cannot be left empty.' : null;
		}
		var length = v.replace(/[\uD800-\uDBFF][\uDC00-\uDFFF]/g, '_').length;
		var max = parseInt(el.getAttribute('maxlength'), 10);
		var min = parseInt(el.getAttribute('minlength'), 10);
		if (max > 0 && length > max) {
			return '"' + label + '" can have at most ' + max + ' characters.';
		}
		if (min > 0 && length < min) {
			return '"' + label + '" must have at least ' + min + ' characters.';
		}
		var pattern = el.getAttribute('data-pattern');
		if (pattern) {
			var re = null;
			try { re = new RegExp('^(?:' + pattern + ')$', 'u'); } catch (e1) {
				try { re = new RegExp('^(?:' + pattern + ')$'); } catch (e2) { re = null; }
			}
			if (re && !re.test(v)) {
				return invalid;
			}
		}
		if (el.type === 'email' && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v)) {
			return invalid;
		}
		var lo = el.getAttribute('min'), hi = el.getAttribute('max');
		if (el.type === 'number') {
			if (isNaN(Number(v))) {
				return invalid;
			}
			if ((lo !== null && lo !== '' && Number(v) < Number(lo)) || (hi !== null && hi !== '' && Number(v) > Number(hi))) {
				return '"' + label + '" must be' + (lo ? ' at least ' + lo : '') + (lo && hi ? ' and' : '') + (hi ? ' at most ' + hi : '') + '.';
			}
		}
		if (el.type === 'date') {
			if (!/^\d{4}-\d{2}-\d{2}$/.test(v) || (lo && v < lo) || (hi && v > hi)) {
				return invalid;
			}
			var minAge = parseInt(el.getAttribute('data-minage'), 10);
			if (minAge > 0 && apAge(v)[0] < minAge) {
				return label + ': age must be at least ' + minAge + ' years.';
			}
		}
		return null;
	}

	function apMark(el) {
		var error = apFieldError(el);
		var box = document.getElementById('err_' + el.name);
		if (box) {
			box.innerHTML = '';
			if (error) { box.appendChild(document.createTextNode(error)); }
		}
		var group = el.type === 'radio' ? document.querySelectorAll('input[name="' + el.name + '"]') : [el];
		for (var i = 0; i < group.length; i++) {
			group[i].className = group[i].className.replace(/\s*ap-invalid|\s*ap-changed/g, '')
				+ (error ? ' ap-invalid' : (apFieldValue(el) !== (el.getAttribute('data-orig') || '') ? ' ap-changed' : ''));
		}
		return error;
	}

	function apCheckForm() {
		var fields = document.querySelectorAll('.ap-form-grid [data-label]');
		var first = null, done = {};
		for (var i = 0; i < fields.length; i++) {
			if (done[fields[i].name]) { continue; }
			done[fields[i].name] = true;
			var error = apMark(fields[i]);
			if (error && !first) { first = { el: fields[i], error: error }; }
		}
		if (first) {
			alert(first.error);
			first.el.focus();
			return false;
		}
		return true;
	}

	<%-- read-only fields the application form fills itself: full name and "N Years/M Months" --%>
	function apDerived() {
		var joined = document.querySelectorAll('[data-join]');
		for (var i = 0; i < joined.length; i++) {
			var parts = joined[i].getAttribute('data-join').split(','), text = [];
			for (var j = 0; j < parts.length; j++) {
				var part = document.getElementById(parts[j]);
				if (part && part.value.replace(/^\s+|\s+$/g, '')) { text.push(part.value.replace(/^\s+|\s+$/g, '')); }
			}
			joined[i].value = text.join(' ');
		}
		var dates = document.querySelectorAll('[data-age-target]');
		for (var k = 0; k < dates.length; k++) {
			var target = document.getElementById(dates[k].getAttribute('data-age-target'));
			if (target && dates[k].value && dates[k].value !== (dates[k].getAttribute('data-orig') || '')) {
				var age = apAge(dates[k].value);
				target.value = age[0] + ' Years/' + age[1] + ' Months';
			}
		}
	}

	(function () {
		var fields = document.querySelectorAll('.ap-form-grid [data-label]');
		for (var i = 0; i < fields.length; i++) {
			fields[i].onchange = function () { apMark(this); apDerived(); };
			if (fields[i].tagName !== 'SELECT' && fields[i].type !== 'radio') {
				fields[i].oninput = apDerived;
			}
		}
	})();

	function apSubmitAppeal() {
		if (!apCheckForm()) {
			return;
		}
		var reason = document.getElementById('appealReasonCode');
		if (!reason.value) {
			alert('Please select the reason for appeal.');
			reason.focus();
			return;
		}
		var files = document.frmPage.querySelectorAll('input[type=file]');
		for (var i = 0; i < files.length; i++) {
			for (var j = 0; j < files[i].files.length; j++) {
				var file = files[i].files[j];
				if (!/\.(pdf|jpe?g|png)$/i.test(file.name)) {
					alert('Only PDF, JPG or PNG files can be uploaded: ' + file.name);
					return;
				}
				if (file.size > 10 * 1024 * 1024) {
					alert('Each file must be smaller than 10 MB: ' + file.name);
					return;
				}
			}
		}
		if (!confirm('Submit the <c:out value="${levelLabel}"/> for application <c:out value="${app.rtiApplnNumber}"/>?')) {
			return;
		}
		var button = document.getElementById('apSubmitBtn');
		button.disabled = true;
		button.innerHTML = 'Submitting...';
		<%-- the page layout's form is not multipart; switch it before submitting --%>
		document.frmPage.enctype = 'multipart/form-data';
		document.frmPage.encoding = 'multipart/form-data';
		document.frmPage.action = '<c:out value="${contextRoot}"/>/ws/rtsappeal/submitAppeal.do';
		document.frmPage.submit();
	}
</script>
