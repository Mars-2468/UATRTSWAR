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


                                <%--
                                  FIX: removed the duplicate jQuery / jQuery UI <script> includes that
                                  used to be here:

                                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
                                    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
                                    <script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>

                                  /pages/common/include.jsp (included above) already loads jQuery plus
                                  the page's jQuery plugins (peity, circliful, bootstrap popover, etc).
                                  Re-including jQuery here replaced window.jQuery/$ with a brand-new
                                  jQuery object that has NONE of those plugins registered on it, which is
                                  exactly why $(...).peity(...), $(...).circliful(...) and $(...).popover(...)
                                  were throwing "is not a function" in the console. If ajaxfileupload.js
                                  below ever complains that $ is undefined, the fix is to make sure
                                  include.jsp is loading jQuery BEFORE this file, not to re-add these
                                  lines.
                                --%>
                                <script type="text/javascript" src="<c:out value=" ${contextRoot}" />
                                /scripts/jquery/jquery.ajaxfileupload.js"></script>
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
                                    function downloads(id,url) {

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
                                    <%--
                                      FIX: this field previously had only name="id", no id="" attribute,
                                      so document.getElementById(...) could never find it. uploadFireDoc()
                                      below needs to read the FireComplianceCertificate's own primary key
                                      (this value) - NOT a "mandapPermissionId" element, which doesn't
                                      exist anywhere on this page and was the direct cause of the
                                      "Cannot read properties of null (reading 'value')" crash on upload.
                                    --%>
                                    <input type="hidden" id="fireComplianceCertificateId" name="id" value="${fireComplianceCertificate.firecompliancecertificateid}">

                                   

                                    <h6 style="background-color: #dce2e8; padding: 10px;" class="rounded-2">
                                        <strong> Application Form Details</strong>
                                    </h6>
                                  

                                    <table width="100%" border="0" cellpadding="2" cellspacing="2" class="container">
                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Fire RTS Id :</span></td>
                                           
                                            <td><input type="text" class="form-control"  style="width: 270px;" maxlength="50"
                                                    name="firertsid" value="${fireComplianceCertificate.rti_ref_id}" /></td>
                                            
                                                <td><span class="ClsLabel" style="font-size: 14px">Email Id :</span></td>
                                            <%-- FIX: was name="addressofownerdeclaration", which collides
                                                 with the real "Address (Owner)" field further down this
                                                 form - both inputs would post under the same name and one
                                                 would silently clobber the other. --%>
                                            <td colspan="3"><input type="text" class="form-control" style="width: 270px;" maxlength="50"
                                                    name="emailid" value="${fireComplianceCertificate.emailid}" /></td>
                                        
                                        </tr>
                                        <tr>
                                           <td><span class="ClsLabel" style="font-size: 14px">Provisional Fire Safety Approval :</span></td>
                                            <td><input type="text" class="form-control" style="width: 270px;" maxlength="50"
                                                    name="provisionalFireSafetyApproval" value="${fireComplianceCertificate.provisionalFireSafetyApproval}" /></td>
                                                    

                                            <td><span class="ClsLabel" style="font-size: 14px">Name of Building Owner :</span></td>
                                            <td><input type="text" class="form-control" style="width: 270px" maxlength="50"
                                                    name="nameofBuildingOwner" value="${fireComplianceCertificate.nameofBuildingOwner}" /></td>
                                        </tr>

                                        <tr>
                                         
                                            <td><span class="ClsLabel" style="font-size: 14px">Address of Building :</span></td>
                                            <td><input type="text" class="form-control" style="width: 270px"
                                                    name="sadressofBuilding" value="${fireComplianceCertificate.sadressofBuilding}" /></td>

        

                                            <td><span class="ClsLabel" style="font-size: 14px">Type of Building :</span></td>
                                            <td><input type="text" class="form-control" style="width: 270px;" maxlength="50"
                                                    name="typeofBuilding" value="${fireComplianceCertificate.typeofBuilding}" /></td>

                                         </tr>

<tr>
 <td><span class="ClsLabel" style="font-size: 14px">
                                                    <fmt:message key="Fire Stations" />
                                                </span>:
                                            </td>
                                            <td>
<c:choose>
    <c:when test="${fireComplianceCertificate.fireStation == 1}">
        <input type="text" class="form-control" style="width: 270px" value="Civil Fire Station" />
    </c:when>
    <c:when test="${fireComplianceCertificate.fireStation == 2}">
        <input type="text" class="form-control" value="Cotton Market" />
    </c:when>
    <c:when test="${fireComplianceCertificate.fireStation == 3}">
        <input type="text" class="form-control" value="Ganjipeth" />
    </c:when>
    <c:when test="${fireComplianceCertificate.fireStation == 4}">
        <input type="text" class="form-control" value="Lakadganj" />
    </c:when>
    <c:when test="${fireComplianceCertificate.fireStation == 5}">
        <input type="text" class="form-control" value="Sakkardara" />
    </c:when>
    <c:when test="${fireComplianceCertificate.fireStation == 6}">
        <input type="text" class="form-control" value="Kalamna" />
    </c:when>
    <c:when test="${fireComplianceCertificate.fireStation == 7}">
        <input type="text" class="form-control" value="Sugat Nagar" />
    </c:when>
    <c:when test="${fireComplianceCertificate.fireStation == 8}">
        <input type="text" class="form-control" value="Narendra Nagar" />
    </c:when>
    <c:when test="${fireComplianceCertificate.fireStation == 9}">
        <input type="text" class="form-control" value="Trimurti Nagar" />
    </c:when>
    <c:when test="${fireComplianceCertificate.fireStation == 10}">
        <input type="text" class="form-control" value="Wathoda Fire Station" />
    </c:when>
    <c:otherwise>
        <input type="text" class="form-control" value="" />
    </c:otherwise>
</c:choose>
</td>

                                            <td><span class="ClsLabel" style="font-size: 14px">
                                                    <fmt:message key="Mobile Number(मोबाईल नंबर)" />
                                                </span>: </td>
                                            <td><input type="text" class="form-control" style="width: 270px"
                                                    value="<c:out value=" ${fireComplianceCertificate.mobileno}" />" /></td>


</tr>
                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Plot area :</span></td>
                                            <td><input type="text" class="form-control" style="width: 270px;" maxlength="50"
                                                    name="plotarea" value="${fireComplianceCertificate.plotarea}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">Total Built up area :</span></td>
                                            <td><input type="text" class="form-control" style="width: 270px" maxlength="50"
                                                    name="totalbuiltuparea" value="${fireComplianceCertificate.totalbuiltuparea}" /></td>
                                        </tr>

                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Height of Building :</span></td>
                                            <td><input type="text" class="form-control" style="width: 270px;" maxlength="50"
                                                    name="heightofBuilding" value="${fireComplianceCertificate.heightofBuilding}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">Basement load bearing strength :</span></td>
                                            <td><input type="text" class="form-control" style="width: 270px" maxlength="50"
                                                    name="basementloadbearingstrength" value="${fireComplianceCertificate.basementloadbearingstrength}" /></td>
                                        </tr>

                                        <th colspan="16" style="font-size: 17px; text-align: left;">Side Marginal Space</th>

                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Front Margin :</span></td>
                                            <td><input type="text" class="form-control" style="width: 270px;" maxlength="50"
                                                    name="frontMargin" value="${fireComplianceCertificate.frontMargin}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">Rear Margin :</span></td>
                                            <td><input type="text" class="form-control" style="width: 270px" maxlength="50"
                                                    name="rearMargin" value="${fireComplianceCertificate.rearMargin}" /></td>
                                        </tr>

                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Side1 Margin :</span></td>
                                            <td><input type="text" class="form-control" style="width: 270px;" maxlength="50"
                                                    name="side1Margin" value="${fireComplianceCertificate.side1Margin}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">Side2 Margin :</span></td>
                                            <td><input type="text" class="form-control" style="width: 270px" maxlength="50"
                                                    name="side2Margin" value="${fireComplianceCertificate.side2Margin}" /></td>
                                        </tr>

                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Width of approach road :</span></td>
                                            <td><input type="text" class="form-control" style="width: 270px;" maxlength="50"
                                                    name="widthapproachroad" value="${fireComplianceCertificate.widthapproachroad}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">Width of entrance :</span></td>
                                            <td><input type="text" class="form-control" style="width: 270px" maxlength="50"
                                                    name="widthentrance" value="${fireComplianceCertificate.widthentrance}" /></td>
                                        </tr>

                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Number of floors (incl. basement) :</span></td>
                                            <td><input type="text" class="form-control" style="width: 270px;" maxlength="50"
                                                    name="numberoffloors" value="${fireComplianceCertificate.numberoffloors}" /></td>

                                           <td><span class="ClsLabel" style="font-size: 14px">Provisional Fire Safety Approval Date :</span></td>
                                            <td><input type="text" class="form-control" style="width: 270px;" maxlength="50"
                                                    name="fireRecommendationDate" value="${fireComplianceCertificate.fireRecommendationDate}" /></td>
                                         
                                          </tr>

                             
                                    </table>

                                   
                                    <div style="display: flex; justify-content: space-between;">
                                        <div style="width: 49%;">
                                            <h6 style="background-color: #dce2e8; padding: 6px;">Internal Staircase Provided</h6>
                                            <table width="100%" border="1" cellpadding="4" cellspacing="0" class="container">
                                                <tr style="background-color: #dce2e8;">
                                                    <th>Sr. No.</th>
                                                    <th>No. of Internal Staircase</th>
                                                    <th>Width of Internal Staircase</th>
                                                </tr>
                                                <%-- FIX: property names here were camelCase
                                                     (noofInternalStaircase / widthInternalStaircase), which
                                                     don't match this entity's actual getters
                                                     (getNoofinternalstaircase() / getWidthinternalstaircase()
                                                     - all-lowercase after "noof"/"width"). EL property
                                                     resolution is case-sensitive, so these silently
                                                     resolved to nothing and the table rendered empty. --%>
                                                <c:set var="intCounts" value="${fn:split(fireComplianceCertificate.noofInternalStaircase, ',')}" />
                                                <c:set var="intWidths" value="${fn:split(fireComplianceCertificate.widthInternalStaircase, ',')}" />
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
                                                <c:set var="extCounts" value="${fn:split(fireComplianceCertificate.noofExternalStaircase, ',')}" />
                                                <c:set var="extWidths" value="${fn:split(fireComplianceCertificate.widthExternalStaircase, ',')}" />
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
                                            <c:set var="liftCounts" value="${fn:split(fireComplianceCertificate.noofLiftProvided, ',')}" />
                                            <c:forEach var="cnt" items="${liftCounts}" varStatus="st">
                                                <tr>
                                                    <td>${st.index + 1}</td>
                                                    <td><c:out value="${cnt}" /></td>
                                                </tr>
                                            </c:forEach>
                                        </table>
                                    </div>

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

                                    <h6 style="background-color: #dce2e8; padding: 10px;" class="rounded-2">
                                        <strong>Fire &amp; Safety Measures (as per Provisional Fire Safety Approval Certificate &amp; NBC Norms)</strong>
                                    </h6>
                            
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

                                    <table width="100%" border="0" cellpadding="2" cellspacing="2" class="container">
                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Other information related to fire fighting &amp; life safety arrangement :</span></td>
                                            <td colspan="3">
                                                <textarea class="form-control" rows="2" name="otherinfo">${fireComplianceCertificate.otherinfo}</textarea>
                                            </td>
                                        </tr>
                                    </table>

                                    <h6 style="background-color: #dce2e8; padding: 10px;" class="rounded-2">
                                        <strong>Certifying Architect / Owner Details</strong>
                                    </h6>
                                    <table width="100%" border="0" cellpadding="2" cellspacing="2" class="container">
                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Name of Architect :</span></td>
                                            <td><input type="text" class="form-control" style="width: 270px;" maxlength="50"
                                                    name="nameofarchitect" value="${fireComplianceCertificate.nameofarchitect}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">License No. :</span></td>
                                            <td><input type="text" class="form-control" style="width: 270px" maxlength="50"
                                                    name="architectlicenseno" value="${fireComplianceCertificate.architectlicenseno}" /></td>
                                        </tr>
                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Address (Architect) :</span></td>
                                            <td><input type="text" class="form-control" style="width: 270px;" maxlength="50"
                                                    name="addressofarchitect" value="${fireComplianceCertificate.addressofarchitect}" /></td>

                                            <td><span class="ClsLabel" style="font-size: 14px">Name of Owner :</span></td>
                                            <td><input type="text" class="form-control" style="width: 270px" maxlength="50"
                                                    name="nameofownerdeclaration" value="${fireComplianceCertificate.nameofownerdeclaration}" /></td>
                                        </tr>
                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Address (Owner) :</span></td>
                                            <td colspan="3"><input type="text" class="form-control" style="width: 270px;" maxlength="50"
                                                    name="addressofownerdeclaration" value="${fireComplianceCertificate.addressofownerdeclaration}" /></td>
                                        
                                        </tr>
                                    </table>

       <table width="100%" border="0" cellpadding="2" cellspacing="2" class="container">
                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px; font-style: italic;">
                                                    Declaration: The applicant declared that all information provided in the
                                                    application is true.
                                                </span></td>
                                        </tr>
                                    </table>

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

                                                <td colspan="4" align="center">
  <a class="bg-button btn btn-success bd-highlight generateaction" id="genCerBtn" style="color: white" onclick="downloads('${fireComplianceCertificate.rti_ref_id}', 'fireComplianceCertificateReport.do');" type="button" target="_blank">
                    <span class="download" style="display: flex; align-items: center;">Generate Certificate</span>
                </a>
                                                
                                                </td>
                                                <td><span class="ClsLabel" style="font-size:14px">Certificate Upload: </span></td>
                                            <%@include file="/pages/common-pages/dms/fileUpload.jsp" %>
                                        </tr>
                                    </table>

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
                                
   <table width="100%" border="1" cellpadding="2" cellspacing="2" class="container fire-docs-table">

    <!-- Inspection Report -->
    <tr>
        <td>
            <span style="font-size: 14px">
                <fmt:message key="Inspection Report" />:
            </span>
        </td>

        <c:choose>
            <c:when test="${empty fireComplianceCertificate.inspectionReport 
                   or fireComplianceCertificate.inspectionReport == 'null'
                   or fn:trim(fireComplianceCertificate.inspectionReport) == ''}">
            
                <c:if test="${requestScope.rtiApplication.workFlowStatus==0}">
                    <td>
                        <input type="file" id="scrutinydoc" accept="application/pdf" style="width:220px"/>

                        <a class="btn btn-primary"
                           style="color:white"
                           onclick="uploadFireDoc('scrutinydoc',1,'Inspection Report')">
                            Upload
                        </a>
                    </td>
                </c:if>
            </c:when>

            <c:otherwise>
                <td style="text-align:center">
                    <a class="btn btn-success"
                       style="color:white"
                       onclick="docDownload('${fireComplianceCertificate.inspectionReport}')">
                        Download
                    </a>
                    
                     <c:if test="${requestScope.rtiApplication.workFlowStatus != 1 and requestScope.rtiApplication.workFlowStatus != 5}">
                    <br/><br/>
                    <input type="file" id="scrutinydocReupload" accept="application/pdf" style="width:220px"/>
                    <a class="btn btn-warning" style="color:white"
                       onclick="uploadFireDoc('scrutinydocReupload',1,'Inspection Report')">Re-upload</a>
                </c:if>
                </td>
            </c:otherwise>
        </c:choose>
    </tr>


    <tr>
        <td>
            <span style="font-size: 14px">
                <fmt:message key="Digital Photos Upload" />:
            </span>
        </td>

        <c:choose>
                        <c:when test="${empty fireComplianceCertificate.nocPhotosUpload 
                   or fireComplianceCertificate.nocPhotosUpload == 'null'
                   or fn:trim(fireComplianceCertificate.nocPhotosUpload) == ''}">
                <c:if test="${requestScope.rtiApplication.workFlowStatus==0}">
                    <td>
                        <input type="file" id="inspectiondoc" accept="application/pdf" style="width:220px"/>

                        <a class="btn btn-primary"
                           style="color:white"
                           onclick="uploadFireDoc('inspectiondoc',2,'Photos Upload')">
                            Upload
                        </a>
                    </td>
                </c:if>
            </c:when>

            <c:otherwise>
                <td style="text-align:center">
                    <a class="btn btn-success"
                       style="color:white"
                       onclick="docDownload('${fireComplianceCertificate.nocPhotosUpload}')">
                        Download
                    </a>
                       <c:if test="${requestScope.rtiApplication.workFlowStatus != 1 and requestScope.rtiApplication.workFlowStatus != 5}">
                    <br/><br/>
                    <input type="file" id="inspectiondocReupload" accept="application/pdf" style="width:220px"/>
                    <a class="btn btn-warning" style="color:white"
                       onclick="uploadFireDoc('inspectiondocReupload',2,'Photos Uploads')">Re-upload</a>
                </c:if>
                </td>
            </c:otherwise>
        </c:choose>
    </tr>
    
    <tr>
        <td>
            <span style="font-size: 14px">
                <fmt:message key="Other Upload" />:
            </span>
        </td>

        <c:choose>
             <c:when test="${empty fireComplianceCertificate.otherUpload 
                   or fireComplianceCertificate.otherUpload == 'null'
                   or fn:trim(fireComplianceCertificate.otherUpload) == ''}">
                <c:if test="${requestScope.rtiApplication.workFlowStatus==0}">
                    <td>
                        <input type="file" id="cfoNocdoc" accept="application/pdf" style="width:220px"/>

                        <a class="btn btn-primary"
                           style="color:white"
                           onclick="uploadFireDoc('cfoNocdoc',3,'Other Uploads')">
                            Upload
                        </a>
                    </td>
                </c:if>
            </c:when>

            <c:otherwise>
                <td style="text-align:center">
                    <a class="btn btn-success"
                       style="color:white"
                       onclick="docDownload('${fireComplianceCertificate.otherUpload}')">
                        Download
                    </a>
                      <c:if test="${requestScope.rtiApplication.workFlowStatus != 1 and requestScope.rtiApplication.workFlowStatus != 5}">
                    <br/><br/>
                    <input type="file" id="cfoNocdocReupload" accept="application/pdf" style="width:220px"/>
                    <a class="btn btn-warning" style="color:white"
                       onclick="uploadFireDoc('cfoNocdocReupload',3,'Other Uploads')">Re-upload</a>
                </c:if>
                </td>
            </c:otherwise>
        </c:choose>
    </tr>

                                </table>
                                  <h6 style="background-color: #dce2e8; padding: 10px;" class="rounded-2">
                                        <strong>Final NOC Charges</strong>
                                    </h6>
                                    <table width="100%" border="0" cellpadding="2" cellspacing="2" class="container">
                                        <tr>
                                            <td><span class="ClsLabel" style="font-size: 14px">Final NOC Charges (Rs.) :</span></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${requestScope.rtiApplication.workFlowStatus==0}">
                                                        <input type="text" class="form-control" style="width: 180px;" maxlength="12"
                                                            id="finalNocChargesInput" name="finalNocCharges"
                                                            value="${fireComplianceCertificate.finalNocCharges}"
                                                            placeholder="Leave blank if no charges apply" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <input type="hidden" id="finalNocChargesInput" name="finalNocCharges"
                                                            value="${fireComplianceCertificate.finalNocCharges}" />
                                                        <span class="ClsLabel" style="font-size: 14px">
                                                            <c:out value="${empty fireComplianceCertificate.finalNocCharges ? 'No charges applicable' : fireComplianceCertificate.finalNocCharges}" />
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td colspan="2">
                                               <!-- <span class="ClsLabel" style="font-size: 12px; font-style: italic;">
                                                    Either L1 or L2 can fill this in. Leave blank if no charges apply -
                                                    only "Close-Application" will be shown below in that case. If a
                                                    charge amount is entered, only "Send-Demand" will be shown.
                                                </span>-->
                                            </td>
                                        </tr>
                                    </table>

                                <input type="hidden" id="rtiApplicationRefId" name="rtiApplicationRefId" value="" />
                                <%@include file="/pages/workflow/fireTaskInclude.jsp" %>

                                    <script type="text/javascript">
                                        function saveEntity() {
                                            onPageSubmit('<c:out value="${contextRoot}"/>/rtiapplication/createFireComplianceCertificate.do');
                                        }
                                    </script>
                                    
                                       <script>
function uploadFireDoc(inputId, appType, label) {

    var fileInput = document.getElementById(inputId);
    var file = fileInput.files[0];

    if (!file) {
        alert("Please select file");
        return;
    }

    var fileName = file.name.toLowerCase();

    // ✅ Only PDF
    if (!fileName.endsWith(".pdf")) {
        alert("Only PDF files are allowed");
        return;
    }

    // ✅ Double extension check
    if (fileName.substring(0, fileName.lastIndexOf(".")).includes(".")) {
        alert("Invalid file name (double extension not allowed)");
        return;
    }

    // ✅ Size check (5MB, matches the server-side limit in
    // uploadsManageFireFinalNoc.do)
    if (file.size > 5 * 1024 * 1024) {
        alert("File size must be less than 5MB");
        return;
    }

    // FIX: this used to read document.getElementById("mandapPermissionId"),
    // an element that does not exist anywhere on this page - that's what
    // threw "Cannot read properties of null (reading 'value')" every time
    // Upload/Re-upload was clicked. The server-side handler
    // (uploadsManageFireFinalNoc.do) looks the record up by the
    // FireComplianceCertificate's own id via fireComplianceCertificateService.get(id),
    // so that's the value we need here - the hidden field declared near
    // the top of this page as id="fireComplianceCertificateId".
    var uidEl = document.getElementById("fireComplianceCertificateId");
    var uid = uidEl ? uidEl.value.trim() : "";

    if (!uid) {
        alert("Invalid ID - the Fire Compliance Certificate record id could not be found on this page. Please reload and try again.");
        return;
    }

    var data = new FormData();
    data.append("file", file);

    // ✅ AJAX call
    $.ajax({
        url: "<c:out value='${contextRoot}'/>/rtsapplication/uploadsManageFireFinalNoc.do?appType=" 
                + appType + "&UID=" + encodeURIComponent(uid),

        type: "POST",
        data: data,
        processData: false,
        contentType: false,

        success: function (res) {
            if (res.status === true || res.status === "true") {
                alert(label + " uploaded successfully");
                location.reload();
            } else {
                alert(res.message || "Upload failed");
            }
        },

        error: function () {
            alert("Server error occurred");
        }
    });
}
</script>
