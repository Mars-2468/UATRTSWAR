<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.include file="/pages/core-pages/rtsappeal/rtsAppealStyles.jspf" />
<%-- Citizen: the submitted application form (read only) - "Application Form" on My Application; Print -> Save as PDF --%>

<c:set var="app" value="${row.application}"/>
<style type="text/css">
	.pf-section { margin-top: 14px; }
	.pf-section h4 { margin: 0 0 6px; padding: 6px 10px; background: #e8eef5; color: #0f3d6e; font-size: 14px; border-radius: 4px; }
	.pf-table td { vertical-align: top; }
	.pf-table td.pf-label { width: 38%; font-weight: 600; }
	@media print {
		.pf-section { page-break-inside: avoid; }
	}
</style>

<div class="ap-page" style="max-width: 900px">
	<div class="ap-actions ap-noprint" style="justify-content: flex-end; margin-bottom: 10px">
		<button type="button" class="ap-btn ap-btn-green" onclick="window.print()">Print / Save as PDF</button>
		<a class="ap-btn ap-btn-light" href="<c:out value='${contextRoot}'/>/ws/dashboard/myapplication.do">Back</a>
	</div>
	<div class="ap-card">
		<div class="ap-card-body">
			<div style="display: flex; align-items: center; gap: 14px; border-bottom: 2px solid #0f3d6e; padding-bottom: 10px; margin-bottom: 14px">
				<img src="<c:out value='${contextRoot}'/>/images/AMC_Logo.jpeg" alt="NMC" style="height: 64px"/>
				<div>
					<div style="font-size: 20px; font-weight: 700; color: #0f3d6e">NAGPUR MUNICIPAL CORPORATION</div>
					<div style="font-size: 14px">Right to Public Services - Application Form - <c:out value="${row.serviceName}"/></div>
				</div>
			</div>

			<div class="pf-section">
				<h4>Application Details</h4>
				<table class="ap-table pf-table">
					<tbody>
						<tr><td class="pf-label">Application Id</td><td><c:out value="${app.rtiApplnNumber}"/></td></tr>
						<tr><td class="pf-label">Service Name</td><td><c:out value="${row.serviceName}"/></td></tr>
						<tr><td class="pf-label">Applicant Name</td><td><c:out value="${app.applicantName}"/></td></tr>
						<tr><td class="pf-label">Mobile Number</td><td><c:out value="${app.mobileNumber}"/></td></tr>
						<c:if test="${not empty app.email}"><tr><td class="pf-label">Email</td><td><c:out value="${app.email}"/></td></tr></c:if>
						<c:if test="${not empty app.zone}"><tr><td class="pf-label">Zone</td><td><c:out value="${app.zone}"/></td></tr></c:if>
						<tr><td class="pf-label">Application Date</td><td><c:out value="${app.createdDate}"/></td></tr>
						<tr><td class="pf-label">Current Status</td><td><c:out value="${row.statusLabel}"/></td></tr>
					</tbody>
				</table>
			</div>

			<c:forEach items="${sections}" var="section">
				<c:if test="${section.key != 'Documents' and not empty section.value}">
					<div class="pf-section">
						<h4><c:out value="${section.key}"/></h4>
						<table class="ap-table pf-table">
							<tbody>
								<c:forEach items="${section.value}" var="f">
									<tr><td class="pf-label"><c:out value="${f.label}"/></td>
										<td><c:out value="${empty f.displayValue ? '-' : f.displayValue}"/></td></tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</c:if>
			</c:forEach>

			<c:if test="${not empty sections['Documents']}">
				<div class="pf-section">
					<h4>Documents</h4>
					<table class="ap-table pf-table">
						<tbody>
							<c:forEach items="${sections['Documents']}" var="d">
								<tr><td class="pf-label"><c:out value="${d.label}"/></td>
									<td>
										<c:choose>
											<c:when test="${not empty d.files}">
												Uploaded<c:if test="${fn:length(d.files) > 1}"> (${fn:length(d.files)} files)</c:if>
												<span class="ap-noprint">
													<c:forEach items="${d.files}" varStatus="fs">
														<a class="ap-btn ap-btn-light ap-btn-xs" href="#" data-doc="<c:out value='${d.name}'/>" data-i="${fs.index}"
															onclick="pfDocView(this); return false;">View<c:if test="${fn:length(d.files) > 1}"> ${fs.count}</c:if></a>
													</c:forEach>
												</span>
											</c:when>
											<c:otherwise><span class="ap-muted">Not uploaded</span></c:otherwise>
										</c:choose>
									</td></tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:if>

			<p class="ap-small" style="margin-top: 14px">This is a computer generated copy of the application form as it is on record
				(including corrections made later) and does not need a signature.</p>
		</div>
	</div>
</div>

<script type="text/javascript">
	function pfDocView(link) {
		window.open('<c:out value="${contextRoot}"/>/ws/rtsappeal/viewDocument.do?rtiApplnNumber='
				+ encodeURIComponent('<c:out value="${app.rtiApplnNumber}"/>')
				+ '&doc=' + encodeURIComponent(link.getAttribute('data-doc'))
				+ '&i=' + encodeURIComponent(link.getAttribute('data-i')), '_blank');
	}
</script>
