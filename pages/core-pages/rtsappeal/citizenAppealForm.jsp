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

	<%-- the application form (editable) and its validations --%>
	<jsp:directive.include file="/pages/core-pages/rtsappeal/citizenEditableForm.jspf" />

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

	function apSubmitAppeal() {
		if (!apCheckForm() || !apCheckFiles()) {
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
