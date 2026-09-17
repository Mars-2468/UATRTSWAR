<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@page import="com.mars.common.utils.CommonUtils" %>
        <%@page import="com.mars.rti.utils.CoreConstants" %>
            <%@include file="/pages/common/include.jsp" %>
                <%@page import="com.mars.common.utils.Constants" %>
                    <%@page import="com.mars.workflow.utils.WorkflowConstants" %>
                        <%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                            <jsp:directive.include file="/pages/common/include.jsp" />

                            <% pageContext.setAttribute("DATE_FORMAT", Constants.DATE_FORMAT);
                                pageContext.setAttribute("DATE_TIME_DB_FORMAT", Constants.DATE_TIME_DB_FORMAT);
                                pageContext.setAttribute("DATE_TIME_FORMAT", WorkflowConstants.WORKFLOW_DATE_FORMAT);
                                pageContext.setAttribute("WORKFLOW_PRIORITY", WorkflowConstants.WORKFLOW_PRIORITY);
                                pageContext.setAttribute("WORKFLOW_PRIORITY_LOW",
                                WorkflowConstants.WORKFLOW_PRIORITY_LOW);
                                pageContext.setAttribute("WORKFLOW_PRIORITY_LOW_LABEL",
                                WorkflowConstants.WORKFLOW_PRIORITY_LOW_LABEL);
                                pageContext.setAttribute("WORKFLOW_PRIORITY_MEDIUM",
                                WorkflowConstants.WORKFLOW_PRIORITY_MEDIUM);
                                pageContext.setAttribute("WORKFLOW_PRIORITY_MEDIUM_LABEL",
                                WorkflowConstants.WORKFLOW_PRIORITY_MEDIUM_LABEL);
                                pageContext.setAttribute("WORKFLOW_PRIORITY_HIGH",
                                WorkflowConstants.WORKFLOW_PRIORITY_HIGH);
                                pageContext.setAttribute("WORKFLOW_PRIORITY_HIGH_LABEL",
                                WorkflowConstants.WORKFLOW_PRIORITY_HIGH_LABEL);
                                pageContext.setAttribute("WORKFLOW_PROCESSDESCRIPTION",
                                WorkflowConstants.WORKFLOW_PROCESSDESCRIPTION);
                                pageContext.setAttribute("WORKFLOW_TRANSITION", WorkflowConstants.WORKFLOW_TRANSITION);
                                pageContext.setAttribute("WORKFLOW_NAME", WorkflowConstants.WORKFLOW_NAME);
                                pageContext.setAttribute("WORKFLOW_ACTION", WorkflowConstants.WORKFLOW_ACTION);
                                pageContext.setAttribute("WORKFLOW_ACTION_COMPLETE_TASK",
                                WorkflowConstants.WORKFLOW_ACTION_COMPLETE_TASK);
                                pageContext.setAttribute("WORKFLOW_ACTION_CREATE_PROCESS",
                                WorkflowConstants.WORKFLOW_ACTION_CREATE_PROCESS); pageContext.setAttribute("TAKE_TASK",
                                WorkflowConstants.WORKFLOW_ACTION_TAKE_TASK); pageContext.setAttribute("KILL_JOB",
                                WorkflowConstants.WORKFLOW_ACTION_KILL_JOB); pageContext.setAttribute("END_JOB",
                                WorkflowConstants.WORKFLOW_ACTION_KILL_JOB);
                                pageContext.setAttribute("WORKFLOW_TRANSISTION",
                                WorkflowConstants.WORKFLOW_TRANSISTION); pageContext.setAttribute("WORKFLOW_ENTITYNAME",
                                WorkflowConstants.WORKFLOW_ENTITYNAME); pageContext.setAttribute("WORKFLOW_ENTITYID",
                                WorkflowConstants.WORKFLOW_ENTITYID); pageContext.setAttribute("WORKFLOW_JOB_ID",
                                WorkflowConstants.WORKFLOW_JOB_ID); pageContext.setAttribute("WORKFLOW_TASK_ID",
                                WorkflowConstants.WORKFLOW_TASK_ID); pageContext.setAttribute("WORKFLOW_COMMENTS",
                                WorkflowConstants.WORKFLOW_COMMENTS); pageContext.setAttribute("WORKFLOW_DUE_DATE",
                                WorkflowConstants.WORKFLOW_DUE_DATE); pageContext.setAttribute("APPL_STATUS_CLOSED",
                                CoreConstants.APPL_STATUS_CLOSED); pageContext.setAttribute("APPL_STATUS_NEW",
                                CoreConstants.APPL_STATUS_NEW); pageContext.setAttribute("APPL_STATUS_PARKED",
                                CoreConstants.APPL_STATUS_PARKED); pageContext.setAttribute("APPL_STATUS_APPROVED",
                                CoreConstants.APPL_STATUS_APPROVED);
                                pageContext.setAttribute("APPL_STATUS_VERIFICATION",
                                CoreConstants.APPL_STATUS_VERIFICATION); pageContext.setAttribute("APPL_STATUS_CREATE",
                                CoreConstants.APPL_STATUS_CREATE); pageContext.setAttribute("APPLICATION_STATUS_LIST",
                                CommonUtils.getApplicationStatusList());
                                pageContext.setAttribute("LABEL_RADIO_COMMERICAL",
                                CoreConstants.LABEL_RADIO_COMMERICAL);
                                pageContext.setAttribute("LABEL_RADIO_CHARITABLE",
                                CoreConstants.LABEL_RADIO_CHARITABLE);
                                pageContext.setAttribute("LABEL_RADIO_GOVERNMENT",
                                CoreConstants.LABEL_RADIO_GOVERNMENT); pageContext.setAttribute("RADIO_COMMERICAL",
                                CoreConstants.RADIO_COMMERICAL); pageContext.setAttribute("RADIO_CHARITABLE",
                                CoreConstants.RADIO_CHARITABLE); pageContext.setAttribute("RADIO_GOVERNMENT",
                                CoreConstants.RADIO_GOVERNMENT); %>


                                <script type="text/javascript" src="<c:out value=" ${contextRoot}" />
                                /scripts/jquery/jquery.ajaxfileupload.js"></script>
                                <script
                                    src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
                                <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
                                <script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
                                <script type="text/javascript">
                                    function editRTIApplicationdog() {
                                        onPageSubmit('<c:out value="${contextRoot}"/>/rtiapplication/editRTIManagePermission.do');
                                    }

                                    function saveFireComplianceCertificates() {
                                        onPageSubmit('<c:out value="${contextRoot}"/>/rtiapplication/saveFireComplianceCertificates.do');
                                    }

                                    function rtiApplicationSearch() {
                                        onPageSubmit('<c:out value="${contextRoot}"/>/rtiApplicationReport/listRTIApplicationReports.do');
                                    }

                                    function viewNoting() {
                                        onPageSubmit('<c:out value="${contextRoot}"/>/rtiApplicationReport/viewNoting.do');
                                    }

                                    function viewDrafts() {
                                        onPageSubmit('<c:out value="${contextRoot}"/>/rtiApplicationReport/viewDrafts.do');
                                    }

                                    function downloadRTIApplicationList() {
                                        onPageSubmit('<c:out value="${contextRoot}"/>/rtiApplicationReport/downloadRTIApplicationList.do');
                                    }

                                    function listRTIApplicationReports() {
                                        onPageSubmit('<c:out value="${contextRoot}"/>/rtiApplicationReport/listRTIApplicationReports.do');
                                    }

                                    function sendEmail() {
                                        document.getElementById('actionTaken').value = 'email';
                                        onPageSubmit('<c:out value="${contextRoot}"/>/emailsms/emailSMS.do');
                                    }

                                    function sendSMS() {
                                        document.getElementById('actionTaken').value = 'sms';
                                        onPageSubmit('<c:out value="${contextRoot}"/>/emailsms/emailSMS.do');
                                    }

                                    function download(id, url) {
                                        document.getElementById('rtiApplicationRefId').value = id;
                                        alert("Certificate has been generated successfully.");
                                        onPageSubmit('<c:out value="${contextRoot}"/>/rtiApplicationReport/' + url);
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
                                </style>
                                <div class="container">
                                    <h3 style="font-size: 18px; font-weight: bold;">
                                        Final Fire NOC :
                                        <c:if test="${requestScope.rtiApplication != null}">
                                            <c:out value="${requestScope.rtiApplication.rtiApplnNumber}"></c:out>
                                        </c:if>
                                    </h3>
                                </div>
                                <div align="top" id="SetFormHeight">
                                    <input type="hidden" name="id" value="${fireComplianceCertificate.firecompliancecertificateid}">

                                    <!-- ================= Applicant Details ================= -->
                                    <h6 style="background-color: #dce2e8; padding: 10px;" class="rounded-2">
                                        <strong> Applicant Details </strong>
                                    </h6>
                                    <table width="100%" border="0" cellpadding="2" cellspacing="2" class="container">
                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">First Name :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px;" maxlength="50"
                                                    name="firstName" value="${fireComplianceCertificate.firstName}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">Middle Name :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px" maxlength="50"
                                                    name="middleName" value="${fireComplianceCertificate.middleName}" /></td>
                                        </tr>

                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Last Name :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px;" maxlength="50"
                                                    name="lastName" value="${fireComplianceCertificate.lastName}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">Full Name :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px" maxlength="50"
                                                    name="fullName" value="${fireComplianceCertificate.fullName}" /></td>
                                        </tr>

                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Plot/ Flat No :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px;" maxlength="50"
                                                    name="plotno" value="${fireComplianceCertificate.plotno}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">City Survey No :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px" maxlength="50"
                                                    name="citysurveyno" value="${fireComplianceCertificate.citysurveyno}" /></td>
                                        </tr>

                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Name of the Street :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px;" maxlength="50"
                                                    name="strretname" value="${fireComplianceCertificate.strretname}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">House Mouza No :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px" maxlength="50"
                                                    name="housemouzano" value="${fireComplianceCertificate.housemouzano}" /></td>
                                        </tr>

                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Pin Code :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px;" maxlength="50"
                                                    name="pincode" value="${fireComplianceCertificate.pincode}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">Landmark :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px" maxlength="50"
                                                    name="landmark" value="${fireComplianceCertificate.landmark}" /></td>
                                        </tr>

                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Email Id :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px;" maxlength="50"
                                                    name="emailid" value="${fireComplianceCertificate.emailid}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">Mobile No :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px" maxlength="50"
                                                    name="mobileno" value="${fireComplianceCertificate.mobileno}" /></td>
                                        </tr>

                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Name of Power of Attorney :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px;" maxlength="50"
                                                    name="nameofpowerofattorney" value="${fireComplianceCertificate.nameofpowerofattorney}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">No.of standby :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px" maxlength="50"
                                                    name="noofstandby" value="${fireComplianceCertificate.noofstandby}" /></td>
                                        </tr>

                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Address of Power of Attorney :</span></td>
                                            <td colspan="3"><input type="text" class="form-control" style="width: 180px;" maxlength="50"
                                                    name="addressofpowerofattorney" value="${fireComplianceCertificate.addressofpowerofattorney}" /></td>
                                        </tr>
                                    </table>

                                    <!-- ================= Application (Provisional / Permit) References ================= -->
                                    <h6 style="background-color: #dce2e8; padding: 10px;" class="rounded-2">
                                        <strong> Application Form Details</strong>
                                    </h6>
                                    <h6><strong>To,</strong> <br> <strong>Chief Fire Officer</strong>
                                        <br> <strong>N.M.C. Nagpur.</strong> <br> Sir,<br>
                                        Kindly issue compliance certificate to the building sanction vide
                                        building permit No. <strong><h7>${fireComplianceCertificate.permitno}</h7></strong>
                                        dated <strong><h7>${fireComplianceCertificate.permitnodate}</h7></strong>
                                        &amp; fire recommendation letter No. <strong><h7>${fireComplianceCertificate.firerecommendationno}</h7></strong>
                                        dated <strong><h7>${fireComplianceCertificate.firerecommendationnodate}</h7></strong>.
                                        I have paid the necessary fees applicable having receipt No.
                                        <strong><h7>${fireComplianceCertificate.receiptno}</h7></strong>
                                        dated <strong><h7>${fireComplianceCertificate.receiptnodate}</h7></strong>.
                                        I have enclosed all the necessary documents &amp; certificates. The other building details are as under.
                                    </h6>

                                    <table width="100%" border="0" cellpadding="2" cellspacing="2" class="container">
                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Fire RTS Id :</span></td>
                                            <!-- The application form's "firertsid" field is used only as a lookup key to
                                                 auto-fetch data via getFireRtsData(); it is not a stored column on
                                                 FireComplianceCertificate in the entity shared. Showing the closest
                                                 persisted equivalent (rti_ref_id) below -- rename/rebind if a real
                                                 firertsid column is added to the entity. -->
                                            <td><input type="text" class="form-control" style="width: 180px;" maxlength="50"
                                                    name="firertsid" value="${fireComplianceCertificate.rti_ref_id}" /></td>
                                            <td colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Provisional Fire Safety Approval :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px;" maxlength="50"
                                                    name="provisionalFireSafetyApproval" value="${fireComplianceCertificate.provisionalFireSafetyApproval}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">Name of Building Owner :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px" maxlength="50"
                                                    name="nameofBuildingOwner" value="${fireComplianceCertificate.nameofBuildingOwner}" /></td>
                                        </tr>

                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Name of Building :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px;" maxlength="50"
                                                    name="buildingname" value="${fireComplianceCertificate.buildingname}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">Address of Building :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px"
                                                    name="sadressofBuilding" value="${fireComplianceCertificate.sadressofBuilding}" /></td>
                                        </tr>

                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Name &amp; Address of Building/Promoter :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px;" maxlength="50"
                                                    name="nameaddresspromoter" value="${fireComplianceCertificate.nameaddresspromoter}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">Name &amp; Address of Owner/Occupiers :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px" maxlength="50"
                                                    name="nameaddressowner" value="${fireComplianceCertificate.nameaddressowner}" /></td>
                                        </tr>

                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Type of Building :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px;" maxlength="50"
                                                    name="typeofBuilding" value="${fireComplianceCertificate.typeofBuilding}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">Type of occupancy :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px" maxlength="50"
                                                    name="typeofoccupancy" value="${fireComplianceCertificate.typeofoccupancy}" /></td>
                                        </tr>

                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Plot area :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px;" maxlength="50"
                                                    name="plotarea" value="${fireComplianceCertificate.plotarea}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">Total Built up area :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px" maxlength="50"
                                                    name="totalbuiltuparea" value="${fireComplianceCertificate.totalbuiltuparea}" /></td>
                                        </tr>

                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Height of Building :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px;" maxlength="50"
                                                    name="heightofBuilding" value="${fireComplianceCertificate.heightofBuilding}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">Basement load bearing strength :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px" maxlength="50"
                                                    name="basementloadbearingstrength" value="${fireComplianceCertificate.basementloadbearingstrength}" /></td>
                                        </tr>

                                        <th colspan="16" style="font-size: 17px; text-align: left;">Side Marginal Space</th>

                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Front Margin :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px;" maxlength="50"
                                                    name="frontMargin" value="${fireComplianceCertificate.frontMargin}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">Rear Margin :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px" maxlength="50"
                                                    name="rearMargin" value="${fireComplianceCertificate.rearMargin}" /></td>
                                        </tr>

                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Side1 Margin :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px;" maxlength="50"
                                                    name="side1Margin" value="${fireComplianceCertificate.side1Margin}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">Side2 Margin :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px" maxlength="50"
                                                    name="side2Margin" value="${fireComplianceCertificate.side2Margin}" /></td>
                                        </tr>

                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Width of approach road :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px;" maxlength="50"
                                                    name="widthapproachroad" value="${fireComplianceCertificate.widthapproachroad}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">Width of entrance :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px" maxlength="50"
                                                    name="widthentrance" value="${fireComplianceCertificate.widthentrance}" /></td>
                                        </tr>

                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Number of floors (incl. basement) :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px;" maxlength="50"
                                                    name="numberoffloors" value="${fireComplianceCertificate.numberoffloors}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">Number of basements :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px" maxlength="50"
                                                    name="numberofbasements" value="${fireComplianceCertificate.numberofbasements}" /></td>
                                        </tr>

                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Area of basement :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px;" maxlength="50"
                                                    name="areaofbasement" value="${fireComplianceCertificate.areaofbasement}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">Covered area of typical floor :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px" maxlength="50"
                                                    name="coveredarea" value="${fireComplianceCertificate.coveredarea}" /></td>
                                        </tr>
                                    </table>

                                    <!-- ================= Staircase & Lift Details ================= -->
                                    <!-- NOTE: the FireComplianceCertificate entity shared has no columns for these
                                         three items. The application form (getFireRtsData / manual entry) builds
                                         repeating rows for noofInternalStaircase+widthInternalStaircase,
                                         noofExternalStaircase+widthInternalStaircase and noofLiftProvided.
                                         To make this section show real submitted data, add comma-separated String
                                         columns to the entity -- e.g. noofinternalstaircase / widthinternalstaircase,
                                         noofexternalstaircase / widthexternalstaircase, nooflift -- the same way
                                         filesPath / pdfUploadFromPortal already store comma-separated lists
                                         elsewhere in this app, then expose them via getters of the same name used
                                         below. Until those columns exist these tables will render empty. -->
                                    <div style="display: flex; justify-content: space-between;">
                                        <div style="width: 49%;">
                                            <h6 style="background-color: #dce2e8; padding: 6px;">Internal Staircase Provided</h6>
                                            <table width="100%" border="1" cellpadding="4" cellspacing="0" class="container">
                                                <tr style="background-color: #dce2e8;">
                                                    <th>Sr. No.</th>
                                                    <th>No. of Internal Staircase</th>
                                                    <th>Width of Internal Staircase</th>
                                                </tr>
                                                <c:set var="intCounts" value="${fn:split(fireComplianceCertificate.noofinternalstaircase, ',')}" />
                                                <c:set var="intWidths" value="${fn:split(fireComplianceCertificate.widthinternalstaircase, ',')}" />
                                                <c:forEach var="cnt" items="${intCounts}" varStatus="st">
                                                    <tr>
                                                        <td>${st.index + 1}</td>
                                                        <td><c:out value="${cnt}" /></td>
                                                        <td><c:out value="${intWidths[st.index]}" /></td>
                                                    </tr>
                                                </c:forEach>
                                            </table>
                                        </div>
                                        <div style="width: 49%;">
                                            <h6 style="background-color: #dce2e8; padding: 6px;">External Staircase Provided</h6>
                                            <table width="100%" border="1" cellpadding="4" cellspacing="0" class="container">
                                                <tr style="background-color: #dce2e8;">
                                                    <th>Sr. No.</th>
                                                    <th>No. of External Staircase</th>
                                                    <th>Width of External Staircase</th>
                                                </tr>
                                                <c:set var="extCounts" value="${fn:split(fireComplianceCertificate.noofexternalstaircase, ',')}" />
                                                <c:set var="extWidths" value="${fn:split(fireComplianceCertificate.widthexternalstaircase, ',')}" />
                                                <c:forEach var="cnt" items="${extCounts}" varStatus="st">
                                                    <tr>
                                                        <td>${st.index + 1}</td>
                                                        <td><c:out value="${cnt}" /></td>
                                                        <td><c:out value="${extWidths[st.index]}" /></td>
                                                    </tr>
                                                </c:forEach>
                                            </table>
                                        </div>
                                    </div>
                                    <div style="width: 49%;">
                                        <h6 style="background-color: #dce2e8; padding: 6px;">Lift Provided</h6>
                                        <table width="100%" border="1" cellpadding="4" cellspacing="0" class="container">
                                            <tr style="background-color: #dce2e8;">
                                                <th>Sr. No.</th>
                                                <th>No. of Lift Provided</th>
                                            </tr>
                                            <c:set var="liftCounts" value="${fn:split(fireComplianceCertificate.nooflift, ',')}" />
                                            <c:forEach var="cnt" items="${liftCounts}" varStatus="st">
                                                <tr>
                                                    <td>${st.index + 1}</td>
                                                    <td><c:out value="${cnt}" /></td>
                                                </tr>
                                            </c:forEach>
                                        </table>
                                    </div>

                                    <!-- ================= Exposure Hazards ================= -->
                                    <h6 style="background-color: #dce2e8; padding: 10px;" class="rounded-2">
                                        <strong>Exposure Hazards (Please give details)</strong>
                                    </h6>
                                    <table width="100%" border="1" cellpadding="4" cellspacing="0" class="container">
                                        <tr style="background-color: #dce2e8;">
                                            <th style="width: 40%;">Compass direction in relation to the building</th>
                                            <th>Type of property / features</th>
                                        </tr>
                                        <tr>
                                            <td>NORTH</td>
                                            <td><input type="text" class="form-control" name="exposurehazardNorth"
                                                    value="${fireComplianceCertificate.exposurehazardNorth}" /></td>
                                        </tr>
                                        <tr>
                                            <td>SOUTH</td>
                                            <td><input type="text" class="form-control" name="exposurehazardSouth"
                                                    value="${fireComplianceCertificate.exposurehazardSouth}" /></td>
                                        </tr>
                                        <tr>
                                            <td>EAST</td>
                                            <td><input type="text" class="form-control" name="exposurehazardEast"
                                                    value="${fireComplianceCertificate.exposurehazardEast}" /></td>
                                        </tr>
                                        <tr>
                                            <td>WEST</td>
                                            <td><input type="text" class="form-control" name="exposurehazardWest"
                                                    value="${fireComplianceCertificate.exposurehazardWest}" /></td>
                                        </tr>
                                    </table>

                                    <!-- ================= Fire & Safety Measures ================= -->
                                    <h6 style="background-color: #dce2e8; padding: 10px;" class="rounded-2">
                                        <strong>Fire &amp; Safety Measures (as per Provisional Fire Safety Approval Certificate &amp; NBC Norms)</strong>
                                    </h6>
                                    <!--
                                        NOTE: FireComplianceMeasure's own getters were not available when this page
                                        was corrected, so getMeasureName()/getStatus()/getQuantity()/getLocation()
                                        below are assumed to mirror the "Fire and Safety Measures", "Provided/Not
                                        Provided/Not Required", "Quantity" and "Location" columns collected on the
                                        application form. Rename these EL properties to match the real
                                        FireComplianceMeasure entity if its getters differ.
                                    -->
                                    <table width="100%" border="1" cellpadding="4" cellspacing="0" class="container">
                                        <tr style="background-color: #dce2e8;">
                                            <th style="width: 4%;">Sr.No.</th>
                                            <th style="width: 28%;">Fire and Safety Measures</th>
                                            <th style="width: 30%;">Provided / Not Provided / Not Required</th>
                                            <th style="width: 14%;">Quantity</th>
                                            <th>Location</th>
                                        </tr>
                                        <c:forEach var="measure" items="${fireComplianceCertificate.fireComplianceMeasures}" varStatus="loop">
                                            <tr>
                                                <td>${loop.index + 1}</td>
                                                <td><c:out value="${measure.measureName}" /></td>
                                                <td><c:out value="${measure.status}" /></td>
                                                <td><c:out value="${measure.quantity}" /></td>
                                                <td><c:out value="${measure.location}" /></td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty fireComplianceCertificate.fireComplianceMeasures}">
                                            <tr>
                                                <td colspan="5" style="text-align:center;">No fire &amp; safety measures recorded.</td>
                                            </tr>
                                        </c:if>
                                    </table>

                                    <!-- ================= Other Information ================= -->
                                    <table width="100%" border="0" cellpadding="2" cellspacing="2" class="container">
                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Other information related to fire fighting &amp; life safety arrangement :</span></td>
                                            <td colspan="3">
                                                <textarea class="form-control" rows="2" name="otherinfo">${fireComplianceCertificate.otherinfo}</textarea>
                                            </td>
                                        </tr>
                                    </table>

                                    <!-- ================= Certifying Architect / Owner Details ================= -->
                                    <h6 style="background-color: #dce2e8; padding: 10px;" class="rounded-2">
                                        <strong>Certifying Architect / Owner Details</strong>
                                    </h6>
                                    <table width="100%" border="0" cellpadding="2" cellspacing="2" class="container">
                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Name of Architect :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px;" maxlength="50"
                                                    name="nameofarchitect" value="${fireComplianceCertificate.nameofarchitect}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">License No. :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px" maxlength="50"
                                                    name="architectlicenseno" value="${fireComplianceCertificate.architectlicenseno}" /></td>
                                        </tr>
                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Address (Architect) :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px;" maxlength="50"
                                                    name="addressofarchitect" value="${fireComplianceCertificate.addressofarchitect}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">Name of Owner :</span></td>
                                            <td><input type="text" class="form-control" style="width: 180px" maxlength="50"
                                                    name="nameofownerdeclaration" value="${fireComplianceCertificate.nameofownerdeclaration}" /></td>
                                        </tr>
                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Address (Owner) :</span></td>
                                            <td colspan="3"><input type="text" class="form-control" style="width: 180px;" maxlength="50"
                                                    name="addressofownerdeclaration" value="${fireComplianceCertificate.addressofownerdeclaration}" /></td>
                                        </tr>
                                    </table>

                                    <!-- ================= Declaration ================= -->
                                    <!-- NOTE: the "declaration" checkbox on the application form has no matching
                                         column on FireComplianceCertificate either; add a boolean/flag column
                                         (e.g. declarationAccepted) if you need to show whether it was ticked. -->
                                    <table width="100%" border="0" cellpadding="2" cellspacing="2" class="container">
                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px; font-style: italic;">
                                                    Declaration: The applicant declared that all information provided in the
                                                    application is true.
                                                </span></td>
                                        </tr>
                                    </table>

                                    <!-- ================= Current Status ================= -->
                                    <table width="100%" border="0" cellpadding="2" cellspacing="2" class="container">
                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Current Status:</span></td>
                                            <td style="width: 230px; height: 30px"><span class="ClsLabel" style="font-size: 14px">
                                                    <c:if test="${requestScope.rtiApplication.workFlowStatus==0}">Citizen Form Submitted.</c:if>
                                                    <c:if test="${requestScope.rtiApplication.workFlowStatus==3}">Citizen Payment Pending.</c:if>
                                                    <c:if test="${requestScope.rtiApplication.workFlowStatus==2}">Citizen Payment Completed</c:if>
                                                    <c:if test="${requestScope.rtiApplication.workFlowStatus==1}">Completed and File Uploaded for Citizen</c:if>
                                                    <c:if test="${requestScope.rtiApplication.workFlowStatus==5}">Rejected</c:if>
                                                </span></td>

                                            <c:if test="${requestScope.rtiApplication.workFlowStatus==2}">
                                                <td colspan="4" align="center">
                                                    <a target="_blank" href="" id="genCerBtn">
                                                        <button type="button" class="ClsButton clsButtonUpload"
                                                            onclick="download(${fireComplianceCertificate.rti_ref_id},'fireComplianceCertificateReport.do')">GENERATE
                                                            CERTIFICATE</button>
                                                    </a>
                                                </td>
                                                <td><span class="ClsLabel" style="font-size:14px">Certificate Upload: </span></td>
                                            </c:if>
                                            <%@include file="/pages/common-pages/dms/fileUpload.jsp" %>
                                        </tr>
                                    </table>

                                    <!-- ================= List of Documents ================= -->
                                    <table width="100%" border="0" cellpadding="2" cellspacing="2" class="container">
                                        <tr>
                                            <td colspan="4"><span class="ClsLabel" style="font-size: 15px; font-weight: bold;">
                                                    List of Documents (Attachment) For Fire Compliance Certificate :
                                                </span></td>
                                        </tr>

                                        <c:set var="doc" value="${fn:split(fireComplianceCertificate.filesPath, ',')}" />

                                        <tr>
                                            <td style="width: 600px; height: 30px"><span class="ClsLabel" style="font-size: 14px;">
                                                    Fitness certificate from licensing agency :
                                                </span></td>
                                            <td style="text-align: center">
                                                <a class="ClsButton" type="button" target="_blank" href="<c:out value='${doc[0]}' />">
                                                    <span style="align-items: center">Download</span></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">
                                                    Civil Engineer certificate of Structural stability :
                                                </span></td>
                                            <td style="text-align: center">
                                                <a class="ClsButton" type="button" target="_blank" href="<c:out value='${doc[1]}' />">
                                                    <span style="align-items: center">Download</span></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">
                                                    Architect certificate for fire water tanks :
                                                </span></td>
                                            <td style="text-align: center">
                                                <a class="ClsButton" type="button" target="_blank" href="<c:out value='${doc[2]}' />">
                                                    <span style="align-items: center">Download</span></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">
                                                    Electrical inspector certificate :
                                                </span></td>
                                            <td style="text-align: center">
                                                <a class="ClsButton" type="button" target="_blank" href="<c:out value='${doc[3]}' />">
                                                    <span style="align-items: center">Download</span></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">
                                                    Sanctioned building plan :
                                                </span></td>
                                            <td style="text-align: center">
                                                <a class="ClsButton" type="button" target="_blank" href="<c:out value='${doc[4]}' />">
                                                    <span style="align-items: center">Download</span></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">
                                                    License copy of lift :
                                                </span></td>
                                            <td style="text-align: center">
                                                <a class="ClsButton" type="button" target="_blank" href="<c:out value='${doc[5]}' />">
                                                    <span style="align-items: center">Download</span></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">
                                                    Affidavit :
                                                </span></td>
                                            <td style="text-align: center">
                                                <a class="ClsButton" type="button" target="_blank" href="<c:out value='${doc[6]}' />">
                                                    <span style="align-items: center">Download</span></a>
                                            </td>
                                        </tr>
                                    </table>
                                    <br>
                                </div>

                                <input type="hidden" id="rtiApplicationRefId" name="rtiApplicationRefId" value="" />
                                <%@include file="/pages/workflow/taskInclude.jsp" %>

                                    <script type="text/javascript">
                                        function saveEntity() {
                                            onPageSubmit('<c:out value="${contextRoot}"/>/rtiapplication/createFireComplianceCertificate.do');
                                        }
                                    </script>
