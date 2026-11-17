<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.include file="/pages/core-pages/rtsappeal/rtsAppealStyles.jspf" />
<%-- Department: appeals for the logged-in officer (L3 = Appellate Officer, L1/L2 = department) --%>

<div class="ap-page">
	<div class="ap-head">
		<div>
			<h3>Appeal Applications</h3>
			<p class="ap-sub">First and Second Appeals. The Appellate Officer sends the application back; L1 / L2 then complete it from the usual task screens.</p>
		</div>
		<c:if test="${isAdmin}">
			<div class="ap-actions">
				<a class="ap-btn ap-btn-light" href="<c:out value='${contextRoot}'/>/rtsappeal/slaMaster.do">RTS Services SLA Master</a>
				<a class="ap-btn ap-btn-blue" href="<c:out value='${contextRoot}'/>/rtsappeal/appellateOfficers.do">Appellate Officer Mapping</a>
			</div>
		</c:if>
	</div>

	<c:if test="${not empty rtsAppealError}">
		<div class="ap-alert ap-alert-error"><c:out value="${rtsAppealError}"/></div>
	</c:if>
	<c:if test="${not empty rtsAppealMessage}">
		<div class="ap-alert ap-alert-ok"><c:out value="${rtsAppealMessage}"/></div>
	</c:if>

	<div class="ap-steps">
		<div class="ap-step"><span class="ap-step-no">1</span><b>With Appellate Officer</b>The citizen has appealed; the application is on hold. The officer gives remark / order.</div>
		<div class="ap-step"><span class="ap-step-no">2</span><b>Sent back to department</b>It continues in its own workflow from where it stopped and is listed for the L1 / L2 user whose turn it is.</div>
		<div class="ap-step"><span class="ap-step-no">3</span><b>Closed</b>Automatically when the certificate is issued, or when the officer closes the appeal. The citizen may then file a Second Appeal.</div>
	</div>

	<div class="ap-tabs">
		<c:set var="apL3Title" value="${appellateView == 'all' ? 'all appeals received' : (appellateView == 'sentback' ? 'sent back to department' : (appellateView == 'closed' ? 'closed' : 'pending'))}"/>
		<div class="ap-tab ap-active" id="apTabL3" onclick="apShowTab('L3')">As Appellate Officer (<c:out value="${apL3Title}"/>)
			<span class="ap-count"><c:out value="${fn:length(appellateAppeals)}"/></span></div>
		<div class="ap-tab" id="apTabDept" onclick="apShowTab('Dept')">My work after appeal (L1 / L2)
			<span class="ap-count"><c:out value="${fn:length(departmentAppeals)}"/></span></div>
		<div class="ap-tab" id="apTabHist" onclick="apShowTab('Hist')">Completed (reference)
			<span class="ap-count"><c:out value="${fn:length(historyAppeals)}"/></span></div>
	</div>

	<c:forTokens items="L3,Dept,Hist" delims="," var="tab">
		<c:set var="list" value="${tab == 'L3' ? appellateAppeals : (tab == 'Dept' ? departmentAppeals : historyAppeals)}"/>
		<div class="ap-card" id="apPanel${tab}" style="${tab == 'L3' ? '' : 'display: none'}">
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
							<th>Status</th>
							<th>Appellate Officer remark</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty list}">
							<tr><td colspan="11" class="ap-empty">No appeals.</td></tr>
						</c:if>
						<c:forEach items="${list}" var="a" varStatus="st">
							<tr>
								<td><c:out value="${st.count}"/></td>
								<td class="ap-nowrap"><b><c:out value="${a.appealNumber}"/></b></td>
								<td><c:out value="${a.levelLabel}"/></td>
								<td class="ap-nowrap">
									<%-- opens the application as the role allows: read-only form, or the department's screen when it is the user's turn --%>
									<a href="<c:out value='${contextRoot}'/>/rtsappeal/openApplication.do?id=${a.rtsAppealId}"
										title="Open the application"><c:out value="${a.rtiApplicationNumber}"/></a></td>
								<td><c:out value="${a.serviceName}"/></td>
								<td><c:out value="${a.applicantName}"/></td>
								<td class="ap-small"><c:out value="${a.appealReason}"/></td>
								<td class="ap-nowrap"><fmt:formatDate value="${a.createdDate}" pattern="dd/MM/yyyy HH:mm"/></td>
								<td>
									<span class="ap-badge ${a.status == 0 ? 'ap-badge-warn' : (a.status == 1 ? 'ap-badge-info' : 'ap-badge-ok')}">
										<c:out value="${a.statusLabel}"/></span>
								</td>
								<td class="ap-small">
									<c:choose>
										<c:when test="${not empty a.appellateRemark}">
											<c:out value="${fn:length(a.appellateRemark) > 80 ? fn:substring(a.appellateRemark, 0, 80) : a.appellateRemark}"/><c:if test="${fn:length(a.appellateRemark) > 80}">...</c:if>
										</c:when>
										<c:otherwise><span class="ap-muted">-</span></c:otherwise>
									</c:choose>
								</td>
								<td>
									<a class="ap-btn ap-btn-blue ap-btn-sm"
										href="<c:out value='${contextRoot}'/>/rtsappeal/viewAppeal.do?id=${a.rtsAppealId}">
										<c:out value="${tab == 'L3' and a.status == 0 ? 'Take Action' : 'View'}"/></a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</c:forTokens>
</div>

<script type="text/javascript">
	function apShowTab(tab) {
		var tabs = ['L3', 'Dept', 'Hist'];
		for (var i = 0; i < tabs.length; i++) {
			document.getElementById('apPanel' + tabs[i]).style.display = tabs[i] === tab ? '' : 'none';
			document.getElementById('apTab' + tabs[i]).className = 'ap-tab' + (tabs[i] === tab ? ' ap-active' : '');
		}
	}
	<%-- open the department tab when the officer has no appellate appeals --%>
	<c:choose>
		<c:when test="${not empty openTab}">apShowTab('<c:out value="${openTab}"/>');</c:when>
		<c:when test="${empty appellateAppeals and not empty departmentAppeals}">apShowTab('Dept');</c:when>
	</c:choose>
</script>
