<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.include file="/pages/core-pages/rtsappeal/rtsAppealStyles.jspf" />
<%-- Officer: applications I sent back to the citizen, and their state --%>

<div class="ap-page">
	<div class="ap-head">
		<div>
			<h3>Sent Back to Citizen</h3>
			<p class="ap-sub">Applications you sent back for correction. After the citizen resubmits (or the time is over) the application is
				back on your usual task screen, where it stopped.</p>
		</div>
	</div>

	<c:if test="${not empty rtsAppealError}"><div class="ap-alert ap-alert-error"><c:out value="${rtsAppealError}"/></div></c:if>
	<c:if test="${not empty rtsAppealMessage}"><div class="ap-alert ap-alert-ok"><c:out value="${rtsAppealMessage}"/></div></c:if>

	<div class="ap-card">
		<div class="ap-table-wrap">
			<table class="ap-table">
				<thead>
					<tr>
						<th>Sr. No</th>
						<th>Application Id</th>
						<th>Service</th>
						<th>Applicant</th>
						<th>Sent back on</th>
						<th>Remarks</th>
						<th>Resubmit by</th>
						<th>Status</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty sendBacks}">
						<tr><td colspan="9" class="ap-empty">No applications sent back.</td></tr>
					</c:if>
					<c:forEach items="${sendBacks}" var="s" varStatus="st">
						<tr>
							<td><c:out value="${st.count}"/></td>
							<td class="ap-nowrap"><b><c:out value="${s.rtiApplicationNumber}"/></b></td>
							<td><c:out value="${s.serviceName}"/></td>
							<td><c:out value="${s.applicantName}"/></td>
							<td class="ap-nowrap"><fmt:formatDate value="${s.sentDate}" pattern="dd/MM/yyyy HH:mm"/></td>
							<td class="ap-small"><c:out value="${fn:length(s.remarks) > 80 ? fn:substring(s.remarks, 0, 80) : s.remarks}"/><c:if
								test="${fn:length(s.remarks) > 80}">...</c:if></td>
							<td class="ap-nowrap"><fmt:formatDate value="${s.dueDate}" pattern="dd/MM/yyyy HH:mm"/></td>
							<td>
								<span class="ap-badge ${s.status == 0 ? 'ap-badge-warn' : (s.status == 1 ? 'ap-badge-ok' : 'ap-badge-info')}"><c:out value="${s.statusLabel}"/></span>
								<c:if test="${s.status == 1}"><div class="ap-small"><fmt:formatDate value="${s.resubmittedDate}" pattern="dd/MM/yyyy HH:mm"/>,
									<c:out value="${s.citizenChanges}"/> change(s)</div></c:if>
							</td>
							<td class="ap-nowrap">
								<a class="ap-btn ap-btn-light ap-btn-sm" href="<c:out value='${contextRoot}'/>/rtssendback/view.do?id=${s.rtsCitizenSendBackId}">View</a>
								<c:if test="${s.status != 0}">
									<a class="ap-btn ap-btn-blue ap-btn-sm" href="<c:out value='${contextRoot}'/>/rtssendback/openApplication.do?id=${s.rtsCitizenSendBackId}">Open Application</a>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
