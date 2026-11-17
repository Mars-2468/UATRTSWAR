<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.include file="/pages/core-pages/rtsappeal/rtsAppealStyles.jspf" />
<%-- Dashboard of the Appellate Officer: own appeal counts (click = list) and the appeals waiting for the officer.
     The RTS application tiles of the department dashboard are not shown here. --%>
<style type="text/css">
	.apd-tiles { display: grid; grid-template-columns: repeat(5, minmax(0, 1fr)); gap: 16px; margin: 6px 0 22px; }
	.apd-tile { display: flex; flex-direction: column; background: #fff; border: 1px solid #e3e8ef; border-top: 5px solid var(--apd);
		border-radius: 8px; box-shadow: 0 1px 3px rgba(15, 23, 42, .08); text-decoration: none !important; color: #1f2937;
		transition: box-shadow .15s, transform .15s; }
	.apd-tile:hover, .apd-tile:focus { box-shadow: 0 6px 16px rgba(15, 23, 42, .16); transform: translateY(-2px); }
	.apd-label { padding: 14px 16px 0; font-size: 14px; font-weight: 600; color: #475569; min-height: 38px; }
	.apd-count { padding: 4px 16px 10px; font-size: 38px; font-weight: 700; line-height: 1.1; color: var(--apd); }
	.apd-more { margin-top: auto; padding: 9px 16px; border-top: 1px solid #eef2f6; font-size: 13px; color: var(--apd); font-weight: 600; }
	.apd-received { --apd: #1d4ed8; }
	.apd-pending { --apd: #c2410c; }
	.apd-sentback { --apd: #6d28d9; }
	.apd-closed { --apd: #15803d; }
	.apd-rejected { --apd: #b91c1c; }
	.apd-note { display: flex; align-items: center; justify-content: space-between; gap: 12px; flex-wrap: wrap;
		padding: 12px 16px; margin-bottom: 18px; border-radius: 8px; background: #fff7ed; border: 1px solid #fed7aa; color: #9a3412; }
	@media (max-width: 1100px) { .apd-tiles { grid-template-columns: repeat(3, minmax(0, 1fr)); } }
	@media (max-width: 640px) { .apd-tiles { grid-template-columns: repeat(2, minmax(0, 1fr)); } }
</style>

<div class="ap-page">
	<div class="ap-head">
		<div>
			<h3>Appeal Applications</h3>
			<p class="ap-sub">First and Second Appeals assigned to you as Appellate Officer. Click a tile to see the list.</p>
		</div>
		<div class="ap-actions">
			<a class="ap-btn ap-btn-blue" href="<c:out value='${contextRoot}'/>/rtsappeal/listAppeals.do">Appeal Applications</a>
			<c:if test="${isWorkflowUser}">
				<a class="ap-btn ap-btn-light" href="<c:out value='${contextRoot}'/>/dashBoard/openDashBoard.do?rtsDashboard=1">RTS Applications Dashboard</a>
			</c:if>
		</div>
	</div>

	<c:if test="${not empty rtsAppealError}"><div class="ap-alert ap-alert-error"><c:out value="${rtsAppealError}"/></div></c:if>
	<c:if test="${not empty rtsAppealMessage}"><div class="ap-alert ap-alert-ok"><c:out value="${rtsAppealMessage}"/></div></c:if>

	<div class="apd-tiles">
		<a class="apd-tile apd-received" href="<c:out value='${contextRoot}'/>/rtsappeal/listAppeals.do?view=all">
			<span class="apd-label">Appeals Received</span>
			<span class="apd-count"><c:out value="${counts['all']}"/></span>
			<span class="apd-more">View list &rsaquo;</span></a>
		<a class="apd-tile apd-pending" href="<c:out value='${contextRoot}'/>/rtsappeal/listAppeals.do?view=pending">
			<span class="apd-label">Pending with me</span>
			<span class="apd-count"><c:out value="${counts['pending']}"/></span>
			<span class="apd-more">View list &rsaquo;</span></a>
		<a class="apd-tile apd-sentback" href="<c:out value='${contextRoot}'/>/rtsappeal/listAppeals.do?view=sentback">
			<span class="apd-label">Sent back to Department</span>
			<span class="apd-count"><c:out value="${counts['sentback']}"/></span>
			<span class="apd-more">View list &rsaquo;</span></a>
		<a class="apd-tile apd-closed" href="<c:out value='${contextRoot}'/>/rtsappeal/listAppeals.do?view=closed">
			<span class="apd-label">Closed</span>
			<span class="apd-count"><c:out value="${counts['closed']}"/></span>
			<span class="apd-more">View list &rsaquo;</span></a>
		<a class="apd-tile apd-rejected" href="<c:out value='${contextRoot}'/>/rtsappeal/listAppeals.do?view=rejected">
			<span class="apd-label">Rejected</span>
			<span class="apd-count"><c:out value="${counts['rejected']}"/></span>
			<span class="apd-more">View list &rsaquo;</span></a>
	</div>

	<c:if test="${workCount > 0}">
		<div class="apd-note">
			<span><b><c:out value="${workCount}"/></b> appealed application(s) sent back by the Appellate Officer are waiting for your action (L1 / L2).</span>
			<a class="ap-btn ap-btn-light ap-btn-sm" href="<c:out value='${contextRoot}'/>/rtsappeal/listAppeals.do?view=work">Open</a>
		</div>
	</c:if>

	<div class="ap-card">
		<div class="ap-card-head">Waiting for your action</div>
		<div class="ap-table-wrap">
			<table class="ap-table">
				<thead>
					<tr>
						<th>Sr. No</th>
						<th>Appeal Number</th>
						<th>Appeal</th>
						<th>Application Id</th>
						<th>Service</th>
						<th>Applicant</th>
						<th>Reason for Appeal</th>
						<th>Appeal Date</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty pendingAppeals}">
						<tr><td colspan="9" class="ap-empty">No appeals pending with you.</td></tr>
					</c:if>
					<c:forEach items="${pendingAppeals}" var="a" varStatus="st">
						<tr>
							<td><c:out value="${st.count}"/></td>
							<td class="ap-nowrap"><b><c:out value="${a.appealNumber}"/></b></td>
							<td><c:out value="${a.levelLabel}"/></td>
							<td class="ap-nowrap"><a href="<c:out value='${contextRoot}'/>/rtsappeal/openApplication.do?id=${a.rtsAppealId}"
								title="Open the application"><c:out value="${a.rtiApplicationNumber}"/></a></td>
							<td><c:out value="${a.serviceName}"/></td>
							<td><c:out value="${a.applicantName}"/></td>
							<td class="ap-small"><c:out value="${a.appealReason}"/></td>
							<td class="ap-nowrap"><fmt:formatDate value="${a.createdDate}" pattern="dd/MM/yyyy HH:mm"/></td>
							<td><a class="ap-btn ap-btn-blue ap-btn-sm"
								href="<c:out value='${contextRoot}'/>/rtsappeal/viewAppeal.do?id=${a.rtsAppealId}">Take Action</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
