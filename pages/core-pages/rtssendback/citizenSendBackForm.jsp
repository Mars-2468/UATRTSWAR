<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.include file="/pages/core-pages/nmc_user/dashboard/header.jsp" />
<jsp:directive.include file="/pages/core-pages/rtsappeal/rtsAppealStyles.jspf" />
<%-- Citizen: the application sent back by the department - correct the form / replace documents and resubmit --%>

<c:set var="app" value="${row.application}"/>

<div class="ap-page">
	<div class="ap-head">
		<div>
			<h2>Correct &amp; Resubmit - <c:out value="${row.serviceName}"/></h2>
			<p class="ap-sub">The department sent application <b><c:out value="${app.rtiApplnNumber}"/></b> back to you for correction.
				Please correct the details / upload the documents and resubmit by
				<b><fmt:formatDate value="${sendBack.dueDate}" pattern="dd/MM/yyyy HH:mm"/></b>.</p>
		</div>
		<a class="ap-btn ap-btn-light" href="<c:out value='${contextRoot}'/>/ws/dashboard/myapplication.do">Back</a>
	</div>

	<c:if test="${not empty errMessage}">
		<div class="ap-alert ap-alert-error"><c:out value="${errMessage}"/></div>
	</c:if>

	<div class="ap-card" style="border-color: #f59e0b">
		<div class="ap-card-head" style="background: #fffbeb; color: #92400e">What the department asks you to correct</div>
		<div class="ap-card-body">
			<div style="white-space: pre-wrap"><c:out value="${sendBack.remarks}"/></div>
			<c:if test="${not empty requiredDocs}">
				<div style="margin-top: 8px"><b>Documents to upload again:</b>
					<c:forEach items="${requiredDocs}" var="r" varStatus="rs"><c:out value="${r.value}"/><c:if test="${not rs.last}">; </c:if></c:forEach></div>
			</c:if>
			<div class="ap-small ap-muted" style="margin-top: 8px">Sent back on <fmt:formatDate value="${sendBack.sentDate}" pattern="dd/MM/yyyy HH:mm"/>.
				If the application is not resubmitted by the date above, it goes back to the department as it is and may be rejected.</div>
		</div>
	</div>

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
			</div>
		</div>
	</div>

	<input type="hidden" name="rtiApplnNumber" value="<c:out value='${app.rtiApplnNumber}'/>"/>

	<%-- the application form (editable) and its validations --%>
	<jsp:directive.include file="/pages/core-pages/rtsappeal/citizenEditableForm.jspf" />

	<div class="ap-card">
		<div class="ap-card-head">Resubmit</div>
		<div class="ap-card-body">
			<div class="ap-form-row">
				<label for="citizenRemarks">Remarks (optional)</label>
				<textarea id="citizenRemarks" name="citizenRemarks" maxlength="2000"
					placeholder="Describe what you corrected"><c:out value="${citizenRemarks}"/></textarea>
			</div>
			<div class="ap-actions">
				<button type="button" id="sbSubmitBtn" class="ap-btn ap-btn-green" onclick="sbResubmit()">Resubmit Application</button>
				<a class="ap-btn ap-btn-light" href="<c:out value='${contextRoot}'/>/ws/dashboard/myapplication.do">Cancel</a>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	function sbResubmit() {
		if (!apCheckForm() || !apCheckFiles() || !apRequiredDocs()) {
			return;
		}
		var files = document.frmPage.querySelectorAll('input[type=file]');
		var chosen = 0;
		for (var i = 0; i < files.length; i++) {
			for (var j = 0; j < files[i].files.length; j++) {
				var file = files[i].files[j];
				chosen++;
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
		var changed = document.querySelectorAll('.ap-form-grid .ap-changed').length;
		if (!changed && !chosen && !document.getElementById('citizenRemarks').value.replace(/\s/g, '')) {
			alert('Please correct the details / upload the documents asked for, or write a remark, before resubmitting.');
			return;
		}
		if (!confirm('Resubmit application <c:out value="${app.rtiApplnNumber}"/> with your corrections?')) {
			return;
		}
		var button = document.getElementById('sbSubmitBtn');
		button.disabled = true;
		button.innerHTML = 'Submitting...';
		<%-- the page layout's form is not multipart; switch it before submitting --%>
		document.frmPage.enctype = 'multipart/form-data';
		document.frmPage.encoding = 'multipart/form-data';
		document.frmPage.action = '<c:out value="${contextRoot}"/>/ws/rtssendback/resubmit.do';
		document.frmPage.submit();
	}
</script>
