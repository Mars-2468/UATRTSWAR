<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.include file="/pages/core-pages/rtsappeal/rtsAppealStyles.jspf" />
<%-- Officer (L1 / L2 whose turn it is): send the application back to the citizen once, within the SLA --%>

<div class="ap-page">
	<div class="ap-head">
		<div>
			<h3>Send Back to Citizen</h3>
			<p class="ap-sub">For missing information or documents, before rejecting. Allowed only once per application and within the SLA.
				The citizen corrects the form / replaces the documents and resubmits; the application then comes back to you exactly where it is now.</p>
		</div>
		<div class="ap-actions">
			<a class="ap-btn ap-btn-light" href="javascript:history.back()">Back</a>
		</div>
	</div>

	<c:if test="${not empty rtsAppealError}"><div class="ap-alert ap-alert-error"><c:out value="${rtsAppealError}"/></div></c:if>

	<div class="ap-card">
		<div class="ap-card-head">Application</div>
		<div class="ap-card-body">
			<div class="ap-grid">
				<div class="ap-field"><label>Application Id</label><div><c:out value="${application.rtiApplnNumber}"/></div></div>
				<div class="ap-field"><label>Service</label><div><c:out value="${serviceName}"/></div></div>
				<div class="ap-field"><label>Applicant</label><div><c:out value="${application.applicantName}"/></div></div>
				<div class="ap-field"><label>Mobile Number</label><div><c:out value="${application.mobileNumber}"/></div></div>
				<div class="ap-field"><label>Application Date</label><div><c:out value="${application.createdDate}"/></div></div>
				<div class="ap-field"><label>Current Status</label><div><c:out value="${statusLabel}"/></div></div>
				<div class="ap-field"><label>SLA due date</label><div><c:choose><c:when test="${not empty slaDueDate}"><fmt:formatDate
					value="${slaDueDate}" pattern="dd/MM/yyyy HH:mm"/></c:when><c:otherwise>-</c:otherwise></c:choose></div></div>
				<div class="ap-field"><label>Time for the citizen</label><div><c:out value="${correctionDays}"/> day(s) from today</div></div>
			</div>
		</div>
	</div>

	<div class="ap-card" id="sbForm">
		<div class="ap-card-head">What must the citizen correct?</div>
		<div class="ap-card-body">
			<input type="hidden" name="rtiApplicationId" value="${application.rtiApplicationId}"/>
			<div class="ap-form-row">
				<label for="sendBackRemarks">Remarks to the citizen <span class="ap-req">*</span></label>
				<textarea id="sendBackRemarks" name="sendBackRemarks" maxlength="2000" rows="4"
					placeholder="e.g. Upload a clear copy of the address proof; the bride's date of birth does not match the certificate"></textarea>
			</div>
			<c:if test="${not empty documents}">
				<div class="ap-form-row">
					<label>Documents the citizen must upload again (optional)</label>
					<c:forEach items="${documents}" var="d">
						<label class="ap-radio" style="display: block; margin: 4px 0">
							<input type="checkbox" name="requiredDocument" value="<c:out value='${d.name}'/>"/>
							<c:out value="${d.label}"/><c:if test="${empty d.files}"> <span class="ap-muted ap-small">(not uploaded)</span></c:if>
						</label>
					</c:forEach>
				</div>
			</c:if>
			<p class="ap-small ap-muted">While the application is with the citizen it cannot be processed. If the citizen does not resubmit
				in time, it comes back to you as it is now and you can continue (e.g. reject).</p>
			<div class="ap-actions" style="margin-top: 12px">
				<button type="button" id="sbSendBtn" class="ap-btn ap-btn-blue" onclick="sbSend()">Send back to citizen</button>
				<a class="ap-btn ap-btn-light" href="javascript:history.back()">Cancel</a>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	<%-- the page is inside the layout's form (frmPage) --%>
	function sbSend() {
		var remarks = document.getElementById('sendBackRemarks');
		if (!remarks.value.replace(/\s/g, '')) {
			alert('Please enter what the citizen has to correct / submit.');
			remarks.focus();
			return;
		}
		if (!confirm('Send application <c:out value="${application.rtiApplnNumber}"/> back to the citizen? This can be done only once.')) {
			return;
		}
		var button = document.getElementById('sbSendBtn');
		button.disabled = true;
		button.innerHTML = 'Sending...';
		document.frmPage.method = 'post';
		document.frmPage.action = '<c:out value="${contextRoot}"/>/rtssendback/sendBack.do';
		document.frmPage.submit();
	}
</script>
