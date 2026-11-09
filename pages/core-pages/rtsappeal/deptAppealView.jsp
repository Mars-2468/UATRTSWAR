<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.include file="/pages/core-pages/rtsappeal/rtsAppealStyles.jspf" />
<%-- Department: one appeal. Appellate Officer: remark / order -> send back (or close). L1 / L2: see the remark and act. --%>

<c:set var="st" value="${application.workFlowStatus}"/>
<c:set var="appStatusLabel" value="${st == 0 ? 'Form Submitted (L1)' : (st == 1 ? 'Completed' : (st == 2 ? 'Payment Completed (L2)' : (st == 3 ? 'Payment Pending (citizen)' : (st == 5 ? 'Rejected' : (st == 20 ? 'Under Appeal' : 'In Process')))))}"/>
<c:set var="beforeSt" value="${appeal.applicationStatusAtAppeal}"/>
<c:set var="beforeLabel" value="${beforeSt == 0 ? 'Form Submitted' : (beforeSt == 2 ? 'Payment Completed' : (beforeSt == 3 ? 'Payment Pending' : (beforeSt == 5 ? 'Rejected' : 'In Process')))}"/>

<div class="ap-page">
	<div class="ap-head">
		<div>
			<h3><c:out value="${appeal.levelLabel}"/> <c:out value="${appeal.appealNumber}"/></h3>
			<p class="ap-sub"><c:out value="${appeal.serviceName}"/> &middot; Appellate Officer:
				<b><c:out value="${appeal.appealLevel == 2 ? sla.secondAppellateOfficer : sla.firstAppellateOfficer}"/></b></p>
		</div>
		<div class="ap-actions">
			<span class="ap-badge ${appeal.status == 0 ? 'ap-badge-warn' : (appeal.status == 1 ? 'ap-badge-info' : 'ap-badge-ok')}" style="font-size: 13px; padding: 5px 12px">
				<c:out value="${appeal.statusLabel}"/></span>
			<a class="ap-btn ap-btn-light" target="_blank" href="<c:out value='${contextRoot}'/>/rtsappeal/originalApplication.do?id=${appeal.rtsAppealId}">Original Application (Print)</a>
			<a class="ap-btn ap-btn-light" href="<c:out value='${contextRoot}'/>/rtsappeal/listAppeals.do">Back</a>
		</div>
	</div>

	<c:if test="${not empty rtsAppealError}">
		<div class="ap-alert ap-alert-error"><c:out value="${rtsAppealError}"/></div>
	</c:if>
	<c:if test="${not empty rtsAppealMessage}">
		<div class="ap-alert ap-alert-ok"><c:out value="${rtsAppealMessage}"/></div>
	</c:if>
	<c:if test="${isDepartmentUser and appeal.status == 0}">
		<div class="ap-alert ap-alert-info">The appeal is with the Appellate Officer. The application is on hold until the officer sends it back.</div>
	</c:if>
	<c:if test="${isDepartmentUser and appeal.status == 1}">
		<div class="ap-alert ap-alert-info">The Appellate Officer has sent the application back with the remark / order below.
			It is now <b><c:out value="${appStatusLabel}"/></b> in your task list - please complete it with <b>Open Application</b>.
			The appeal closes automatically when the certificate is issued.</div>
	</c:if>
	<c:if test="${isAppellateOfficer and appeal.status == 0}">
		<div class="ap-alert ap-alert-info">When you send the application back it continues from <b><c:out value="${beforeLabel}"/></b>:
			<c:choose>
				<c:when test="${beforeSt == 5}">if the citizen has paid it goes to L2 for the certificate, otherwise to L1 to check it again.</c:when>
				<c:when test="${beforeSt == 3}">the citizen is asked to pay again.</c:when>
				<c:when test="${beforeSt == 2}">L2 issues the certificate.</c:when>
				<c:otherwise>L1 takes action on the application.</c:otherwise>
			</c:choose></div>
	</c:if>

	<div class="ap-card">
		<div class="ap-card-head">Appeal</div>
		<div class="ap-card-body">
			<div class="ap-grid">
				<div class="ap-field"><label>Appeal Number</label><div><c:out value="${appeal.appealNumber}"/></div></div>
				<div class="ap-field"><label>Original Application Number</label><div><c:out value="${appeal.previousApplicationNumber}"/></div></div>
				<div class="ap-field"><label>Appeal Date</label><div><fmt:formatDate value="${appeal.createdDate}" pattern="dd/MM/yyyy HH:mm"/></div></div>
				<div class="ap-field"><label>Reason for Appeal</label><div><c:out value="${appeal.appealReason}"/></div></div>
				<div class="ap-field"><label>Status before appeal</label><div><c:out value="${beforeLabel}"/></div></div>
				<div class="ap-field"><label>Expected service Delivery date</label>
					<div><fmt:formatDate value="${appeal.expectedDeliveryDate}" pattern="dd/MM/yyyy"/> (<c:out value="${sla.slaDays}"/> days)</div></div>
				<c:if test="${not empty appeal.rejectionReasonAtAppeal}">
					<div class="ap-field" style="grid-column: 1 / -1"><label>Rejection reason given to citizen</label>
						<div class="ap-err-text"><c:out value="${appeal.rejectionReasonAtAppeal}"/></div></div>
				</c:if>
				<div class="ap-field" style="grid-column: 1 / -1"><label>Citizen remarks</label>
					<div><c:out value="${empty appeal.citizenRemarks ? '-' : appeal.citizenRemarks}"/></div></div>
			</div>
		</div>
	</div>

	<div class="ap-card">
		<div class="ap-card-head" style="display: flex; justify-content: space-between; align-items: center">
			<span>Application <c:out value="${application.rtiApplnNumber}"/></span>
			<button type="button" class="ap-btn ap-btn-blue ap-btn-sm"
				onclick="apOpenApplication('<c:out value="${application.rtiApplicationRefId}"/>', '<c:out value="${application.rtiApplicationId}"/>')">Open Application</button>
		</div>
		<div class="ap-card-body">
			<div class="ap-grid">
				<div class="ap-field"><label>Applicant Name</label><div><c:out value="${application.applicantName}"/></div></div>
				<div class="ap-field"><label>Mobile Number</label><div><c:out value="${application.mobileNumber}"/></div></div>
				<div class="ap-field"><label>Zone</label><div><c:out value="${empty application.zone ? '-' : application.zone}"/></div></div>
				<div class="ap-field"><label>Application Date</label><div><c:out value="${application.createdDate}"/></div></div>
				<div class="ap-field"><label>Current Status</label><div><c:out value="${appStatusLabel}"/></div></div>
				<div class="ap-field"><label>Remark on application</label><div><c:out value="${empty application.workflowComments ? '-' : application.workflowComments}"/></div></div>
			</div>
		</div>
	</div>

	<div class="ap-card">
		<div class="ap-card-head">Corrections made by the citizen in the appeal (<c:out value="${fn:length(changes)}"/>)</div>
		<div class="ap-card-body">
			<c:choose>
				<c:when test="${empty changes}"><span class="ap-muted">No changes - the application was submitted as it was.</span></c:when>
				<c:otherwise>
					<table class="ap-table">
						<thead><tr><th>Field / Document</th><th>Before appeal</th><th>In the appeal</th></tr></thead>
						<tbody>
							<c:forEach items="${changes}" var="c">
								<tr>
									<td><b><c:out value="${c.label}"/></b> <span class="ap-small ap-muted"><c:out value="${c.sectionName}"/></span></td>
									<c:choose>
										<c:when test="${c.isDocument == 1}">
											<td><c:if test="${not empty c.oldValue}"><a href="#" data-path="<c:out value='${c.oldValue}'/>" onclick="apDocDownload(this.getAttribute('data-path')); return false;">Old document</a></c:if>
												<c:if test="${empty c.oldValue}"><span class="ap-muted">-</span></c:if></td>
											<td><a href="#" data-path="<c:out value='${c.newValue}'/>" onclick="apDocDownload(this.getAttribute('data-path')); return false;">New document</a></td>
										</c:when>
										<c:otherwise>
											<td><c:out value="${empty c.oldValue ? '-' : c.oldValue}"/></td>
											<td class="ap-changed"><c:out value="${empty c.newValue ? '-' : c.newValue}"/></td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<div class="ap-card">
		<div class="ap-card-head">Remark / Order of Appellate Officer</div>
		<div class="ap-card-body">
			<c:choose>
				<c:when test="${not empty appeal.appellateRemark}">
					<p style="margin: 0 0 6px; white-space: pre-wrap"><c:out value="${appeal.appellateRemark}"/></p>
					<p class="ap-small ap-muted" style="margin: 0">By <c:out value="${appeal.appellateRemarkBy}"/> on
						<fmt:formatDate value="${appeal.appellateRemarkDate}" pattern="dd/MM/yyyy HH:mm"/>
						<c:if test="${not empty appeal.departmentSeenBy}"> &middot; seen by <c:out value="${appeal.departmentSeenBy}"/> on
							<fmt:formatDate value="${appeal.departmentSeenDate}" pattern="dd/MM/yyyy HH:mm"/></c:if></p>
				</c:when>
				<c:otherwise><span class="ap-muted">No remark yet.</span></c:otherwise>
			</c:choose>
			<c:if test="${not empty appeal.closedRemark and appeal.closedRemark != appeal.appellateRemark}">
				<p style="margin: 10px 0 0"><b>Closing remark:</b> <c:out value="${appeal.closedRemark}"/></p>
			</c:if>
			<c:if test="${not empty appeal.appellateOrderPath}">
				<p style="margin: 10px 0 0"><a class="ap-btn ap-btn-green ap-btn-sm" target="_blank"
					href="<c:out value='${contextRoot}'/>/rtsappeal/downloadOrder.do?id=${appeal.rtsAppealId}">View Order</a></p>
			</c:if>
		</div>
	</div>

	<c:if test="${isAppellateOfficer and appeal.status == 0}">
		<div class="ap-card">
			<div class="ap-card-head">Action (Appellate Officer)</div>
			<div class="ap-card-body">
				<input type="hidden" name="id" value="${appeal.rtsAppealId}"/>
				<input type="hidden" name="appealAction" id="apActionField" value=""/>
				<div class="ap-form-row">
					<label for="apRemark">Remark / Order details <span class="ap-req">*</span></label>
					<textarea id="apRemark" name="appellateRemark" maxlength="4000"
						placeholder="Remark and directions for the department, or the decision when closing the appeal"></textarea>
				</div>
				<div class="ap-form-row">
					<label for="apOrder">Order (if an order is passed) - PDF / JPG / PNG, max 10 MB</label>
					<input type="file" id="apOrder" name="orderFile" accept=".pdf,.jpg,.jpeg,.png"/>
				</div>
				<div class="ap-actions">
					<button type="button" class="ap-btn ap-btn-green" onclick="apAppealAction('SEND_BACK')">Send back to department</button>
					<button type="button" class="ap-btn ap-btn-red" onclick="apAppealAction('CLOSE')">Close appeal</button>
				</div>
				<p class="ap-small ap-muted" style="margin-top: 8px">Send back: the application continues in the workflow (see above).
					Close appeal: the appeal is decided without sending it back; the application keeps its earlier status and the citizen may file the
					<c:out value="${appeal.appealLevel == 1 ? 'Second Appeal' : 'next appeal outside this portal'}"/>.</p>
			</div>
		</div>
	</c:if>

	<div class="ap-card">
		<div class="ap-card-head">History</div>
		<div class="ap-card-body">
			<ul class="ap-timeline">
				<c:forEach items="${history}" var="h">
					<li>
						<div><b><c:out value="${h.action}"/></b></div>
						<c:if test="${not empty h.remark}"><div class="ap-small" style="white-space: pre-wrap"><c:out value="${h.remark}"/></div></c:if>
						<div class="ap-when"><fmt:formatDate value="${h.actionDate}" pattern="dd/MM/yyyy HH:mm"/> &middot; <c:out value="${h.actionBy}"/></div>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
</div>

<script type="text/javascript">
	function apDocDownload(filesPath) {
		window.open('<c:out value="${contextRoot}"/>/rtsApplication/getPdf.do?fp=' + btoa(encodeURIComponent(filesPath)), '_blank');
	}

	function apAppealAction(action) {
		var remark = document.getElementById('apRemark');
		if (!remark.value.replace(/\s/g, '')) {
			alert('Please enter the remark / order details.');
			remark.focus();
			return;
		}
		var question = action === 'CLOSE' ? 'Close this appeal without sending the application back?'
				: 'Send the application back to the department?';
		if (!confirm(question)) {
			return;
		}
		document.getElementById('apActionField').value = action;
		document.frmPage.action = '<c:out value="${contextRoot}"/>/rtsappeal/saveAppealAction.do';
		document.frmPage.submit();
	}

	<%-- opens the application in the existing screen (same as the task inbox) --%>
	function apOpenApplication(refId, id) {
		var form = document.createElement('form');
		form.method = 'post';
		form.action = '<c:out value="${contextRoot}"/>/rtiapplication/editAnyRTIApplication.do';
		var fields = { rtiApplicationRefId: refId, rtiApplicationId: id };
		for (var name in fields) {
			var input = document.createElement('input');
			input.type = 'hidden';
			input.name = name;
			input.value = fields[name];
			form.appendChild(input);
		}
		document.body.appendChild(form);
		form.submit();
	}
</script>
