<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.include file="/pages/core-pages/nmc_user/dashboard/header.jsp" />
<jsp:directive.include file="/pages/core-pages/rtsappeal/rtsAppealStyles.jspf" />
<%-- Citizen: appeal submitted --%>

<div class="ap-page" style="max-width: 760px">
	<div class="ap-card">
		<div class="ap-card-body" style="text-align: center; padding: 28px">
			<div style="font-size: 44px; color: #4a9a3c; line-height: 1">&#10004;</div>
			<h2 style="color: #0f3d6e; margin: 10px 0 4px"><c:out value="${appeal.levelLabel}"/> submitted</h2>
			<p class="ap-sub">Your appeal number is</p>
			<p style="font-size: 22px; font-weight: 700; margin: 4px 0 14px"><c:out value="${appeal.appealNumber}"/></p>
			<p>Application <b><c:out value="${appeal.rtiApplicationNumber}"/></b> (<c:out value="${appeal.serviceName}"/>)<br/>
				Reason: <c:out value="${appeal.appealReason}"/></p>
			<p class="ap-small">The appeal has been sent to the
				<b><c:out value="${appeal.appealLevel == 2 ? sla.secondAppellateOfficer : sla.firstAppellateOfficer}"/></b>
				for remark / order. You can follow it on My Application.</p>
			<div class="ap-actions" style="justify-content: center; margin-top: 16px">
				<a class="ap-btn ap-btn-green" target="_blank"
					href="<c:out value='${contextRoot}'/>/ws/rtsappeal/appealAcknowledgement.do?id=${appeal.rtsAppealId}">Download Appeal</a>
				<a class="ap-btn ap-btn-light" href="<c:out value='${contextRoot}'/>/ws/dashboard/myapplication.do">My Application</a>
			</div>
		</div>
	</div>
</div>
