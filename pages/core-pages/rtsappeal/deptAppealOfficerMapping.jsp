<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.include file="/pages/core-pages/rtsappeal/rtsAppealStyles.jspf" />
<%-- Appellate Officer Mapping: who receives the First / Second Appeals of each service (per zone or all zones) --%>
<style type="text/css">
	.am-steps { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 10px; margin-bottom: 14px; }
	.am-step { background: #f4f8fc; border: 1px solid #dbe3ec; border-radius: 8px; padding: 10px 12px; font-size: 13px; }
	.am-step b { display: block; color: #0f3d6e; margin-bottom: 2px; }
	.am-num { display: inline-block; width: 22px; height: 22px; border-radius: 50%; background: #0f5fa8; color: #fff; text-align: center;
		line-height: 22px; font-size: 12px; margin-right: 6px; }
	.am-chip { display: inline-flex; align-items: center; gap: 6px; background: #e0edfb; color: #0f3d6e; border-radius: 14px;
		padding: 3px 4px 3px 10px; font-size: 12px; margin: 2px 4px 2px 0; }
	.am-chip small { color: #4b5563; }
	.am-chip button { border: 0; background: #fff; color: #b42318; border-radius: 50%; width: 20px; height: 20px; cursor: pointer;
		font-weight: 700; line-height: 18px; padding: 0; }
	.am-missing { color: #b42318; font-weight: 600; font-size: 12px; }
	.am-designation { font-size: 12px; color: #6b7280; margin-bottom: 3px; }
	.am-toolbar { display: flex; gap: 10px; flex-wrap: wrap; align-items: center; padding: 10px 14px; border-bottom: 1px solid #e5ebf1; }
	.am-toolbar select, .am-toolbar input { padding: 6px 8px; border: 1px solid #c8d2dd; border-radius: 5px; font-size: 13px; }
	.am-form select, .am-form input[type=text] { width: 100%; padding: 8px; border: 1px solid #c8d2dd; border-radius: 5px; font-size: 14px; box-sizing: border-box; }
	.am-level { display: flex; gap: 10px; }
	.am-level label { flex: 1; border: 1px solid #c8d2dd; border-radius: 6px; padding: 8px 10px; cursor: pointer; font-weight: 400 !important; }
	.am-level input { margin-right: 6px; }
	.am-hint { font-size: 12px; color: #0f5fa8; margin-top: 4px; min-height: 16px; }
</style>

<div class="ap-page">
	<div class="ap-head">
		<div>
			<h3>Appellate Officer Mapping</h3>
			<p class="ap-sub">Choose who receives the First and Second Appeals of each RTS service. An appeal goes to the officers mapped
				for its service and zone (or for all zones).</p>
		</div>
		<a class="ap-btn ap-btn-light" href="<c:out value='${contextRoot}'/>/rtsappeal/listAppeals.do">Appeal Applications</a>
	</div>

	<c:if test="${not empty rtsAppealError}">
		<div class="ap-alert ap-alert-error"><c:out value="${rtsAppealError}"/></div>
	</c:if>
	<c:if test="${not empty rtsAppealMessage}">
		<div class="ap-alert ap-alert-ok"><c:out value="${rtsAppealMessage}"/></div>
	</c:if>

	<div class="am-steps">
		<div class="am-step"><b><span class="am-num">1</span>Citizen files an appeal</b>When no action is taken within the SLA, or the application is rejected.</div>
		<div class="am-step"><b><span class="am-num">2</span>First Appellate Officer</b>Gives remark / order and sends the application back to the department.</div>
		<div class="am-step"><b><span class="am-num">3</span>Second Appellate Officer</b>Receives the Second Appeal if the citizen is still not satisfied.</div>
	</div>

	<div class="ap-card am-form" id="amFormCard">
		<div class="ap-card-head">Assign an Appellate Officer</div>
		<div class="ap-card-body">
			<div class="ap-form-grid">
				<div class="ap-form-row">
					<label for="amDept">Department</label>
					<select id="amDept" onchange="amFillServices()">
						<option value="">All departments</option>
						<c:forEach items="${departments}" var="d"><option value="<c:out value='${d}'/>"><c:out value="${d}"/></option></c:forEach>
					</select>
				</div>
				<div class="ap-form-row">
					<label for="officerServiceId">Service <span class="ap-req">*</span></label>
					<select id="officerServiceId" name="officerServiceId" onchange="amShowDesignation()">
						<option value="">-- Select service --</option>
					</select>
				</div>
				<div class="ap-form-row ap-span-2">
					<label>Appeal <span class="ap-req">*</span></label>
					<div class="am-level">
						<label><input type="radio" name="officerLevel" value="1" checked="checked" onclick="amShowDesignation()"/>First Appellate Officer</label>
						<label><input type="radio" name="officerLevel" value="2" onclick="amShowDesignation()"/>Second Appellate Officer</label>
					</div>
					<div class="am-hint" id="amDesignation"></div>
				</div>
				<div class="ap-form-row">
					<label for="officerZone">Zone</label>
					<select id="officerZone" name="officerZone">
						<option value="">All zones</option>
						<c:forEach items="${zones}" var="z"><option value="${z.zoneId}"><c:out value="${z.zoneName}"/> (<c:out value="${z.zoneId}"/>)</option></c:forEach>
					</select>
				</div>
				<div class="ap-form-row ap-span-2">
					<label for="officerUserName">Officer login <span class="ap-req">*</span></label>
					<input type="text" id="officerUserName" name="officerUserName" list="amUsers" autocomplete="off"
						placeholder="Type the login or the officer's name"/>
					<datalist id="amUsers">
						<c:forEach items="${users}" var="u"><option value="<c:out value='${u.userName}'/>"><c:out value="${u.name}"/></option></c:forEach>
					</datalist>
				</div>
			</div>
			<div class="ap-actions" style="margin-top: 12px">
				<button type="button" class="ap-btn ap-btn-green" onclick="amSave()">Assign</button>
				<span class="ap-small ap-muted">The same officer can be assigned to several services and zones.</span>
			</div>
		</div>
	</div>

	<div class="ap-card">
		<div class="am-toolbar">
			<b style="color: #0f3d6e">Services (<c:out value="${fn:length(rows)}"/>)</b>
			<c:if test="${unmappedCount > 0}"><span class="ap-badge ap-badge-err"><c:out value="${unmappedCount}"/> service(s) without an officer</span></c:if>
			<span style="flex: 1"></span>
			<select id="amFilterDept" onchange="amFilter()">
				<option value="">All departments</option>
				<c:forEach items="${departments}" var="d"><option value="<c:out value='${d}'/>"><c:out value="${d}"/></option></c:forEach>
			</select>
			<input type="text" id="amSearch" placeholder="Search service or login" onkeyup="amFilter()"/>
			<label class="ap-small"><input type="checkbox" id="amOnlyMissing" onclick="amFilter()"/> Only not mapped</label>
		</div>
		<div class="ap-table-wrap">
			<table class="ap-table" id="amTable">
				<thead>
					<tr><th>Department</th><th>Service</th><th style="text-align: center">SLA (days)</th>
						<th>First Appellate Officer</th><th>Second Appellate Officer</th><th></th></tr>
				</thead>
				<tbody>
					<c:if test="${empty rows}">
						<tr><td colspan="6" class="ap-empty">No services configured. Run the RTS appeal database scripts first.</td></tr>
					</c:if>
					<c:forEach items="${rows}" var="r">
						<c:set var="s" value="${r.sla}"/>
						<tr data-dept="<c:out value='${s.departmentName}'/>" data-missing="${empty r.first or empty r.second}">
							<td><c:out value="${s.departmentName}"/></td>
							<td><b><c:out value="${s.serviceName}"/></b></td>
							<td style="text-align: center"><c:out value="${s.slaDays}"/></td>
							<c:forTokens items="first,second" delims="," var="lvl">
								<c:set var="list" value="${lvl == 'first' ? r.first : r.second}"/>
								<td>
									<div class="am-designation"><c:out value="${lvl == 'first' ? s.firstAppellateOfficer : s.secondAppellateOfficer}"/></div>
									<c:forEach items="${list}" var="m">
										<span class="am-chip" title="<c:out value='${userNames[m.userName]}'/>">
											<span><c:out value="${m.userName}"/> <small><c:out value="${empty m.zone ? 'all zones' : 'zone '}"/><c:out value="${m.zone}"/></small></span>
											<button type="button" title="Remove" onclick="amRemove(${m.rtsAppellateOfficerId}, '<c:out value="${m.userName}"/>')">&times;</button>
										</span>
									</c:forEach>
									<c:if test="${empty list}"><span class="am-missing">Not mapped</span></c:if>
								</td>
							</c:forTokens>
							<td><button type="button" class="ap-btn ap-btn-blue ap-btn-xs" onclick="amAssignFor(${s.rtiServiceId})">Assign</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

	<input type="hidden" name="toggleId" id="amToggleId" value=""/>
	<input type="hidden" name="active" id="amToggleActive" value=""/>
</div>

<script type="text/javascript">
	var amServices = [
		<c:forEach items="${slaList}" var="s" varStatus="st">
		{ id: '${s.rtiServiceId}', name: '<c:out value="${s.serviceName}"/>', dept: '<c:out value="${s.departmentName}"/>',
		  first: '<c:out value="${s.firstAppellateOfficer}"/>', second: '<c:out value="${s.secondAppellateOfficer}"/>' }${st.last ? '' : ','}
		</c:forEach>
	];

	function amDecode(text) {
		var div = document.createElement('div');
		div.innerHTML = text;
		return div.textContent;
	}

	function amFillServices(selected) {
		var dept = amDecode(document.getElementById('amDept').value);
		var select = document.getElementById('officerServiceId');
		select.options.length = 1;
		for (var i = 0; i < amServices.length; i++) {
			if (!dept || amDecode(amServices[i].dept) === dept) {
				var option = new Option(amDecode(amServices[i].name), amServices[i].id);
				option.selected = amServices[i].id === String(selected);
				select.options.add(option);
			}
		}
		amShowDesignation();
	}

	function amLevel() {
		var radios = document.getElementsByName('officerLevel');
		for (var i = 0; i < radios.length; i++) {
			if (radios[i].checked) {
				return radios[i].value;
			}
		}
		return '1';
	}

	function amShowDesignation() {
		var id = document.getElementById('officerServiceId').value;
		var hint = '';
		for (var i = 0; i < amServices.length; i++) {
			if (amServices[i].id === id) {
				var designation = amDecode(amLevel() === '2' ? amServices[i].second : amServices[i].first);
				hint = designation ? 'As per the SLA list this officer is the ' + designation + '.' : '';
			}
		}
		document.getElementById('amDesignation').innerHTML = '';
		document.getElementById('amDesignation').appendChild(document.createTextNode(hint));
	}

	function amAssignFor(serviceId) {
		document.getElementById('amDept').value = '';
		amFillServices(serviceId);
		document.getElementById('officerUserName').focus();
		document.getElementById('amFormCard').scrollIntoView({ behavior: 'smooth' });
	}

	function amSave() {
		if (!document.getElementById('officerServiceId').value) {
			alert('Please select the service.');
			return;
		}
		if (!document.getElementById('officerUserName').value.replace(/\s/g, '')) {
			alert('Please enter the officer login.');
			return;
		}
		document.getElementById('amToggleId').value = '';
		document.frmPage.action = '<c:out value="${contextRoot}"/>/rtsappeal/saveAppellateOfficer.do';
		document.frmPage.submit();
	}

	function amRemove(id, login) {
		if (!confirm('Remove ' + login + ' as Appellate Officer of this service?')) {
			return;
		}
		document.getElementById('amToggleId').value = id;
		document.getElementById('amToggleActive').value = '0';
		document.frmPage.action = '<c:out value="${contextRoot}"/>/rtsappeal/saveAppellateOfficer.do';
		document.frmPage.submit();
	}

	function amFilter() {
		var dept = amDecode(document.getElementById('amFilterDept').value);
		var text = document.getElementById('amSearch').value.toLowerCase();
		var onlyMissing = document.getElementById('amOnlyMissing').checked;
		var rows = document.getElementById('amTable').tBodies[0].rows;
		for (var i = 0; i < rows.length; i++) {
			var row = rows[i];
			if (!row.getAttribute('data-dept') && row.cells.length === 1) {
				continue;
			}
			var show = (!dept || row.getAttribute('data-dept') === dept)
					&& (!text || row.textContent.toLowerCase().indexOf(text) >= 0)
					&& (!onlyMissing || row.getAttribute('data-missing') === 'true');
			row.style.display = show ? '' : 'none';
		}
	}

	amFillServices();
</script>
