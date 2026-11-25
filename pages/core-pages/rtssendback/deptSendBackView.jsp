<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.include file="/pages/core-pages/rtsappeal/rtsAppealStyles.jspf" />
<%-- Officer: one send back - the remarks, the state and the citizen's corrections (before / after, documents) --%>

<div class="ap-page">
	<div class="ap-head">
		<div>
			<h3>Sent Back to Citizen - <c:out value="${sendBack.rtiApplicationNumber}"/></h3>
			<p class="ap-sub"><c:out value="${sendBack.serviceName}"/> &middot; <c:out value="${sendBack.applicantName}"/></p>
		</div>
		<div class="ap-actions">
			<c:if test="${sendBack.status != 0}">
				<a class="ap-btn ap-btn-blue" href="<c:out value='${contextRoot}'/>/rtssendback/openApplication.do?id=${sendBack.rtsCitizenSendBackId}">Open Application</a>
			</c:if>
			<a class="ap-btn ap-btn-light" href="<c:out value='${contextRoot}'/>/rtssendback/list.do">Sent Back List</a>
		</div>
	</div>

	<c:if test="${not empty rtsAppealError}"><div class="ap-alert ap-alert-error"><c:out value="${rtsAppealError}"/></div></c:if>
	<c:if test="${not empty rtsAppealMessage}"><div class="ap-alert ap-alert-ok"><c:out value="${rtsAppealMessage}"/></div></c:if>

	<div class="ap-card">
		<div class="ap-card-head">Send back</div>
		<div class="ap-card-body">
			<div class="ap-grid">
				<div class="ap-field"><label>Status</label><div><span class="ap-badge ${sendBack.status == 0 ? 'ap-badge-warn' : (sendBack.status == 1 ? 'ap-badge-ok' : 'ap-badge-info')}"><c:out value="${sendBack.statusLabel}"/></span></div></div>
				<div class="ap-field"><label>Sent back by</label><div><c:out value="${sendBack.sentBy}"/> (<c:out value="${sendBack.sentByStage}"/>)</div></div>
				<div class="ap-field"><label>Sent back on</label><div><fmt:formatDate value="${sendBack.sentDate}" pattern="dd/MM/yyyy HH:mm"/></div></div>
				<div class="ap-field"><label>Resubmit by</label><div><fmt:formatDate value="${sendBack.dueDate}" pattern="dd/MM/yyyy HH:mm"/></div></div>
				<c:if test="${not empty sendBack.resubmittedDate}">
					<div class="ap-field"><label>Resubmitted on</label><div><fmt:formatDate value="${sendBack.resubmittedDate}" pattern="dd/MM/yyyy HH:mm"/></div></div>
				</c:if>
				<div class="ap-field" style="grid-column: 1 / -1"><label>Remarks to the citizen</label>
					<div style="white-space: pre-wrap"><c:out value="${sendBack.remarks}"/></div></div>
				<c:if test="${not empty sendBack.requiredDocumentMap}">
					<div class="ap-field" style="grid-column: 1 / -1"><label>Documents asked for</label>
						<div><c:forEach items="${sendBack.requiredDocumentMap}" var="r" varStatus="rs"><c:out value="${r.value}"/><c:if test="${not rs.last}">; </c:if></c:forEach></div></div>
				</c:if>
				<c:if test="${not empty sendBack.citizenRemarks}">
					<div class="ap-field" style="grid-column: 1 / -1"><label>Citizen's remarks</label>
						<div style="white-space: pre-wrap"><c:out value="${sendBack.citizenRemarks}"/></div></div>
				</c:if>
			</div>
		</div>
	</div>

	<div class="ap-card">
		<div class="ap-card-head">Citizen's corrections</div>
		<div class="ap-table-wrap">
			<table class="ap-table">
				<thead><tr><th>Section</th><th>Field / Document</th><th>Before</th><th>After</th></tr></thead>
				<tbody>
					<c:if test="${empty changes}">
						<tr><td colspan="4" class="ap-empty"><c:out value="${sendBack.status == 0 ? 'Not resubmitted yet.' : 'No changes.'}"/></td></tr>
					</c:if>
					<c:forEach items="${changes}" var="c">
						<tr>
							<td class="ap-small"><c:out value="${c.sectionName}"/></td>
							<td><c:out value="${c.label}"/></td>
							<c:choose>
								<c:when test="${c.document}">
									<td><c:forEach items="${c.oldFiles}" varStatus="fs"><a class="ap-btn ap-btn-light ap-btn-xs" target="_blank"
										href="<c:out value='${contextRoot}'/>/rtssendback/document.do?id=${c.rtsSendBackSnapshotId}&amp;v=old&amp;i=${fs.index}">View ${fs.count}</a> </c:forEach><c:if
										test="${empty c.oldFiles}"><span class="ap-muted">-</span></c:if></td>
									<td><c:forEach items="${c.newFiles}" varStatus="fs"><a class="ap-btn ap-btn-blue ap-btn-xs" target="_blank"
										href="<c:out value='${contextRoot}'/>/rtssendback/document.do?id=${c.rtsSendBackSnapshotId}&amp;v=new&amp;i=${fs.index}">View ${fs.count}</a> </c:forEach></td>
								</c:when>
								<c:otherwise>
									<td><c:out value="${empty c.oldValue ? '-' : c.oldValue}"/></td>
									<td><b><c:out value="${empty c.newValue ? '-' : c.newValue}"/></b></td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
