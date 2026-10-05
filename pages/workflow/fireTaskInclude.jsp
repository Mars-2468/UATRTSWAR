<%--
	fireTaskInclude.jsp

	Self-contained workflow include for the Fire NOC module (fire_final_noc).
	Renders the workflow box (hidden fields, action buttons, task history)
	AND wires up the Fire-NOC-specific JS. Does NOT depend on the shared
	/pages/workflow/taskInclude.jsp, because that file hardcodes
	tree-cutting/heritage-tree logic. Include ONLY this file:

		<%@include file="/pages/workflow/fireTaskInclude.jsp" %>

	Requires the including page to have already done:
		pageContext.setAttribute("WORKFLOW_ACTION", ...)
		pageContext.setAttribute("WORKFLOW_ACTION_COMPLETE_TASK", ...)
		pageContext.setAttribute("WORKFLOW_ACTION_CREATE_PROCESS", ...)
		pageContext.setAttribute("WORKFLOW_TRANSISTION", ...)
		pageContext.setAttribute("WORKFLOW_NAME", ...)
		pageContext.setAttribute("WORKFLOW_ENTITYNAME", ...)
		pageContext.setAttribute("WORKFLOW_ENTITYID", ...)
		pageContext.setAttribute("WORKFLOW_JOB_ID", ...)
		pageContext.setAttribute("WORKFLOW_TASK_ID", ...)
		pageContext.setAttribute("WORKFLOW_COMMENTS", ...)
		pageContext.setAttribute("WORKFLOW_PRIORITY*", ...)
	(manageFireComplianceCertificate.jsp already does this at the top.)

	Transitions used by fire_final_noc.jpdl: L1Forward, Send-Demand,
	Close-Application, Reject.

	Requirement implemented here:
	  1. L1 must upload Inspection Report + Digital Photos before
	     forwarding (L1Forward). Final NOC Charges is optional at L1 -
	     if entered it is saved, but is never required to be non-blank.
	  2. At L2 Verification both "Send-Demand" and "Close-Application"
	     transitions exist in the process, but only ONE is shown at a
	     time, decided LIVE from the Final NOC Charges field:
	       - charges > 0   -> show "Send-Demand" only
	       - blank / 0     -> show "Close-Application" only
	     The field is re-checked the instant the user types in it
	     (input/keyup/change), not just on click.
	  3. At L2 Finalize NOC (post payment) only "Close-Application"
	     exists in the process anyway - nothing to toggle, it always
	     shows.
--%>
<style type="text/css">
	#fireWorkflowDiv .status.approveOn,
	#fireWorkflowDiv .status.approveOff,
	#fireWorkflowDiv .status.othersOn,
	#fireWorkflowDiv .status.othersOff {
		background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'><circle cx='12' cy='12' r='11' fill='%2328a745'/><path d='M7 12.5l3.2 3.2L17 9' fill='none' stroke='white' stroke-width='2.2' stroke-linecap='round' stroke-linejoin='round'/></svg>") !important;
		background-repeat: no-repeat !important;
		background-position: center center !important;
		background-size: contain !important;
	}
	#fireWorkflowDiv .status.rejectOn,
	#fireWorkflowDiv .status.rejectOff {
		background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'><circle cx='12' cy='12' r='11' fill='%23dc3545'/><path d='M8 8l8 8M16 8l-8 8' fill='none' stroke='white' stroke-width='2.2' stroke-linecap='round'/></svg>") !important;
		background-repeat: no-repeat !important;
		background-position: center center !important;
		background-size: contain !important;
	}
</style>

<c:if test="${workflowRequired eq 'true'}">
<div class="workflowBox" id="fireWorkflowDiv">

	<%-- Hidden fields live INSIDE the box so they are always present
	     whenever this box is rendered (full load or partial refresh). --%>
	<input type="hidden" name="<c:out value="${pageScope.WORKFLOW_ACTION}"/>"
		id="<c:out value="${pageScope.WORKFLOW_ACTION}"/>" value="" />
	<input type="hidden" name="<c:out value="${pageScope.WORKFLOW_TRANSISTION}"/>"
		id="<c:out value="${pageScope.WORKFLOW_TRANSISTION}"/>" value="" />
	<input type="hidden" name="<c:out value="${pageScope.WORKFLOW_NAME}"/>"
		id="<c:out value="${pageScope.WORKFLOW_NAME}"/>"
		value="<c:out value="${requestScope.WORKFLOW_NAME}"/>" />
	<input type="hidden" name="<c:out value="${pageScope.WORKFLOW_ENTITYNAME}"/>"
		id="<c:out value="${pageScope.WORKFLOW_ENTITYNAME}"/>"
		value="<c:out value="${requestScope.WORKFLOW_ENTITYNAME}"/>" />
	<input type="hidden" name="<c:out value="${pageScope.WORKFLOW_ENTITYID}"/>"
		id="<c:out value="${pageScope.WORKFLOW_ENTITYID}"/>"
		value="<c:out value="${requestScope.WORKFLOW_ENTITYID}"/>" />
	<input type="hidden" name="<c:out value="${pageScope.WORKFLOW_JOB_ID}"/>"
		id="<c:out value="${pageScope.WORKFLOW_JOB_ID}"/>"
		value="<c:out value="${requestScope.WORKFLOW_JOB_ID}"/>" />
	<input type="hidden" name="<c:out value="${pageScope.WORKFLOW_TASK_ID}"/>"
		id="<c:out value="${pageScope.WORKFLOW_TASK_ID}"/>"
		value="<c:out value="${requestScope.WORKFLOW_TASK_ID}"/>" />

	<div style="background-color:#e6e6e6; height:40px; padding:5px 10px 8px;">
		<span class="ClsTitle">Workflow Details</span>
	</div>

	<c:choose>

		<c:when test="${not empty nmmcWorkflowInstance.id}">
			<div style="padding:10px">
				<h3 class="tab">${requestScope.WORKFLOW_COMMENTS}</h3>

				<c:if test="${not empty PROCESS_ENDED and PROCESS_ENDED==false}">
					<div class="formBox">
						<table class="formTable" width="99%" border="0" style="float:left; margin-right:15px;">
							<tr>
								<td class="clsLabel">Priority</td>
								<td class="clsInput" colspan="3">
									<input type="radio" name="${pageScope.WORKFLOW_PRIORITY}"
										value="<c:out value="${pageScope.WORKFLOW_PRIORITY_LOW}"/>">
									<label>${pageScope.WORKFLOW_PRIORITY_LOW_LABEL}</label>
									<input type="radio" name="${pageScope.WORKFLOW_PRIORITY}"
										value="<c:out value="${pageScope.WORKFLOW_PRIORITY_MEDIUM}"/>" checked>
									<label>${pageScope.WORKFLOW_PRIORITY_MEDIUM_LABEL}</label>
									<input type="radio" name="${pageScope.WORKFLOW_PRIORITY}"
										value="<c:out value="${pageScope.WORKFLOW_PRIORITY_HIGH}"/>">
									<label>${pageScope.WORKFLOW_PRIORITY_HIGH_LABEL}</label>
								</td>
							</tr>
							<tr>
								<td class="clsLabel">Remarks</td>
								<td class="clsInput">
									<textarea style="width:300px;" id="${WORKFLOW_COMMENTS}" maxlength="1000"
										name="${WORKFLOW_COMMENTS}"></textarea>
								</td>
							</tr>
							<tr>
								<td class="clsLabel">Action</td>
								<td class="clsInput" colspan="3">
									<c:set var="workflowButton" value="On"></c:set>
									<c:if test="${not empty IS_MY_TASK and IS_MY_TASK==false}">
										<c:set var="workflowButton" value="Off"></c:set>
									</c:if>

									<c:forEach var="taskTransitionName" items="${WORKFLOW_TRANSISTIONS}" varStatus="iCount">
										<c:choose>
											<c:when test="${taskTransitionName eq 'Reject'}">
												<div class="statusOption" id="wf_wrap_${taskTransitionName}">
													<div class="status reject${workflowButton}"
														id="workflow_tras_${taskTransitionName}"
														title="${taskTransitionName}"
														onclick="javascript:fireRejectTask('${taskTransitionName}')"
														style="cursor:pointer"></div>
													<c:out value="${taskTransitionName}" />
												</div>
											</c:when>
											<c:otherwise>
												<div class="statusOption" id="wf_wrap_${taskTransitionName}">
													<div class="status approve${workflowButton}"
														id="workflow_tras_${taskTransitionName}"
														title="${taskTransitionName}"
														onclick="javascript:fireCompleteTask('${taskTransitionName}')"
														style="cursor:pointer"></div>
													<c:out value="${taskTransitionName}" />
												</div>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</td>
							</tr>
						</table>
					</div>
				</c:if>

				<table border="0" width="100%" class="dataGrid" style="table-layout: fixed">
					<thead>
						<tr class="ClsTRHeaderList">
							<td>Task Id</td><td>Action</td><td>User Name</td><td>Start Date</td><td>End Date</td><td>Comments</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="listTaskHistory" items="${requestScope.TASK_HISTORY}">
							<c:forEach var="taskHistory" items="${listTaskHistory}">
								<tr>
									<td><c:out value="${taskHistory.taskId}" /></td>
									<td><c:out value="${taskHistory.outcome}" /></td>
									<td><c:out value="${taskHistory.assignee}" /></td>
									<td><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${taskHistory.createTime}" /></td>
									<td><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${taskHistory.endTime}" /></td>
									<td style="word-wrap: break-word;"><c:out value="${taskHistory.comments}" /></td>
								</tr>
							</c:forEach>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</c:when>

		<c:otherwise>
			<div style="padding:10px">
				<h3 class="tab">Create Workflow</h3>
				<table class="formTable" border="0" width="40%">
					<tr>
						<td class="ClsLabel">Task Description</td>
						<td>
							<textarea style="width:300px;" id="${WORKFLOW_COMMENTS}" maxlength="1000"
								name="${WORKFLOW_COMMENTS}"></textarea>
						</td>
					</tr>
					<tr>
						<td class="ClsLabel"></td>
						<td>
							<input type="button" name="CreateWorkflow" id="CreateWorkflow" value="Create Workflow"
								onclick="javascript:fireCreateWorkflow();" class="ClsButton" />
						</td>
					</tr>
				</table>
			</div>
		</c:otherwise>
	</c:choose>
</div>
</c:if>

<script type="text/javascript">

	function disableControlsByJquery(blnStatus) {
		if (!blnStatus) {
			$('#SetFormHeight *').removeAttr('disabled');
			$('#SetFormHeight a').removeClass("not-active");
		} else {
			$('#SetFormHeight *').attr('disabled', true);
			$('#SetFormHeight a').addClass("not-active");
		}
		$('.downloadFile, .downloadFile1, .downloadFile2, .downloadFile3')
			.removeAttr('disabled').removeClass("not-active");
	}

	function disableEnableControls(obj) {
		if (obj.checked) {
			disableControlsByJquery(false);
		} else {
			disableControlsByJquery(true);
			$('#fireWorkflowDiv *').removeAttr('disabled');
		}
	}

	
	function fireToggleL2Buttons() {
		var sendWrap  = document.getElementById('wf_wrap_Send-Demand');
		var closeWrap = document.getElementById('wf_wrap_Close-Application');

		if (!sendWrap || !closeWrap) {
			return;
		}

		var chargesEl = document.getElementById('finalNocChargesInput');
		var charges = chargesEl ? parseFloat(chargesEl.value) : NaN;
		charges = isNaN(charges) ? 0 : charges;

		if (charges > 0) {
			sendWrap.style.display  = '';
			closeWrap.style.display = 'none';
		} else {
			sendWrap.style.display  = 'none';
			closeWrap.style.display = '';
		}
	}

	function fireWireUp() {
		try {
			$('.mainHdr a').attr("href", "javascript:void(0)");

			<c:choose>
				<c:when test="${not empty IS_MY_TASK and IS_MY_TASK==false}">
					disableControlsByJquery(true);
					$('#SetFormHeight a').attr("onclick", "javascript:void(0)");
					<c:forEach var="taskTransitionName" items="${WORKFLOW_TRANSISTIONS}" varStatus="iCount">
						var fbtn${iCount.index} = document.getElementById('workflow_tras_${taskTransitionName}');
						if (fbtn${iCount.index}) { fbtn${iCount.index}.setAttribute("onclick", "javascript:void(0);"); }
					</c:forEach>
				</c:when>
				<c:when test="${not empty IS_MY_TASK and IS_MY_TASK==true}">
					disableControlsByJquery(true);
					$('#fireWorkflowDiv *').removeAttr('disabled');
				</c:when>
				<c:when test="${not empty PROCESS_ENDED and PROCESS_ENDED==true}">
					disableControlsByJquery(true);
					$('#SetFormHeight a').attr("onclick", "javascript:void(0)");
				</c:when>
			</c:choose>

			// Initial button visibility for this task, then keep it live.
			fireToggleL2Buttons();
			var chargesInput = document.getElementById('finalNocChargesInput');
			if (chargesInput) {
				chargesInput.addEventListener('input', fireToggleL2Buttons);
				chargesInput.addEventListener('keyup', fireToggleL2Buttons);
				chargesInput.addEventListener('change', fireToggleL2Buttons);
			}

		} catch (e) {
			if (window.console && console.warn) { console.warn('fireWireUp skipped:', e); }
		}
	}
	if (window.jQuery) { jQuery(fireWireUp); }
	else if (window.addEventListener) { window.addEventListener('load', fireWireUp); }

	function saveEntity() {
		onPageSubmit('<c:out value="${contextRoot}"/>/rtiapplication/createFireComplianceCertificate.do');
	}

	function fireCreateWorkflow() {
		if (checkMandatoryDetailed(new Array('${WORKFLOW_COMMENTS}'), new Array('Task Description'))) {
			if (confirm("Do you really want to Create WorkFlow ?")) {
				document.getElementById('<c:out value="${pageScope.WORKFLOW_ACTION}"/>').value =
					'<c:out value="${pageScope.WORKFLOW_ACTION_CREATE_PROCESS}"/>';
				disableControlsByJquery(false);
				saveEntity();
			}
		}
		return false;
	}

	/*
	  Fire-module completeTask. transitionName is exactly what was
	  clicked - never re-resolved/switched, since only the correct
	  button is visible at any time (see fireToggleL2Buttons above).
	  Still defensively re-validated here in case a button becomes
	  reachable some other way (keyboard, stale DOM, etc).
	*/
	function fireCompleteTask(transitionName) {

		if (transitionName === 'Forward') {
			var inspectionReport = '${fireComplianceCertificate.inspectionReport}';
			var digitalPhotos    = '${fireComplianceCertificate.nocPhotosUpload}';

			if (!inspectionReport || inspectionReport.trim() === '') {
				alert("Please upload the Inspection Report before forwarding this application.");
				return false;
			}
			if (!digitalPhotos || digitalPhotos.trim() === '') {
				alert("Please upload the Digital Photos before forwarding this application.");
				return false;
			}
			// Final NOC Charges is optional at L1 - not checked here.
		}

		if (transitionName === 'Send-Demand') {
			var chargesEl = document.getElementById('finalNocChargesInput');
			var charges = chargesEl ? parseFloat(chargesEl.value) : NaN;
			charges = isNaN(charges) ? 0 : charges;
			if (!(charges > 0)) {
				alert("Final NOC Charges must be greater than 0 to send a demand.");
				return false;
			}
			if (!confirm("A demand of Rs. " + charges + " will be sent to the citizen for payment.\n\nContinue?")) {
				return false;
			}
		}

		if (transitionName === 'Close-Application') {
			var certPath = '${requestScope.rtiApplication.pdfFilesSavedPath}';
			if (!certPath || certPath.trim() === '') {
				alert("Please Upload the Certificate!!");
				return false;
			}
			if (!confirm("Do you really want to close the application?")) {
				return false;
			}
		}

		if (checkMandatoryDetailed(new Array('${WORKFLOW_COMMENTS}'), new Array('Remarks'))) {
			document.getElementById('<c:out value="${pageScope.WORKFLOW_ACTION}"/>').value =
				'<c:out value="${pageScope.WORKFLOW_ACTION_COMPLETE_TASK}"/>';
			document.getElementById('<c:out value="${pageScope.WORKFLOW_TRANSISTION}"/>').value = transitionName;
			disableControlsByJquery(false);
			saveEntity();
		} else {
			return false;
		}
	}

	function fireRejectTask(transitionName) {
		if (checkMandatoryDetailed(new Array('${WORKFLOW_COMMENTS}'), new Array('Remarks'))) {
			document.getElementById('<c:out value="${pageScope.WORKFLOW_ACTION}"/>').value =
				'<c:out value="${pageScope.WORKFLOW_ACTION_COMPLETE_TASK}"/>';
			document.getElementById('<c:out value="${pageScope.WORKFLOW_TRANSISTION}"/>').value = transitionName;
			disableControlsByJquery(false);
			saveEntity();
		} else {
			return false;
		}
	}

</script>
