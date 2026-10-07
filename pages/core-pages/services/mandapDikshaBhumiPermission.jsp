<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mars.common.utils.CommonUtils"%>
<%@page import="com.mars.rti.utils.CoreConstants"%>
<%@include file="/pages/common/include.jsp"%>
<%@page import="com.mars.common.utils.Constants"%>
<%@page import="com.mars.workflow.utils.WorkflowConstants"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="com.mars.common.utils.SessionUser"%>
<%@ page import="com.mars.common.model.User"%>
<jsp:directive.include file="/pages/common/include.jsp" />

<%
pageContext.setAttribute("DATE_FORMAT", Constants.DATE_FORMAT);
pageContext.setAttribute("DATE_TIME_DB_FORMAT", Constants.DATE_TIME_DB_FORMAT);

pageContext.setAttribute("DATE_TIME_FORMAT", WorkflowConstants.WORKFLOW_DATE_FORMAT);
//birth
pageContext.setAttribute("LABEL_HOSPITAL_NAME_YASH", CoreConstants.LABEL_HOSPITAL_NAME_YASH);
pageContext.setAttribute("LABEL_HOSPITAL_NAME_MEDI", CoreConstants.LABEL_HOSPITAL_NAME_MEDI);

pageContext.setAttribute("HOSPITAL_NAME_YASH", CoreConstants.HOSPITAL_NAME_YASH);
pageContext.setAttribute("HOSPITAL_NAME_MEDI", CoreConstants.HOSPITAL_NAME_MEDI);

pageContext.setAttribute("LABEL_CHILD_GENDER_MALE", CoreConstants.LABEL_CHILD_GENDER_MALE);
pageContext.setAttribute("LABEL_CHILD_GENDER_FEMALE", CoreConstants.LABEL_CHILD_GENDER_FEMALE);
pageContext.setAttribute("LABEL_CHILD_GENDER_TRANSGENDER", CoreConstants.LABEL_CHILD_GENDER_TRANSGENDER);

pageContext.setAttribute("CHILD_GENDER_MALE", CoreConstants.CHILD_GENDER_MALE);
pageContext.setAttribute("CHILD_GENDER_FEMALE", CoreConstants.CHILD_GENDER_FEMALE);
pageContext.setAttribute("CHILD_GENDER_TRANSGENDER", CoreConstants.CHILD_GENDER_TRANSGENDER);

pageContext.setAttribute("LABEL_ZONE_NUMBER_HARS", CoreConstants.LABEL_ZONE_NUMBER_HARS);
pageContext.setAttribute("LABEL_ZONE_NUMBER_EKTA", CoreConstants.LABEL_ZONE_NUMBER_EKTA);

pageContext.setAttribute("ZONE_NUMBER_HARS", CoreConstants.ZONE_NUMBER_HARS);
pageContext.setAttribute("ZONE_NUMBER_EKTA", CoreConstants.ZONE_NUMBER_EKTA);

pageContext.setAttribute("STATUS_YES_LABEL", CoreConstants.STATUS_YES_LABEL);
pageContext.setAttribute("STATUS_NO_LABEL", CoreConstants.STATUS_NO_LABEL);

pageContext.setAttribute("STATUS_YES", CoreConstants.STATUS_YES);
pageContext.setAttribute("STATUS_NO", CoreConstants.STATUS_NO);

pageContext.setAttribute("LABEL_BLOOD_GROUP_ONE", CoreConstants.LABEL_BLOOD_GROUP_ONE);
pageContext.setAttribute("LABEL_BLOOD_GROUP_TWO", CoreConstants.LABEL_BLOOD_GROUP_TWO);
pageContext.setAttribute("LABEL_BLOOD_GROUP_THREE", CoreConstants.LABEL_BLOOD_GROUP_THREE);
pageContext.setAttribute("LABEL_BLOOD_GROUP_FOUR", CoreConstants.LABEL_BLOOD_GROUP_FOUR);
pageContext.setAttribute("LABEL_BLOOD_GROUP_FIVE", CoreConstants.LABEL_BLOOD_GROUP_FIVE);
pageContext.setAttribute("LABEL_BLOOD_GROUP_SIX", CoreConstants.LABEL_BLOOD_GROUP_SIX);
pageContext.setAttribute("LABEL_BLOOD_GROUP_SEVEN", CoreConstants.LABEL_BLOOD_GROUP_SEVEN);
pageContext.setAttribute("LABEL_BLOOD_GROUP_EIGHT", CoreConstants.LABEL_BLOOD_GROUP_EIGHT);

pageContext.setAttribute("BLOOD_GROUP_ONE", CoreConstants.BLOOD_GROUP_ONE);
pageContext.setAttribute("BLOOD_GROUP_TWO", CoreConstants.BLOOD_GROUP_TWO);
pageContext.setAttribute("BLOOD_GROUP_THREE", CoreConstants.BLOOD_GROUP_THREE);
pageContext.setAttribute("BLOOD_GROUP_FOUR", CoreConstants.BLOOD_GROUP_FOUR);
pageContext.setAttribute("BLOOD_GROUP_FIVE", CoreConstants.BLOOD_GROUP_FIVE);
pageContext.setAttribute("BLOOD_GROUP_SIX", CoreConstants.BLOOD_GROUP_SIX);
pageContext.setAttribute("BLOOD_GROUP_SEVEN", CoreConstants.BLOOD_GROUP_SEVEN);
pageContext.setAttribute("BLOOD_GROUP_EIGHT", CoreConstants.BLOOD_GROUP_EIGHT);

pageContext.setAttribute("LABEL_RADIO_HOME", CoreConstants.LABEL_RADIO_HOME);
pageContext.setAttribute("LABEL_RADIO_HOSPITAL", CoreConstants.LABEL_RADIO_HOSPITAL);

pageContext.setAttribute("RADIO_HOME", CoreConstants.RADIO_HOME);
pageContext.setAttribute("RADIO_HOSPITAL", CoreConstants.RADIO_HOSPITAL);

pageContext.setAttribute("BLOOD_RELATION_ONE", CoreConstants.BLOOD_RELATION_ONE);
pageContext.setAttribute("BLOOD_RELATION_TWO", CoreConstants.BLOOD_RELATION_TWO);

pageContext.setAttribute("LABEL_BLOOD_RELATION_ONE", CoreConstants.LABEL_BLOOD_RELATION_ONE);
pageContext.setAttribute("LABEL_BLOOD_RELATION_TWO", CoreConstants.LABEL_BLOOD_RELATION_TWO);

pageContext.setAttribute("LABEL_RADIO_SAME_DAY", CoreConstants.LABEL_RADIO_SAME_DAY);
pageContext.setAttribute("LABEL_RADIO_TILL_THIRD_DAY", CoreConstants.LABEL_RADIO_TILL_THIRD_DAY);

pageContext.setAttribute("RADIO_SAME_DAY", CoreConstants.LABEL_RADIO_HOME);
pageContext.setAttribute("RADIO_TILL_THIRD_DAY", CoreConstants.RADIO_TILL_THIRD_DAY);

pageContext.setAttribute("WORKFLOW_PRIORITY", WorkflowConstants.WORKFLOW_PRIORITY);
pageContext.setAttribute("WORKFLOW_PRIORITY_LOW", WorkflowConstants.WORKFLOW_PRIORITY_LOW);
pageContext.setAttribute("WORKFLOW_PRIORITY_LOW_LABEL", WorkflowConstants.WORKFLOW_PRIORITY_LOW_LABEL);
pageContext.setAttribute("WORKFLOW_PRIORITY_MEDIUM", WorkflowConstants.WORKFLOW_PRIORITY_MEDIUM);
pageContext.setAttribute("WORKFLOW_PRIORITY_MEDIUM_LABEL", WorkflowConstants.WORKFLOW_PRIORITY_MEDIUM_LABEL);
pageContext.setAttribute("WORKFLOW_PRIORITY_HIGH", WorkflowConstants.WORKFLOW_PRIORITY_HIGH);
pageContext.setAttribute("WORKFLOW_PRIORITY_HIGH_LABEL", WorkflowConstants.WORKFLOW_PRIORITY_HIGH_LABEL);
pageContext.setAttribute("WORKFLOW_PROCESSDESCRIPTION", WorkflowConstants.WORKFLOW_PROCESSDESCRIPTION);
pageContext.setAttribute("WORKFLOW_TRANSITION", WorkflowConstants.WORKFLOW_TRANSITION);
pageContext.setAttribute("WORKFLOW_NAME", WorkflowConstants.WORKFLOW_NAME);
pageContext.setAttribute("WORKFLOW_ACTION", WorkflowConstants.WORKFLOW_ACTION);
pageContext.setAttribute("WORKFLOW_ACTION_COMPLETE_TASK", WorkflowConstants.WORKFLOW_ACTION_COMPLETE_TASK);
pageContext.setAttribute("WORKFLOW_ACTION_CREATE_PROCESS", WorkflowConstants.WORKFLOW_ACTION_CREATE_PROCESS);
pageContext.setAttribute("TAKE_TASK", WorkflowConstants.WORKFLOW_ACTION_TAKE_TASK);
pageContext.setAttribute("KILL_JOB", WorkflowConstants.WORKFLOW_ACTION_KILL_JOB);
pageContext.setAttribute("END_JOB", WorkflowConstants.WORKFLOW_ACTION_KILL_JOB);
pageContext.setAttribute("WORKFLOW_TRANSISTION", WorkflowConstants.WORKFLOW_TRANSISTION);
pageContext.setAttribute("WORKFLOW_ENTITYNAME", WorkflowConstants.WORKFLOW_ENTITYNAME);
pageContext.setAttribute("WORKFLOW_ENTITYID", WorkflowConstants.WORKFLOW_ENTITYID);
pageContext.setAttribute("WORKFLOW_JOB_ID", WorkflowConstants.WORKFLOW_JOB_ID);
pageContext.setAttribute("WORKFLOW_TASK_ID", WorkflowConstants.WORKFLOW_TASK_ID);
pageContext.setAttribute("WORKFLOW_COMMENTS", WorkflowConstants.WORKFLOW_COMMENTS);
pageContext.setAttribute("WORKFLOW_DUE_DATE", WorkflowConstants.WORKFLOW_DUE_DATE);

pageContext.setAttribute("APPL_STATUS_CLOSED", CoreConstants.APPL_STATUS_CLOSED);
pageContext.setAttribute("APPL_STATUS_NEW", CoreConstants.APPL_STATUS_NEW);
pageContext.setAttribute("APPL_STATUS_PARKED", CoreConstants.APPL_STATUS_PARKED);
pageContext.setAttribute("APPL_STATUS_APPROVED", CoreConstants.APPL_STATUS_APPROVED);
pageContext.setAttribute("APPL_STATUS_VERIFICATION", CoreConstants.APPL_STATUS_VERIFICATION);
pageContext.setAttribute("APPL_STATUS_CREATE", CoreConstants.APPL_STATUS_CREATE);

pageContext.setAttribute("APPLICATION_STATUS_LIST", CommonUtils.getApplicationStatusList());
%>

<%
HttpSession session1 = request.getSession();
SessionUser sessionUser = (SessionUser) session1.getAttribute("SessionUser");
Long userId = sessionUser.getUserId();
request.setAttribute("userId", userId);
%>

<script type="text/javascript"
	src="<c:out value="${contextRoot}"/>/scripts/jquery/jquery.ajaxfileupload.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
<script type="text/javascript">
	function editRTIApplication() {
		//document.getElementById('rtiApplicationId').value = id;
		onPageSubmit('<c:out value="${contextRoot}"/>/rtiapplication/editRTIApplication.do');
	}

	function saveBirthRegistrationCertificate() {
		onPageSubmit('<c:out value="${contextRoot}"/>/rtiapplication/saveBirthRegistrationCertificate.do');
	}

	function rtiApplicationSearch() {
		onPageSubmit('<c:out value="${contextRoot}"/>/rtiApplicationReport/listRTIApplicationReports.do');
	}

	function viewNoting() {
		onPageSubmit('<c:out value="${contextRoot}"/>/rtiApplicationReport/viewNoting.do');
	}

	function viewDrafts() {
		//document.getElementById('manageRTIApplicationId').value=id;
		onPageSubmit('<c:out value="${contextRoot}"/>/rtiApplicationReport/viewDrafts.do');
	}

	function downloadRTIApplicationList() {
		//document.getElementById('manageRTIApplicationId').value=id;
		onPageSubmit('<c:out value="${contextRoot}"/>/rtiApplicationReport/downloadRTIApplicationList.do');
	}

	function listRTIApplicationReports() {
		onPageSubmit('<c:out value="${contextRoot}"/>/rtiApplicationReport/listRTIApplicationReports.do');
	}

	function sendEmail() {
		//document.getElementById('manageRTIApplicationId').value=id;
		document.getElementById('actionTaken').value = 'email';
		onPageSubmit('<c:out value="${contextRoot}"/>/emailsms/emailSMS.do');
	}

	function sendSMS() {
		//document.getElementById('manageRTIApplicationId').value=id;
		document.getElementById('actionTaken').value = 'sms';
		onPageSubmit('<c:out value="${contextRoot}"/>/emailsms/emailSMS.do');
	}
	function download(id,url) {

		document.getElementById('rtiApplicationRefId').value = id;
		
		alert("Certificate has been generated successfully.");
		
		onPageSubmit('<c:out value="${contextRoot}"/>/rtiApplicationReport/'+url);

	}
	
	function policedownload(id,url) {

		document.getElementById('rtiApplicationRefId').value = id;
		
		alert("Certificate has been generated successfully.");
		
		onPageSubmit('<c:out value="${contextRoot}"/>/rtiApplicationReport/'+url);

	}
	
	function trafficdownload(id,url) {

		document.getElementById('rtiApplicationRefId').value = id;
		
		alert("Certificate has been generated successfully.");
		
		onPageSubmit('<c:out value="${contextRoot}"/>/rtiApplicationReport/'+url);

	}
	function firedownload(id,url) {

		document.getElementById('rtiApplicationRefId').value = id;
		
		alert("Certificate has been generated successfully.");
		
		onPageSubmit('<c:out value="${contextRoot}"/>/rtiApplicationReport/'+url);

	}
</script>
<style type="text/css">
input[type=text] {
	height: 35px;
	font-size: 15px;
}

.ClsButton {
	background-color: rgb(66, 124, 212);
	border: none;
	border-radius: 5px;
	min-height: 30px;
	min-width: 120px;
}

.ClsButton:hover {
	background: rgb(83, 83, 212);
	color: white;
}

a {
	text-decoration: none !important;
}

.input-align {
	align-items: center;
}
</style>
<style type="text/css">
input[type="text"], textarea {
	background-color: #e9ecef;

	color: #333;
}


.ClsLabel {
	font-style: normal;
	font-family: inherit;
	font-size: 10px;
	font-weight: 520 !important;
}
</style>

<div class="mainHdr">
	<h3>

		<fmt:message key="Application form for Diksha Bhumi Mandap Permission" />
		:
		<c:if test="${requestScope.rtiApplication != null}">
			<c:out value="${requestScope.rtiApplication.rtiApplnNumber}"></c:out>
		</c:if>

	</h3>
</div>
<div valign="top" id="SetFormHeight">
	<input type="hidden" name="id"
		value="${mandapPermission.dikshaBhumiMandapPermissionId}">
	<c:set var="doc"
		value="${fn:split(rtiApplication.pdfUploadFromPortal, ',')}" />
	<table width="100%" border="0" cellpadding="2" cellspacing="2">
		<tr>
		<tr>

			<td colspan="1.5"><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="Title (शीर्षक) " />:</span></td>
			<td colspan="2">

					<input type="text" class="form-control" style="width: 180px;"
						id="applicantTitle" ="50" name="applicantTitle"
						value="<c:out value="${mandapPermission.title}"/>" disabled/>
			</td>

			<td colspan="1.5"><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="Name(नाव)" />:</span><span class="ClsRequiredFields"></span></td>
			<td colspan="2">
                         <input type="text" class="form-control" style="width: 180px"
						id="applicantLastName" maxlength="50" name="firstName"
						value="<c:out value="${mandapPermission.firstName}"/>" disabled/>
			</td>
		</tr>
		<tr>
		<td colspan="1.5"><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="Father Name (वडिलांचे नाव)" />:</span></td>
			<td colspan="2">

					<input type="text" class="form-control" style="width: 180px;"
						id="applicantTitle" ="50" name="applicantTitle"
						value="<c:out value="${mandapPermission.middleName}"/>" disabled/>
				</td>
<td colspan="1.5"><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="Surname (आडनाव)" />:</span></td>
			<td colspan="2">

					<input type="text" class="form-control" style="width: 180px"
						id="applicantLastName" maxlength="50" name="applicantLastName"
						value="<c:out value="${mandapPermission.lastName}"/>" disabled/>
			</td>

		</tr>
		<tr>

<td colspan="1.5"><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="Full Name (पूर्ण नाव)" />:</span></td>
			<td colspan="2">

					<input type="text" class="form-control" style="width: 180px"
						id="applicantLastName" maxlength="50" name="applicantLastName"
						value="<c:out value="${mandapPermission.fullName}"/>" disabled/>
			<td colspan="1.5"><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="Pin Code (पिन कोड)" />:</span></td>
			<td colspan="2">

					<input type="text" class="form-control" style="width: 180px"
						id="applicantLastName" maxlength="50" name="applicantLastName"
						value="<c:out value="${mandapPermission.pinCode}"/>" disabled/>
			</td>
			</tr>
			<tr>
			
			

			<td colspan="1.5"><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key=" Address For Correspondence  (पत्रव्यवहारासाठी पत्ता) " />:</span><span
				class="ClsRequiredFields"></span></td>
			<td colspan="2">
				<%--    <spring:bind path="birthRegistration.address">
                                <input type="text" class="ClsTextbox" style="width:170px" id="address" maxlength="30" name="address" value="<c:out value="${birthRegistration.address}"/>" />
                         </spring:bind>--%> <textarea
					class="form-control" style="width: 300px" id="address"
					maxlength="30" name="address" disabled>${mandapPermission.address}</textarea>
			</td>
			
			<td colspan="1.5"><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key=" Aadhaar No.(आधार क्र.)" />:</span></td>
			<td colspan="2">

					<input type="text" class="form-control" style="width: 180px"
						id="applicantLastName" maxlength="50" name="applicantLastName"
						value="<c:out value="${mandapPermission.aadharNo}"/>" disabled/>
			</td>
			
			
		</tr>
		<tr>

			<td colspan="1.5"><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="Mobile Number (मोबाईल क्र.)" />:</span></td>
			<td colspan="2">
					<input type="text" class="form-control" style="width: 180px"
						id="ph_no" maxlength="50" name="ph_no"
						value="<c:out value="${mandapPermission.mobileNo}"/>" disabled/>
				</td>

			<td colspan="1.5"><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="Email (ईमेल आयडी )" /></span><span class="ClsRequiredFields"></span></td>
			<td colspan="2">
					<input type="text" class="form-control" id="email"
						style="width: 250px" name="email"
						value="<c:out value="${mandapPermission.email}"/>" disabled/>
				</td>
		</tr>
		
		<tr>

			

			<td colspan="1.5"><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="Zone No. (झोन
							क्र.)" /></span><span class="ClsRequiredFields">:</span>
			</td>
			<td colspan="2">
					<input type="text" class="form-control" style="width: 180px"
						id="fatherName" maxlength="45" tabindex="4" name="fatherName"
						value="<c:out value="${mandapPermission.zoneNo}"/>" disabled/>
				</td>
				<td><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="Ward No. (प्रभाग क्र.)" /></span><span class="ClsRequiredFields"></span>:
			</td>
			<td colspan="2"><input type="text" class="form-control"
				style="width: 180px" id="motherName" tabindex="5" maxlength="45"
				name="motherName"
				value="<c:out value="${mandapPermission.wardNo}"/>" disabled/></td>
				

		</tr>
		
		
		
		<tr>

			<td><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="label.mandap.fromdate" />:</span></td>
			<td colspan="2"><input type="date" class="form-control" style="width: 180px"
				id="changedHospitalNameAndAddress" maxlength="30"
				name="changedHospitalNameAndAddress"
				value="<c:out value="${mandapPermission.pavilionStartDate}"/>" disabled/></td>

			<td><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="label.mandap.todate" /><span class="ClsRequiredFields"></span>:
			</td>
			<td colspan="2"><input type="date" class="form-control" style="width: 180px"
				id="ownerName" maxlength="50" name="ownerName"
				value="<c:out value="${mandapPermission.pavilionEndDate}"/>" disabled/></td>

		</tr>
		<tr>

			

			<td><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="Reason for Pavilion
							(मंडप उभारण्याचे कारण))" /><span class="ClsRequiredFields"></span>:
			</td>
			<td>
 <textarea
					class="form-control" style="width: 300px" id="address"
					maxlength="30" name="address" disabled>${mandapPermission.reasonForCertificate}</textarea></td>
		</tr>
		

		
		
		<tr>
			<td colspan="7"><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="Area/Size of Pavilion
							(मंडपचे क्षेत्रफळ/आकार)" /><span
					class="ClsRequiredFields"></span>:</span></td>
		</tr>
		<tr>
			<td><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="Length (लांबी)" />:</span></td>
			<td><input type="text" class="form-control"
				id="certificateExpectedInDays" maxlength="10"
				name="certificateExpectedInDays"
				value="<c:out value="${mandapPermission.pavilionLength} sq.mtr"/>" disabled/>
			<td><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="Breadth (रुंदी)" />:</span></td>
			<td><input type="text" class="form-control"
				id="noOfCertificateCopies" maxlength="10"
				name="noOfCertificateCopies"
				value="<c:out value="${mandapPermission.pavilionBreadth} sq.mtr"/>" disabled/>
			</td>
			<td><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="Total Size (एकूण आकार)" />:</span></td>
			<td><input type="text" class="form-control" id=""
				maxlength="10" name=""
				value="<c:out value="${mandapPermission.totalSize}"/>" disabled/></td>
				
				
		</tr>
	
	
			<tr>
			<td colspan="7"><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="Entry Gate Size (प्रवेशद्वार आकार)" /><span
					class="ClsRequiredFields"></span>:</span></td>
		</tr>
		<tr>
			<td><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="Length (लांबी)" />:</span></td>
			<td><input type="text" class="form-control"
				id="certificateExpectedInDays" maxlength="10"
				name="certificateExpectedInDays"
				value="<c:out value="${mandapPermission.gateLength} ft"/>" disabled/>
			<td><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="Breadth (रुंदी)" />:</span></td>
			<td><input type="text" class="form-control"
				id="noOfCertificateCopies" maxlength="10"
				name="noOfCertificateCopies"
				value="<c:out value="${mandapPermission.gateBreadth} ft"/>" disabled/>
			</td>
			<td><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="Total Size (एकूण आकार)" />:</span></td>
			<td><input type="text" class="form-control" id=""
				maxlength="10" name=""
				value="<c:out value="${mandapPermission.gatetotalSize}"/>" disabled/></td>
				
				
		</tr>
	
	
	
				
		<tr>
		
			<td><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="Fees Applicable(शुल्क
										लागू)" />:</span></td>
			<td><input type="text" class="form-control"
				id="feesApplicable" maxlength="10"
				name="fees"
				value="<c:out value="${mandapPermission.fees}"/>" disabled/>
				</td>
				
				<td><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="Entry gate fees (प्रवेश द्वाराचे शुल्क)" />:</span></td>
			<td><input type="text" class="form-control"
				id="feesApplicable" maxlength="10"
				name="fees"
				value="<c:out value="${mandapPermission.gatefees}"/>" disabled/>
				</td>
				
				<td><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="Total Fees (एकूण शुल्क)" />:</span></td>
			<td><input type="text" class="form-control" id=""
				maxlength="10" name=""
				value="<c:out value="${mandapPermission.totalfees}"/>" disabled/></td>
				
		</tr>
		
			
		
		
	
	
	
	
	
	  <c:if test="${requestScope.rtiApplication.workFlowStatus==2}">

<tr>
	       <td colspan="6" align="center">
                      <a target="_blank" href="" id="genCerBtn">
                      
                      <button class="ClsButton clsButtonUpload" onclick="download(${mandapPermission.rti_ref_id},'dikshaBhumiMandapCertificateReport.do')">GENERATE CERTIFICATE</button>
                   
                     </a>
                    
           </td> 
           </tr>
</c:if>
	
		<tr>
			<td colspan="1.5"><span class="ClsLabel" style="font-size: 14px">
					Current Status:</span></td>
			<td style="width: 230px; height: 30px"><span class="ClsLabel" style="font-size:14px;color:forestgreen;"> <c:if
						test="${requestScope.rtiApplication.workFlowStatus==0}">
						Citizen Form Submitted. 
					</c:if> <c:if test="${requestScope.rtiApplication.workFlowStatus==3}">
						Citizen Payment Pending. 
					</c:if> <c:if test="${requestScope.rtiApplication.workFlowStatus==2}">
						Citizen Payment Completed
					</c:if> <c:if test="${requestScope.rtiApplication.workFlowStatus==1}">
						Completed and File Uploaded for Citizen
					</c:if> <c:if test="${requestScope.rtiApplication.workFlowStatus==5}">
						Rejected
					</c:if></span></td>
					<c:if test="${requestScope.forLogin eq 'L4'}">
								<c:if test="${requestScope.rtiApplication.workFlowStatus==2 || requestScope.rtiApplication.workFlowStatus==1}">
			
			<td colspan="2"><span class="ClsLabel" style="font-size: 14px">Certificate
					Upload: </span></td>
			<%@include file="/pages/common-pages/dms/fileUpload.jsp"%>
</c:if>

</c:if>
			<%--<td>
                            <span class="ClsLabel" style="font-size:14px"><fmt:message key="Birth Place" />:</span>
                        </td>
                         <td> <span class="ClsLabel" style="font-size:14px"><fmt:message key="Remark" />:</span></td>
                        <td >
                            
                                <input type="text" class="ClsTextbox_mr" style="width:180px" id="Remark" maxlength="12" name="Remark" value=""  />
                            
                        </td>
                         --%>
		</tr>
		</table>
		<table width="100%" border="0" >
       
						
						<tr>
						<td>
							<span class="ClsLabel" style="font-size: 12px !important;"><fmt:message key="Will the cloth, mat, wood, bamboo, wooden poles used in the tent be made fireproof?" /> </span>
						<span class="ClsLabel"  style="font-size: 12px !important;"><fmt:message key="मंडपाची वापरण्यात आलेला कापड, चटई ,लाकूड, बांबू ,लाकडी खांब हे ज्वलनशील साहित्याला अग्निरोधक प्रकिया करण्यात येणार आहे काय ?" /> </span>
							 <td>${mandapPermission.fireproof}</td>
						
						</tr>
						
						<tr>
						<td>
							<span class="ClsLabel" style="font-size: 12px !important;"><fmt:message key="Is there a minimum 9 meter wide path for fire fighting vehicles to reach the pavilion?" /> </span>
							<span class="ClsLabel" style="font-size: 12px !important;">मंडपात पोहचण्यास अग्निशमन वाहनाकरिता किमान ९ मीटर रुंदीचा मार्ग उपलब्ध आहे काय ?</span>
						 <td>${mandapPermission.vehicle}</td>
						</tr>
						
						<tr>
						<td>
							<span class="ClsLabel" style="font-size: 12px !important;"><fmt:message key="Will there be at least 4.50 meters free space around the mandap so that the fire does not spread in the surrounding buildings?" /> </span>
							<span class="ClsLabel" style="font-size: 12px !important;">आसपासच्या इमारती मध्ये आग पसरणार नाही याकरिता मंडपाच्या भोवताल किमान ४.५० मीटर मोकळी जागा येणार आहे काय ?</span></td>
						<td>${mandapPermission.building}</td>
						</tr>
						
						<tr>
						<td>
							<span class="ClsLabel" style="font-size: 12px !important;"><fmt:message key="Is there 3 meter wide gates/ways/doors available in opposite directions for safe evacuation of citizens in case of emergency?" /> </span>
						<span class="ClsLabel" style="font-size: 12px !important;"><fmt:message key="आपत्कालीन परिस्थितीत नागरिकांना सुरक्षित बाहेर पाडण्याकरिता परस्पर विरुद्ध दिशेला ३ मीटर रुंदीचे गेट/मार्ग/दरवाजे उपलब्ध आहेत काय ?" /> </span></td>
						<td>${mandapPermission.evacuation}</td>
						
						</tr>
						
					<tr>
						<td>
							<span class="ClsLabel" style="font-size: 12px !important;"><fmt:message key="Will the members of committee be trained for First-aid,  fire fighting equipment and safe evacuation of people in emergency situations?" /> </span>
							<span class="ClsLabel" style="font-size: 12px !important;">मंडपात इंधन प्रसादाकरिता स्वयंपाक घर तसेस फटाक्यांचा साथ करण्यात येणार आहे काय ?</span></td>
						<td>${mandapPermission.firecrackers}</td>
						
						</tr>		
						
					
						
					
						
						<tr>
						<td>
							<span class="ClsLabel" style="font-size: 12px !important;"><fmt:message key="Will 2 Units of 5 kg fire extinguisher and 200 liter capacity water drum be kept in the mandap for fire fighting?" /> </span>
							<span class="ClsLabel" style="font-size: 12px !important;">अग्निशमन  करीत २ नग ५ किलो   फायर एक्स्टिंगशूर तसेच २०० लिटर क्षमतेचे पाण्याचे ?</span></td>
						<td>${mandapPermission.extinguisher}</td>
						
						</tr>
						
						<tr>
						<td>
							<span class="ClsLabel" style="font-size: 12px !important;"><fmt:message key="Will the workers in the board be trained in first aid use of fire fighting equipment and safe evacuation of people in emergency situations?" /> </span>
							<span class="ClsLabel" style="font-size: 12px !important;">मंडळातील कार्यकर्त्यांना प्रथमाचार अग्निशमन साहित्य वापरण्यात तसेच आपत्कालीन परिस्थिती लोकांना सुखरूप बाहेर काढण्याकरिता प्रशिक्षण देण्यात येणार आहे काय ?</span></td>
						<td>${mandapPermission.trained}</td>
						
						</tr>
						
						<tr>
						<td>
							<span class="ClsLabel" style="font-size: 12px !important;"><fmt:message key="2 Units of 5 kg capacity A B C type fire extinguishers and 200 liter capacity water drum will be kept in the pavilion for fire fighting?" /> </span>
							<span class="ClsLabel" style="font-size: 12px !important;">अग्निशमन  करीत २ नग ५ किलो  क्षमतेचे  A B C type  फायर एक्स्टिंगशूर तसेच २०० लिटर क्षमतेचे पाण्याचे ड्रम मंडपात ठेवण्यात येणार आहे काय ?</span></td>
						<td>${mandapPermission.pavilionfighting}</td>
						
						</tr>
						
					
						<tr>
						<td>
							<span class="ClsLabel" style="font-size: 12px !important;"><fmt:message key="Is the entrance for fire-fighting vehicles provided with a minimum clear height of 4.5 m and width of 6.0 m, and is the access route kept clear at all times for emergency movement?"/></span>
							<span class="ClsLabel" style="font-size: 12px !important;">अग्निशमन वाहनासाठी प्रवेशद्वाराची उभी मोकळी उंची किमान 4.5 मी. व रुंदी किमान 6.0 मी. असून, आपत्कालीन हालचालीसाठी प्रवेशमार्ग सदैव मोकळा ठेवण्यात आला आहे का?</span></td>
						<td>${mandapPermission.electricalWiring}</td>
						
						</tr>

    </table>
	
	

	<table width="100%" border="0" cellpadding="2" cellspacing="2">

		<tr>
			<td colspan="7"><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="List of Documents (Attachment) दस्तऐवजांची यादी (संलग्नक)" />:</span></td>
		</tr>

<input type="hidden" name="filesPath" value=""/>


		<c:if test="${doc[0] != 'null'}">
			<tr>
			<td colspan="3.5"><span class="ClsLabel"
    style="font-size: 14px"><fmt:message
        key="Site Viewer Map with Detailed Information ( तपशीलवार माहितीसह साइट दर्शक नकाशा)" />:</span></td>

				<td style="text-align: center" colspan="3.5"><a class="bg-button btn btn-primary bd-highlight action"
   type="button"
   target="_blank"
   onclick="docDownload('${doc[0]}');">
   <span class="download" style="align-items: center;color:white;">Download</span>
</a></td>
			</tr>
		</c:if>
		
		
		
		
<c:if test="${requestScope.forLogin eq 'L3' ||  requestScope.forLogin eq 'L2' || requestScope.rtiApplication.workFlowStatus==2 || requestScope.rtiApplication.workFlowStatus==1 || requestScope.rtiApplication.workFlowStatus==5}">
			
			<tr>
				<td colspan="3.5"><span class="ClsLabel"
					style="font-size: 14px"><fmt:message
							key="NOC From Fire Department (
अग्निशमन विभागाकडून एनओसी)" />:</span> 
				<td style="text-align: center" colspan="3.5">
				 <c:choose>
        <c:when test="${empty mandapPermission.fireNoc}">
				<input type="file" name="doc2" id="doc2" class="imagefile" style="width: 168px" />
				<hr>
<button style="margin-right: 15px; margin-top: 2px;" onclick="firedownload(${mandapPermission.rti_ref_id},'dikshaBhumifireNocCertificateReport.do')">Download Fire NOC</button>
			<td>
   
    <a class="bg-button btn btn-primary bd-highlight" style="color:white" id="upload2"  type="button" target="_blank" onclick="javascript:uploadFireNoc(this);"><span
							class="download" style="align-items: center">Upload</span></a>        </c:when>
        <c:when test="${not empty mandapPermission.fireNoc}">
          <a class="bg-button btn btn-success bd-highlight action"
   type="button"
   target="_blank"
   onclick="docDownload('${mandapPermission.fireNoc}');">
   <span class="download" style="align-items: center;color:white;">Download</span>
</a>
        </c:when>
    </c:choose>
</td>


			</tr>
		
			
			</c:if>
			
	<table width="100%" border="0" cellpadding="1" cellspacing="1">
		
<c:if test="${requestScope.forLogin eq 'L3' ||  requestScope.forLogin eq 'L2' || requestScope.rtiApplication.workFlowStatus==2 || requestScope.rtiApplication.workFlowStatus==1 || requestScope.rtiApplication.workFlowStatus==5}">
			
						<tr>
			
			<td><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="Fire Remarks (फायर रिमार्क्स)" />:</span></td>
						<td>
		 <textarea
					class="form-control" style="width: 400px" id="fireremarks"
					maxlength="30" name="fireremarks" maxlength="80" readonly>${mandapPermission.fireremarks}</textarea>
			
			</td>
			</tr></c:if>
			<script>
			$(document).ready(function() {
			 
			    $("#fireremarks").attr('readonly', true);
			});

			</script>
			<script>
	$(document).ready(function() {
	    var userId = <%= request.getAttribute("userId") %>; // Retrieve userId from JSP attribute

	    if (userId == 3800 || userId == 3801) {
	        // Disable the input box if the condition is met
	    
		        $("#fireremarks").attr("disabled", true);

	    }
	});
	</script>
		
		</table>
		
		

		<%--  <tr>
            <td colspan="6" style="padding-top:5px">
                <img src="../images/Transpx.gif" height="15px" />
            </td>
        </tr>
         <tr>
            <td colspan="6" align="center">
                <input type="button" class="ClsButton" id="save" name="save" value="Save"
                       onclick="javascript:saveBirthRegistrationCertificate(this.form);" tabindex="31">
                       <input type="button" class="ClsButton" id="clear" name="clear" value="<fmt:message key="common.button.clear"/>"
							onclick="javascript:clearFields('SearchTable');searchRTIApplication()" /> --%>
							
		<input type="hidden" name="UID" value="${mandapPermission.rti_ref_id}" />
		
	  <c:if test="${requestScope.rtiApplication.workFlowStatus!=1}">	
<tr>

<td colspan="4" align="center"><input type="button"
				class="btn btn-primary"
				style="min-height: 30px; min-width: 80px; color: white; border: none; outline: #28a745;margin-left:50px;"
				id="savefees" name="savefees"
				value="<fmt:message key="Save"/>"
				onclick="javascript:saveFees(this.form);">
</td>
</tr>
</c:if>

	</table>

	<input type="hidden" class="ClsTextbox_mr" style="width: 180px"
		id="dikshaBhumiMandapPermissionId" maxlength="12" name="dikshaBhumiMandapPermissionId"
		value="<c:out value="${mandapPermission.dikshaBhumiMandapPermissionId}"/>" /> 
		
		<%-- <input
		type="hidden" class="ClsTextbox_mr" style="width: 180px;"
		id="rtiApplicationRefId" maxlength="12" name="rtiApplicationRefId"
		value="<c:out value="${requestScope.rtiApplication.rtiApplicationId}"/>" />
		 --%>
		
</table>
			  <input type="hidden" id="rtiApplicationRefId" name="rtiApplicationRefId" value="" />
			  			  <input type="hidden" id="rtiApplicationRefIds" name="rtiApplicationRefIds" value="${mandapPermission.rti_ref_id}" />
			  
	
<c:if test="${requestScope.forLogin eq 'L4' || requestScope.rtiApplication.workFlowStatus==2 || requestScope.rtiApplication.workFlowStatus==1 || requestScope.rtiApplication.workFlowStatus==5}">

	<%@include file="/pages/workflow/taskInclude.jsp"%>
	</c:if>


</div>
</div>

<script type="text/javascript">
	function saveEntity() {
		onPageSubmit('<c:out value="${contextRoot}"/>/rtsapplication/createDikshaBhumiMandapPermissionWork.do');
	}
	</script>
	
	<script type="text/javascript">
	function saveFees(){
		
				onPageSubmit('<c:out value="${contextRoot}"/>/rtsapplication/saveDikshaBhumiMandap.do');

	}
	
	</script>
	<script type="text/javascript">

	$(document).ready(function() {
	
	    var fireremarks = '${mandapPermission.fireremarks}';


	
	    if (dikshaBhumiMandapPermissionId && fireremarks.trim() !== "") {
	        $("#fireremarks").prop('readonly', true);
	    } else {
	        $("#fireremarks").prop('readonly', false);
	    }
	});

</script>
		<script type="text/javascript">
	
    function uploadPoliceNoc() {
        console.log("@@upoading@@");
        var url = window.location.href;
        var basePath = url.split('${contextRoot}')[0] + '${contextRoot}/';
        var filesPath = "";
        var data = new FormData();
        var idProofFile = $("#doc1").get(0).files[0];
        

        if (!idProofFile) {
            alert("Please upload the Police NOC certificate.");
            return; 
        }
        
        var fileName = idProofFile.name;
        var fileExtension = fileName.split('.').pop().toLowerCase();

        if (fileExtension !== 'pdf') {
            alert("Please select a PDF file.");
            return;
        }
        
        data.append('idProof1', $("#doc1").get(0).files[0]);


        var isFileSelected = false

        var array_element = "";
        var file = $('input[id="doc1"]');
        for (var i = 0; i < file.length; i++) {
   			var array_element = file[i];
   			var element = array_element.value.split("\\");
   			var a = element[element.length-1];
   			const splitName = a.split(".pdf")[0].replaceAll(/[^a-zA-Z0-9]/g, ""); 
   			const value = splitName + ".pdf";
   			 if(a==='' || a===undefined){
   		        filesPath += "null" + ",";
   	             isFileSelected = false;
            } else {
                filesPath = filesPath + basePath + "dikshaBhumiPermission/" + i + value + ","
                isFileSelected = true;
            }
        }
        var appType = 1;
        var uid1 = document.getElementById('dikshaBhumiMandapPermissionId').value;
        $.ajax({
            url: "<c:out value='${contextRoot}'/>/rtsapplication/uploadDikshaBhumiMandapNoc.do?appType="+appType+"&UID="+uid1,
            type: 'POST',
            data: data,
            cache: false,
            dataType: 'json',
            processData: false, 
            contentType: false 
            }).done(function (data) {
            	if(data.status==true || data.status=='true'){
              	  
                    alert("Police NOC Certificate uploaded Successfully");
                    window.location.reload(); 
              	}else{
                      alert("Police NOC Certificate upload failed!!");

              	}
        });

        var a = filesPath.substring(0, filesPath.lastIndexOf(","));
        filesPath = filesPath.replace(/\s/g, "");
        $("#filesPath").val(filesPath);
        console.log(filesPath);

    }
    </script>
    
    	<script type="text/javascript">
    
    
    function uploadFireNoc() {
        console.log("@@upoading@@");
        var url = window.location.href;
        var basePath = url.split('${contextRoot}')[0] + '${contextRoot}/';
        var filesPath = "";
        var data = new FormData();
        var idProofFile = $("#doc2").get(0).files[0];
        if (!idProofFile) {
            alert("Please upload the Fire NOC certificate.");
            return; 
        }
        var fileName = idProofFile.name;
        var fileExtension = fileName.split('.').pop().toLowerCase();

        if (fileExtension !== 'pdf') {
            alert("Please select a PDF file.");
            return;
        }
        data.append('idProof2', $("#doc2").get(0).files[0]);


        var isFileSelected = false

        var array_element = "";
        var file = $('input[id="doc2"]');
        for (var i = 0; i < file.length; i++) {
   			var array_element = file[i];
   			var element = array_element.value.split("\\");
   			var a = element[element.length-1];
   			const splitName = a.split(".pdf")[0].replaceAll(/[^a-zA-Z0-9]/g, ""); 
   			const value = splitName + ".pdf";
   			 if(a==='' || a===undefined){
   		        filesPath += "null" + ",";
   	             isFileSelected = false;
            } else {
                filesPath = filesPath + basePath + "durgaUtsavPermission/" + i + value + ","
                isFileSelected = true;
            }
        }
        var appType = 2;
        var uid1 = document.getElementById('dikshaBhumiMandapPermissionId').value;
        $.ajax({
            url: "<c:out value='${contextRoot}'/>/rtsapplication/uploadDikshaBhumiMandapNoc.do?appType="+appType+"&UID="+uid1,
            type: 'POST',
            data: data,
            cache: false,
            dataType: 'json',
            processData: false, 
            contentType: false 
        }).done(function (data) {
        	if(data.status==true || data.status=='true'){
            	  
                alert("Fire NOC Certificate uploaded Successfully");
                window.location.reload(); 
          	}else{
                  alert("Fire NOC Certificate upload failed!!");

          	}
        });

        var a = filesPath.substring(0, filesPath.lastIndexOf(","));
        filesPath = filesPath.replace(/\s/g, "");
        $("#filesPath").val(filesPath);
        console.log(filesPath);

    }
    </script>
    
    	<script type="text/javascript">
    
    function uploadTrafficNoc() {
        console.log("@@upoading@@");
        var url = window.location.href;
        var basePath = url.split('${contextRoot}')[0] + '${contextRoot}/';
        var filesPath = "";
        var data = new FormData();

        var idProofFile = $("#doc3").get(0).files[0];

        if (!idProofFile) {
            alert("Please upload the Traffic NOC certificate.");
            return; 
        }
        
        var fileName = idProofFile.name;
        var fileExtension = fileName.split('.').pop().toLowerCase();

        if (fileExtension !== 'pdf') {
            alert("Please select a PDF file.");
            return;
        }
        
        data.append('idProof3', $("#doc3").get(0).files[0]);


        var isFileSelected = false

        var array_element = "";
        var file = $('input[id="doc3"]');
        for (var i = 0; i < file.length; i++) {
   			var array_element = file[i];
   			var element = array_element.value.split("\\");
   			var a = element[element.length-1];
   			const splitName = a.split(".pdf")[0].replaceAll(/[^a-zA-Z0-9]/g, ""); 
   			const value = splitName + ".pdf";
   			 if(a==='' || a===undefined){
   		        filesPath += "null" + ",";
   	             isFileSelected = false;
            } else {
                filesPath = filesPath + basePath + "durgaUtsavPermission/" + i + value + ","
                isFileSelected = true;
            }
        }
        var appType = 3;
        var uid1 = document.getElementById('dikshaBhumiMandapPermissionId').value;
        $.ajax({
            url: "<c:out value='${contextRoot}'/>/rtsapplication/uploadDikshaBhumiMandapNoc.do?appType="+appType+"&UID="+uid1,
            type: 'POST',
            data: data,
            cache: false,
            dataType: 'json',
            processData: false, 
            contentType: false 
        }).done(function (data) {
        	if(data.status==true || data.status=='true'){
          	  
                alert("Traffic NOC Certificate uploaded Successfully");
                window.location.reload(); 
          	}else{
                alert("Traffic NOC Certificate upload failed!!");

          	}        });
        var a = filesPath.substring(0, filesPath.lastIndexOf(","));
        filesPath = filesPath.replace(/\s/g, "");
        $("#filesPath").val(filesPath);
        console.log(filesPath);

    }
    
    
	function docDownload(filesPath) {
 	    var encodedFilePath = encodeURIComponent(filesPath);

 	    var encodedFilesPath = btoa(encodedFilePath); 

 	    window.open('<c:out value="${contextRoot}"/>/rtsApplication/getPdf.do?fp=' + encodedFilesPath, '_blank');
 	}

</script>