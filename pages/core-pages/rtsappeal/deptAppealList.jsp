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
			<a class="ap-btn ap-btn-blue" href="<c:out value='${contextRoot}'/>/rtsappeal/appellateOfficers.do">Appellate Officer Mapping</a>
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
		<div class="ap-step"><span class="ap-step-no">2</span><b>Sent back to department</b>The application is back in the L1 / L2 task list from where it stopped. Complete it as usual.</div>
		<div class="ap-step"><span class="ap-step-no">3</span><b>Closed</b>Automatically when the certificate is issued, or when the officer closes the appeal. The citizen may then file a Second Appeal.</div>
	</div>

	<div class="ap-tabs">
		<div class="ap-tab ap-active" id="apTabL3" onclick="apShowTab('L3')">As Appellate Officer
			<span class="ap-count"><c:out value="${fn:length(appellateAppeals)}"/></span></div>
		<div class="ap-tab" id="apTabDept" onclick="apShowTab('Dept')">On my applications (L1 / L2)
			<span class="ap-count"><c:out value="${fn:length(departmentAppeals)}"/></span></div>
	</div>

	<c:forTokens items="L3,Dept" delims="," var="tab">
		<c:set var="list" value="${tab == 'L3' ? appellateAppeals : departmentAppeals}"/>
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
								<td class="ap-nowrap"><c:out value="${a.rtiApplicationNumber}"/></td>
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
		var tabs = ['L3', 'Dept'];
		for (var i = 0; i < tabs.length; i++) {
			document.getElementById('apPanel' + tabs[i]).style.display = tabs[i] === tab ? '' : 'none';
			document.getElementById('apTab' + tabs[i]).className = 'ap-tab' + (tabs[i] === tab ? ' ap-active' : '');
		}
	}
	<%-- open the department tab when the officer has no appellate appeals --%>
	<c:if test="${empty appellateAppeals and not empty departmentAppeals}">apShowTab('Dept');</c:if>
</script>
