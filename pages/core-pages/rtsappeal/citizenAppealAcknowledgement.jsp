<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.include file="/pages/core-pages/rtsappeal/rtsAppealStyles.jspf" />
<%-- Citizen: printable appeal acknowledgement ("Download Appeal"); Print -> Save as PDF --%>

<div class="ap-page" style="max-width: 820px">
	<div class="ap-actions ap-noprint" style="justify-content: flex-end; margin-bottom: 10px">
		<button type="button" class="ap-btn ap-btn-green" onclick="window.print()">Print / Save as PDF</button>
	</div>
	<div class="ap-card">
		<div class="ap-card-body">
			<div style="display: flex; align-items: center; gap: 14px; border-bottom: 2px solid #0f3d6e; padding-bottom: 10px; margin-bottom: 14px">
				<img src="<c:out value='${contextRoot}'/>/images/AMC_Logo.jpeg" alt="NMC" style="height: 64px"/>
				<div>
					<div style="font-size: 20px; font-weight: 700; color: #0f3d6e">NAGPUR MUNICIPAL CORPORATION</div>
					<div style="font-size: 14px">Right to Public Services - <c:out value="${appeal.levelLabel}"/> Acknowledgement</div>
				</div>
			</div>

			<table class="ap-table">
				<tbody>
					<tr><td style="width: 38%"><b>Appeal Number</b></td><td><c:out value="${appeal.appealNumber}"/></td></tr>
					<tr><td><b>Appeal Type</b></td><td><c:out value="${appeal.levelLabel}"/></td></tr>
					<tr><td><b>Appeal Date</b></td><td><fmt:formatDate value="${appeal.createdDate}" pattern="dd/MM/yyyy HH:mm"/></td></tr>
					<tr><td><b>Application Id</b></td><td><c:out value="${appeal.rtiApplicationNumber}"/></td></tr>
					<tr><td><b>Service Name</b></td><td><c:out value="${appeal.serviceName}"/></td></tr>
					<tr><td><b>Applicant Name</b></td><td><c:out value="${appeal.applicantName}"/></td></tr>
					<tr><td><b>Mobile Number</b></td><td><c:out value="${appeal.citizenMobileNo}"/></td></tr>
					<tr><td><b>Application Date</b></td><td><c:out value="${appeal.applicationDate}"/></td></tr>
					<tr><td><b>Expected service Delivery date</b></td><td><fmt:formatDate value="${appeal.expectedDeliveryDate}" pattern="dd/MM/yyyy"/></td></tr>
					<tr><td><b>Reason for Appeal</b></td><td><c:out value="${appeal.appealReason}"/></td></tr>
					<c:if test="${not empty appeal.rejectionReasonAtAppeal}">
						<tr><td><b>Rejection reason</b></td><td><c:out value="${appeal.rejectionReasonAtAppeal}"/></td></tr>
					</c:if>
					<c:if test="${not empty appeal.citizenRemarks}">
						<tr><td><b>Remarks</b></td><td><c:out value="${appeal.citizenRemarks}"/></td></tr>
					</c:if>
					<tr><td><b>Appellate Officer</b></td>
						<td><c:out value="${appeal.appealLevel == 2 ? sla.secondAppellateOfficer : sla.firstAppellateOfficer}"/></td></tr>
					<tr><td><b>Current Status</b></td><td><c:out value="${appeal.statusLabel}"/></td></tr>
					<c:if test="${not empty appeal.appellateRemark}">
						<tr><td><b>Remark of Appellate Officer</b></td><td><c:out value="${appeal.appellateRemark}"/></td></tr>
					</c:if>
					<c:if test="${not empty appeal.closedRemark}">
						<tr><td><b>Closing remark</b></td><td><c:out value="${appeal.closedRemark}"/></td></tr>
					</c:if>
				</tbody>
			</table>
			<p class="ap-small" style="margin-top: 14px">This is a computer generated acknowledgement and does not need a signature.</p>
		</div>
	</div>
</div>
