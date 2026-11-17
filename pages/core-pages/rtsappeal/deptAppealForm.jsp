<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.include file="/pages/core-pages/rtsappeal/rtsAppealStyles.jspf" />
<%-- Appellate Officer: "Open Application" = the application form, read only. Editing, visits, fees, saving and
     the workflow actions are the work of the department's workflow users (L1 / L2 ...), not of the appeal. --%>

<div class="ap-page">
	<div class="ap-head">
		<div>
			<h3>Application <c:out value="${application.rtiApplnNumber}"/></h3>
			<p class="ap-sub"><c:out value="${appeal.serviceName}"/> &middot; <c:out value="${appeal.levelLabel}"/>
				<c:out value="${appeal.appealNumber}"/></p>
		</div>
		<div class="ap-actions">
			<a class="ap-btn ap-btn-light" href="<c:out value='${contextRoot}'/>/rtsappeal/viewAppeal.do?id=${appeal.rtsAppealId}">Back to appeal</a>
			<a class="ap-btn ap-btn-light" target="_blank" href="<c:out value='${contextRoot}'/>/rtsappeal/originalApplication.do?id=${appeal.rtsAppealId}">Original copy</a>
		</div>
	</div>

	<c:if test="${not empty rtsAppealError}"><div class="ap-alert ap-alert-error"><c:out value="${rtsAppealError}"/></div></c:if>
	<div class="ap-alert ap-alert-info">View only. As Appellate Officer you give the remark / order on the appeal page and send the
		application back; processing it (edit, visits, fees, approval) is done by the department's workflow users.</div>

	<div class="ap-card">
		<div class="ap-card-head">Application</div>
		<div class="ap-card-body">
			<div class="ap-grid">
				<div class="ap-field"><label>Applicant Name</label><div><c:out value="${application.applicantName}"/></div></div>
				<div class="ap-field"><label>Mobile Number</label><div><c:out value="${application.mobileNumber}"/></div></div>
				<div class="ap-field"><label>Zone</label><div><c:out value="${empty application.zone ? '-' : application.zone}"/></div></div>
				<div class="ap-field"><label>Application Date</label><div><c:out value="${application.createdDate}"/></div></div>
				<div class="ap-field"><label>Current workflow task</label><div><c:out value="${empty workflowPosition ? '-' : workflowPosition}"/></div></div>
			</div>
		</div>
	</div>

	<c:set var="formMode" value="current"/>
	<%@ include file="/pages/core-pages/rtsappeal/appealFormReadOnly.jspf" %>
</div>
