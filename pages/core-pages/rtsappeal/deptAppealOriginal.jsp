<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.include file="/pages/core-pages/rtsappeal/rtsAppealStyles.jspf" />
<%-- Department: printable copy of the application as it was just before the appeal, laid out like the service's
     citizen application form (its labels, sections and dropdown texts); the citizen's corrections are marked.
     Documents open through /rtsappeal/document.do - no server path is shown. --%>

<div class="ap-page" style="max-width: 1000px">
	<div class="ap-actions ap-noprint" style="justify-content: flex-end; margin-bottom: 10px">
		<button type="button" class="ap-btn ap-btn-green" onclick="window.print()">Print / Save as PDF</button>
	</div>
	<div class="ap-card">
		<div class="ap-card-body">
			<div style="display: flex; align-items: center; gap: 14px; border-bottom: 2px solid #0f3d6e; padding-bottom: 10px; margin-bottom: 14px">
				<img src="<c:out value='${contextRoot}'/>/images/AMC_Logo.jpeg" alt="NMC" style="height: 64px"/>
				<div>
					<div style="font-size: 20px; font-weight: 700; color: #0f3d6e">NAGPUR MUNICIPAL CORPORATION</div>
					<div style="font-size: 14px">Original application before <c:out value="${appeal.levelLabel}"/> <b><c:out value="${appeal.appealNumber}"/></b></div>
					<div class="ap-small ap-muted">Copy saved on <fmt:formatDate value="${appeal.createdDate}" pattern="dd/MM/yyyy HH:mm"/></div>
				</div>
			</div>

			<%-- application details saved with the copy (status code shown as its name) --%>
			<table class="ap-table" style="margin-bottom: 14px">
				<tbody>
					<tr><td colspan="4" style="background: #e0edfb; font-weight: 700; color: #0f3d6e">Application</td></tr>
					<c:set var="cellCount" value="0"/>
					<tr>
					<c:forEach items="${original}" var="o">
						<c:if test="${o.sectionName == 'Application'}">
							<c:if test="${cellCount > 0 and cellCount % 2 == 0}"></tr><tr></c:if>
							<td style="width: 20%" class="ap-muted"><c:out value="${o.label}"/></td>
							<td style="width: 30%">
								<c:choose>
									<c:when test="${o.label == 'Status at appeal'}">
										<c:set var="st" value="${o.oldValue}"/>
										<c:out value="${st == '0' ? 'Form Submitted' : (st == '2' ? 'Payment Completed' : (st == '3' ? 'Payment Pending' : (st == '5' ? 'Rejected' : (st == '1' ? 'Completed' : 'In Process'))))}"/>
									</c:when>
									<c:otherwise><c:out value="${empty o.oldValue ? '-' : o.oldValue}"/></c:otherwise>
								</c:choose>
							</td>
							<c:set var="cellCount" value="${cellCount + 1}"/>
						</c:if>
					</c:forEach>
					</tr>
				</tbody>
			</table>

			<c:set var="formMode" value="original"/>
			<%@ include file="/pages/core-pages/rtsappeal/appealFormReadOnly.jspf" %>
		</div>
	</div>
</div>
