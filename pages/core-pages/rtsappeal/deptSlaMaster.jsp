<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.include file="/pages/core-pages/rtsappeal/rtsAppealStyles.jspf" />
<%-- Administrator: RTS Services SLA Master (egovrti.rts_service_sla). Technical settings (department id, workflow,
     appeal statuses) are maintained at the back end and only carried through as hidden fields. --%>

<div class="ap-page">
	<div class="ap-head">
		<div>
			<h3>RTS Services SLA Master</h3>
			<p class="ap-sub">Per service: the time limit (SLA) for delivering the service, the First and Second Appellate Officers and
				whether citizens may appeal. These settings apply to all new appeals.</p>
		</div>
		<div class="ap-actions">
			<a class="ap-btn ap-btn-light" href="<c:out value='${contextRoot}'/>/rtsappeal/appellateOfficers.do">Appellate Officer Mapping</a>
		</div>
	</div>

	<c:if test="${not empty rtsAppealError}"><div class="ap-alert ap-alert-error"><c:out value="${rtsAppealError}"/></div></c:if>
	<c:if test="${not empty rtsAppealMessage}"><div class="ap-alert ap-alert-ok"><c:out value="${rtsAppealMessage}"/></div></c:if>

	<c:if test="${not empty edit}">
		<div class="ap-card" id="apSlaEdit">
			<div class="ap-card-head"><c:out value="${edit.rtsServiceSlaId > 0 ? 'Edit' : 'Add'}"/> service:
				<c:out value="${edit.serviceName}"/></div>
			<div class="ap-card-body">
				<div id="apSlaForm">
					<input type="hidden" name="rtiServiceId" value="<c:out value='${edit.rtiServiceId}'/>"/>
					<%-- technical settings: kept as they are --%>
					<input type="hidden" name="departmentId" value="<c:out value='${edit.departmentId}'/>"/>
					<input type="hidden" name="workflowProcessName" value="<c:out value='${edit.workflowProcessName}'/>"/>
					<input type="hidden" name="delayAppealStatuses" value="<c:out value='${edit.delayAppealStatuses}'/>"/>
					<input type="hidden" name="rejectionStatuses" value="<c:out value='${edit.rejectionStatuses}'/>"/>
					<div class="ap-form-grid">
						<div class="ap-form-row"><label>Service name *</label>
							<input type="text" name="serviceName" maxlength="200" required="required" value="<c:out value='${edit.serviceName}'/>"/></div>
						<div class="ap-form-row"><label>Department</label>
							<input type="text" name="departmentName" maxlength="200" value="<c:out value='${edit.departmentName}'/>"/></div>
						<div class="ap-form-row"><label>SLA (maximum days) *</label>
							<input type="number" name="slaDays" min="1" max="365" required="required" value="<c:out value='${edit.slaDays}'/>"/></div>
						<div class="ap-form-row"><label>SLA counted from (hours after submission) *</label>
							<input type="number" name="slaStartHours" min="0" max="240" required="required" value="<c:out value='${edit.slaStartHours}'/>"/></div>
						<div class="ap-form-row"><label>First Appellate Officer (designation)</label>
							<input type="text" name="firstAppellateOfficer" maxlength="200" value="<c:out value='${edit.firstAppellateOfficer}'/>"/></div>
						<div class="ap-form-row"><label>Second Appellate Officer (designation)</label>
							<input type="text" name="secondAppellateOfficer" maxlength="200" value="<c:out value='${edit.secondAppellateOfficer}'/>"/></div>
						<div class="ap-form-row"><label>Appeal enabled</label>
							<label class="ap-radio"><input type="checkbox" name="isAppealEnabled" value="1" ${edit.isAppealEnabled == 1 ? 'checked="checked"' : ''}/> Citizens may appeal</label></div>
					</div>
					<div class="ap-actions" style="margin-top: 12px">
						<button type="button" class="ap-btn ap-btn-green" onclick="apSlaSave()">Save</button>
						<a class="ap-btn ap-btn-light" href="<c:out value='${contextRoot}'/>/rtsappeal/slaMaster.do">Cancel</a>
					</div>
				</div>
			</div>
		</div>
	</c:if>

	<c:if test="${not empty newServices}">
		<div class="ap-card">
			<div class="ap-card-head">Add a service</div>
			<div class="ap-card-body">
				<div class="ap-actions" style="justify-content: flex-start">
					<select id="apNewService">
						<option value="">-- select a service --</option>
						<c:forEach items="${newServices}" var="s">
							<option value="<c:out value='${s[0]}'/>"><c:out value="${s[1]}"/></option>
						</c:forEach>
					</select>

					<button type="button" class="ap-btn ap-btn-blue" onclick="apSlaAdd()">Add</button>
				</div>
			</div>
		</div>
	</c:if>

	<div class="ap-card">
		<div class="ap-table-wrap">
			<table class="ap-table">
				<thead>
					<tr>
						<th>Service</th><th>Department</th><th>SLA days</th><th>Counted from</th>
						<th>First / Second Appellate Officer</th><th>Appeal</th><th></th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty slaList}"><tr><td colspan="7" class="ap-empty">No services.</td></tr></c:if>
					<c:forEach items="${slaList}" var="s">
						<tr>
							<td><b><c:out value="${s.serviceName}"/></b></td>
							<td class="ap-small"><c:out value="${empty s.departmentName ? '-' : s.departmentName}"/></td>
							<td><c:out value="${s.slaDays}"/></td>
							<td class="ap-nowrap"><c:out value="${s.slaStartHours}"/> h after submission</td>
							<td class="ap-small"><c:out value="${empty s.firstAppellateOfficer ? '-' : s.firstAppellateOfficer}"/> /
								<c:out value="${empty s.secondAppellateOfficer ? '-' : s.secondAppellateOfficer}"/></td>
							<td><span class="ap-badge ${s.isAppealEnabled == 1 ? 'ap-badge-ok' : 'ap-badge-warn'}"><c:out value="${s.isAppealEnabled == 1 ? 'On' : 'Off'}"/></span></td>
							<td><a class="ap-btn ap-btn-blue ap-btn-sm" href="<c:out value='${contextRoot}'/>/rtsappeal/slaMaster.do?serviceId=${s.rtiServiceId}#apSlaEdit">Edit</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>

<script type="text/javascript">
	<%-- the page is inside the layout's form (frmPage): it is submitted to the save action like the other appeal screens --%>
	function apSlaField(name) {
		return document.querySelector('#apSlaForm [name="' + name + '"]');
	}

	function apSlaSave() {
		var days = parseInt(apSlaField('slaDays').value, 10);
		var hours = parseInt(apSlaField('slaStartHours').value, 10);
		if (!apSlaField('serviceName').value.replace(/\s/g, '')) {
			alert('Please enter the service name.');
			return;
		}
		if (!(days >= 1 && days <= 365) || !(hours >= 0 && hours <= 240)) {
			alert('SLA days must be 1 to 365 and the hours 0 to 240.');
			return;
		}
		if (!confirm('Save the SLA settings of this service?')) {
			return;
		}
		document.frmPage.method = 'post';
		document.frmPage.action = '<c:out value="${contextRoot}"/>/rtsappeal/saveSla.do';
		document.frmPage.submit();
	}

	function apSlaAdd() {
		var select = document.getElementById('apNewService');
		if (!select.value) {
			alert('Please select the service.');
			return;
		}
		var name = select.options[select.selectedIndex].text;
		window.location = '<c:out value="${contextRoot}"/>/rtsappeal/slaMaster.do?serviceId=' + encodeURIComponent(select.value)
				+ '&serviceName=' + encodeURIComponent(name) + '#apSlaEdit';
	}
</script>
