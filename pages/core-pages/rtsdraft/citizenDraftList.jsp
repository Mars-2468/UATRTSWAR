<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.include file="/pages/core-pages/nmc_user/dashboard/header.jsp" />
<jsp:directive.include file="/pages/core-pages/rtsappeal/rtsAppealStyles.jspf" />
<%-- Citizen: "My Drafts" - applications started but not submitted (auto-saved), to resume or discard --%>

<div class="ap-page">
	<div class="ap-head">
		<div>
			<h2>My Drafts</h2>
			<p class="ap-sub">Applications you started but did not submit. Everything you entered and the documents you chose are saved
				automatically while you fill a form - after a power cut, lost internet or an expired session, resume it here.
				A draft is deleted when the application is submitted, or after <c:out value="${draftDays}"/> days without changes.</p>
		</div>
		<a class="ap-btn ap-btn-light" href="<c:out value='${contextRoot}'/>/ws/dashboard/myapplication.do">My Applications</a>
	</div>

	<c:if test="${not empty rtsAppealError}"><div class="ap-alert ap-alert-error"><c:out value="${rtsAppealError}"/></div></c:if>
	<c:if test="${not empty rtsAppealMessage}"><div class="ap-alert ap-alert-ok"><c:out value="${rtsAppealMessage}"/></div></c:if>

	<input type="hidden" name="discardFormKey" id="discardFormKey" value=""/>
	<div class="ap-card">
		<div class="ap-table-wrap">
			<table class="ap-table">
				<thead>
					<tr><th>Sr. No</th><th>Application</th><th>Started on</th><th>Last saved</th><th>Documents</th><th></th></tr>
				</thead>
				<tbody>
					<c:if test="${empty drafts}">
						<tr><td colspan="6" class="ap-empty">No unfinished applications.</td></tr>
					</c:if>
					<c:forEach items="${drafts}" var="d" varStatus="st">
						<tr>
							<td><c:out value="${st.count}"/></td>
							<td><b><c:out value="${empty d.formTitle ? d.formKey : d.formTitle}"/></b></td>
							<td class="ap-nowrap"><fmt:formatDate value="${d.createdDate}" pattern="dd/MM/yyyy HH:mm"/></td>
							<td class="ap-nowrap"><fmt:formatDate value="${d.modifiedDate}" pattern="dd/MM/yyyy HH:mm"/></td>
							<td><c:out value="${documentCounts[d.rtsCitizenDraftId]}"/></td>
							<td class="ap-nowrap">
								<c:choose>
									<c:when test="${not empty d.pageUrl}">
										<%-- the form opens and offers "Resume" --%>
										<a class="ap-btn ap-btn-green ap-btn-sm" href="<c:out value='${contextRoot}${d.pageUrl}'/>">Resume</a>
									</c:when>
									<c:otherwise><span class="ap-small ap-muted">Open the service again to resume</span></c:otherwise>
								</c:choose>
								<button type="button" class="ap-btn ap-btn-light ap-btn-sm" data-key="<c:out value='${d.formKey}'/>"
									onclick="rtsDraftDiscard(this)">Discard</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>

<script type="text/javascript">
	function rtsDraftDiscard(button) {
		if (!confirm('Delete this draft and its documents?')) {
			return;
		}
		document.getElementById('discardFormKey').value = button.getAttribute('data-key');
		document.frmPage.method = 'post';
		document.frmPage.action = '<c:out value="${contextRoot}"/>/ws/rtsdraft/myDrafts.do';
		document.frmPage.submit();
	}
</script>
