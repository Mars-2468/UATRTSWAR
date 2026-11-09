<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.include file="/pages/core-pages/rtsappeal/rtsAppealStyles.jspf" />
<%-- Department: printable copy of the application as it was just before the appeal (+ the citizen's corrections) --%>

<div class="ap-page" style="max-width: 980px">
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

			<c:set var="lastSection" value=""/>
			<table class="ap-table">
				<tbody>
					<c:forEach items="${original}" var="o">
						<c:if test="${o.sectionName != lastSection}">
							<tr><td colspan="2" style="background: #e0edfb; font-weight: 700; color: #0f3d6e"><c:out value="${o.sectionName}"/></td></tr>
							<c:set var="lastSection" value="${o.sectionName}"/>
						</c:if>
						<tr>
							<td style="width: 38%"><c:out value="${o.label}"/></td>
							<td>
								<c:choose>
									<c:when test="${o.isDocument == 1 and not empty o.oldValue}">
										<a href="#" class="ap-noprint" data-path="<c:out value='${o.oldValue}'/>" onclick="apDocDownload(this.getAttribute('data-path')); return false;">View</a>
										<span class="ap-small"><c:out value="${o.oldValue}"/></span>
									</c:when>
									<c:otherwise><c:out value="${empty o.oldValue ? '-' : o.oldValue}"/></c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${empty original}">
						<tr><td colspan="2" class="ap-empty">No copy was saved for this appeal.</td></tr>
					</c:if>
				</tbody>
			</table>

			<c:if test="${not empty changes}">
				<h4 style="color: #0f3d6e; margin: 18px 0 8px">Corrected by the citizen in the appeal</h4>
				<table class="ap-table">
					<thead><tr><th>Field / Document</th><th>Before</th><th>After</th></tr></thead>
					<tbody>
						<c:forEach items="${changes}" var="c">
							<tr>
								<td><c:out value="${c.label}"/></td>
								<td><c:out value="${empty c.oldValue ? '-' : c.oldValue}"/></td>
								<td><c:out value="${empty c.newValue ? '-' : c.newValue}"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
		</div>
	</div>
</div>

<script type="text/javascript">
	function apDocDownload(filesPath) {
		window.open('<c:out value="${contextRoot}"/>/rtsApplication/getPdf.do?fp=' + btoa(encodeURIComponent(filesPath)), '_blank');
	}
</script>
