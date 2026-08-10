<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.page import="com.mars.common.utils.Constants" />
<jsp:directive.page import="com.mars.common.utils.CommonUtils" />

<%@ page import="java.util.Arrays" %>
<%!
    /* Format a numeric amount in INDIAN grouping (lakh/crore), ROUNDED to the whole rupee (HALF_UP), no paise.
       e.g. 6432.50 -> 6,433 ; 25284894.70 -> 2,52,84,895 ; 1456789 -> 14,56,789 ; null/blank -> "".
       Java's DecimalFormat can't do Indian grouping via a pattern, so we group manually. */
    private static String fmtIndianAmount(Object raw) {
        if (raw == null) return "";
        String s = String.valueOf(raw).replace(",", "").trim();
        if (s.isEmpty()) return "";
        try {
            java.math.BigDecimal bd = new java.math.BigDecimal(s)
                    .setScale(0, java.math.RoundingMode.HALF_UP);  // round off to whole rupee, drop paise
            boolean neg = bd.signum() < 0;
            String intPart = bd.abs().toPlainString();             // e.g. "6433"
            String grouped;
            if (intPart.length() <= 3) {
                grouped = intPart;
            } else {
                String last3 = intPart.substring(intPart.length() - 3);
                String rest  = intPart.substring(0, intPart.length() - 3);
                StringBuilder sb = new StringBuilder();
                int count = 0;
                for (int i = rest.length() - 1; i >= 0; i--) {
                    sb.append(rest.charAt(i));
                    if (++count % 2 == 0 && i != 0) sb.append(',');
                }
                grouped = sb.reverse().toString() + "," + last3;
            }
            return (neg ? "-" : "") + grouped;
        } catch (NumberFormatException e) {
            return String.valueOf(raw);
        }
    }
%>


<%
pageContext.setAttribute("DATE_FORMAT", Constants.DATE_FORMAT);
pageContext.setAttribute("SESSION_TOKEN_KEY", Constants.SESSION_TOKEN_KEY);
pageContext.setAttribute("STATUS_NO_LABEL", Constants.STATUS_NO_LABEL);
pageContext.setAttribute("STATUS_YES_LABEL", Constants.STATUS_YES_LABEL);
pageContext.setAttribute("STATUS_NO", Constants.STATUS_NO);
pageContext.setAttribute("STATUS_YES", Constants.STATUS_YES);
%>

<style type="text/css">
* {
    box-sizing: border-box;
}

.page-container {
    padding: 12px;
}

.fire-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 12px;
    flex-wrap: wrap;
    margin-bottom: 16px;
    padding: 16px 18px;
    background: linear-gradient(135deg, #f8fbff, #eef5fc);
    border: 1px solid #d8e4f0;
    border-radius: 8px;
}

.fire-header-left h2 {
    margin: 0;
    color: #1f3b57;
    font-size: 22px;
}

.fire-header-left p {
    margin: 6px 0 0;
    color: #60758a;
    font-size: 13px;
}

.fire-total-box {
    background: #ffffff;
    border: 1px solid #dce6f1;
    border-radius: 8px;
    padding: 12px 18px;
    min-width: 180px;
    text-align: center;
}

.fire-total-box .label {
    display: block;
    font-size: 12px;
    color: #6b7d90;
    margin-bottom: 4px;
}

.fire-total-box .value {
    font-size: 24px;
    font-weight: bold;
    color: #214e78;
}

.summary-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 14px;
    margin-bottom: 18px;
}

.summary-card {
    background: #ffffff;
    border: 1px solid #dde6ef;
    border-radius: 8px;
    padding: 14px 16px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.04);
}

.summary-card .title {
    font-size: 13px;
    color: #617385;
    margin-bottom: 8px;
}

.summary-card .count {
    font-size: 24px;
    font-weight: bold;
    color: #1f4f78;
}

.summary-card .jump-link {
    display: inline-block;
    margin-top: 10px;
    color: #2c6fb2;
    text-decoration: none;
    font-size: 13px;
    font-weight: 600;
}

.summary-card .jump-link:hover {
    text-decoration: underline;
}

.ClsSearch {
    margin-bottom: 18px;
    border: 1px solid #d9e4ee;
    border-radius: 8px;
    overflow: hidden;
    background: #ffffff;
}

.ClsSearchTitle {
    padding: 12px 14px;
    background: #eef4fa;
    color: #23425f;
    font-weight: bold;
    display: flex;
    align-items: center;
    gap: 10px;
}

.searchForm {
    width: 100%;
    border-collapse: collapse;
}

.searchForm td {
    padding: 10px 12px;
    vertical-align: middle;
}

.searchForm input[type="text"],
.searchForm select {
    width: 100%;
    min-width: 160px;
    padding: 7px 8px;
    border: 1px solid #cdd8e3;
    border-radius: 4px;
    background: #fff;
}

.section-panel {
    margin-bottom: 16px;
    border: 1px solid #d7e1eb;
    border-radius: 8px;
    overflow: hidden;
    background: #ffffff;
}

.section-toggle {
    width: 100%;
    border: none;
    outline: none;
    cursor: pointer;
    text-align: left;
    padding: 14px 16px;
    background: #f3f8fd;
    color: #1f3b57;
    font-size: 15px;
    font-weight: bold;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.section-toggle:hover {
    background: #eaf2fb;
}

.section-toggle.active {
    background: #dfeefa;
}

.section-toggle .section-title-wrap {
    display: flex;
    align-items: center;
    gap: 10px;
    flex-wrap: wrap;
}

.section-count-badge {
    display: inline-block;
    padding: 4px 10px;
    border-radius: 20px;
    background: #2f6fad;
    color: #fff;
    font-size: 12px;
    font-weight: bold;
}

.section-toggle .arrow {
    font-size: 18px;
    font-weight: bold;
}

.section-content {
    max-height: none;
    overflow: hidden;
    transition: max-height 0.25s ease-out;
    background: #ffffff;
}

.section-inner {
    padding: 14px;
}

.table-wrapper {
    width: 100%;
    overflow-x: auto;
    border: 1px solid #e2e9f0;
    border-radius: 6px;
}

.dataGrid {
    width: 100%;
    min-width: 1050px;
    border-collapse: collapse;
}

.dataGrid thead td {
    background: #edf4fb;
    color: #24384c;
    font-weight: bold;
    padding: 10px 8px;
    border-bottom: 1px solid #d7e1eb;
    white-space: nowrap;
}

.dataGrid tbody td {
    padding: 10px 8px;
    border-bottom: 1px solid #edf1f5;
    vertical-align: top;
}

.dataGrid tbody tr:nth-child(even) {
    background: #fbfdff;
}

.dataGrid tbody tr:hover {
    background: #f4f9ff;
}

.status-badge {
    display: inline-block;
    padding: 5px 10px;
    border-radius: 16px;
    font-size: 12px;
    font-weight: 600;
    line-height: 1.4;
    background: #eef3f8;
    color: #2f4356;
}

.category-badge {
    display: inline-block;
    padding: 5px 10px;
    border-radius: 16px;
    font-size: 12px;
    font-weight: 600;
    line-height: 1.4;
    color: #ffffff;
}

.category-citizen {
    background: #2f855a;
}

.category-l1 {
    background: #805ad5;
}

.category-forwarded {
    background: #dd6b20;
}

.txn-box {
    background: #f8fafc;
    border: 1px solid #e1e8ef;
    border-radius: 5px;
    padding: 8px 10px;
    margin-bottom: 8px;
}

.txn-box:last-child {
    margin-bottom: 0;
}

.txn-label {
    font-weight: bold;
    color: #4b5c6d;
}

.empty-records {
    padding: 18px;
    text-align: center;
    color: #708090;
    font-weight: 600;
}

.quick-links {
    margin-bottom: 16px;
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
}

.quick-links a {
    display: inline-block;
    padding: 8px 14px;
    background: #ffffff;
    border: 1px solid #d6e2ee;
    border-radius: 20px;
    text-decoration: none;
    color: #285b8f;
    font-size: 13px;
    font-weight: 600;
}

.quick-links a:hover {
    background: #edf5fd;
}

@media screen and (max-width: 991px) {
    .summary-grid {
        grid-template-columns: 1fr;
    }
}

@media screen and (max-width: 767px) {
    .fire-header {
        flex-direction: column;
        align-items: flex-start;
    }

    .fire-total-box {
        width: 100%;
    }

    .searchForm tr,
    .searchForm td {
        display: block;
        width: 100%;
    }

    .searchForm td {
        padding: 8px 12px;
    }

    .section-toggle {
        font-size: 14px;
    }
}
</style>

<script type="text/javascript">
function editRTIApplication(id) {
    document.getElementById('rtiApplicationRefId').value = id;
    onPageSubmit('<c:out value="${contextRoot}"/>/rtsapplication/editFireRecommendation.do');
}

function searchRTIApplication() {
    onPageSubmit('<c:out value="${contextRoot}"/>/rtsapplication/listRTSFireRecommendation.do');
}

function toggleSection(button) {
    var content = button.nextElementSibling;
    var arrow = button.querySelector(".arrow");

    button.classList.toggle("active");

    if (content.style.maxHeight && content.style.maxHeight !== "0px") {
        content.style.maxHeight = null;
        if (arrow) {
            arrow.innerHTML = "+";
        }
    } else {
        content.style.maxHeight = content.scrollHeight + "px";
        if (arrow) {
            arrow.innerHTML = "-";
        }
    }
}

window.onload = function() {
    var openSections = document.getElementsByClassName("section-toggle");
    for (var i = 0; i < openSections.length; i++) {
        toggleSection(openSections[i]);
    }
};
</script>

<div class="page-container" id="SetFormHeight">

    <div class="fire-header">
        <div class="fire-header-left">
            <h2><c:out value="${requestScope.pageTitle}" /></h2>
        </div>

        <div class="fire-total-box">
            <span class="label">Total Records</span>
            <span class="value"><c:out value="${requestScope.totalCount}" /></span>
        </div>
    </div>

    <div class="summary-grid">
        <div class="summary-card">
            <div class="title">Fire Applications Received From Citizen</div>
            <div class="count"><c:out value="${requestScope.citizenCount}" /></div>
            <a class="jump-link" href="#citizenSection">Go to Citizen Records</a>
        </div>

        <div class="summary-card">
            <div class="title">Fire Applications Received From L1 Level</div>
            <div class="count"><c:out value="${requestScope.l1Count}" /></div>
            <a class="jump-link" href="#l1Section">Go to L1 Records</a>
        </div>

        <div class="summary-card">
            <div class="title">Forwarded Fire Applications</div>
            <div class="count"><c:out value="${requestScope.forwardedCount}" /></div>
            <a class="jump-link" href="#forwardedSection">Go to Forwarded Records</a>
        </div>
    </div>

    <div class="quick-links">
        <a href="#citizenSection">Citizen</a>
        <a href="#l1Section">L1 Level</a>
        <a href="#forwardedSection">Forwarded</a>
    </div>

    <!-- <div id="SearchDivId" class="ClsSearch">
        <div class="ClsSearchTitle">
            <img src="<c:out value="${contextRoot}"/>/images/closed.gif"
                 id="searchToggleImage"
                 onclick="javascript:ToggleSearch('SearchTable','searchToggleImage','<c:out value="${contextRoot}"/>')" />
            <fmt:message key="search.label.heading" />
        </div>

        <table id="SearchTable" class="searchForm" style="display: none;">
            <tr>
                <td><fmt:message key="rtiApplication.list.label.rtiApplnNumber" /></td>
                <td>
                    <input type="text" class="ClsTextbox"
                           id="searchrtiApplnNumber"
                           maxlength="45"
                           name="searchrtiApplnNumber"
                           value="<c:out value="${SearchOptions.searchrtiApplnNumber}"/>" />
                </td>

                <td>
                    <span class="ClsLabel">
                        <fmt:message key="rtiApplication.manage.label.department" />
                    </span>
                </td>
                <td>
                    <select name="searchDepartmentId" id="searchDepartmentId">
                        <option value="">--- Select ---</option>
                        <c:forEach var="department" items="${requestScope.departmentList}">
                            <c:choose>
                                <c:when test="${SearchOptions.searchdepartment == department.departmentId}">
                                    <option value="${department.departmentId}" selected="selected">
                                        <c:out value="${department.name}" />
                                    </option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${department.departmentId}">
                                        <c:out value="${department.name}" />
                                    </option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </td>
            </tr>

            <tr>
                <td>
                    <span class="ClsLabel">
                        <fmt:message key="rtiApplication.manage.label.appdate" />
                        <fmt:message key="search.label.between" />
                    </span>
                </td>
                <td>
                    <input type="text" class="ClsTextboxDate" id="fromDate"
                           maxlength="10" name="fromDate"
                           value="<c:out value="${SearchOptions.fromDate}"/>" />
                    <span class="ClsLabel"> - </span>
                    <input type="text" class="ClsTextboxDate" id="toDate"
                           maxlength="10" name="toDate"
                           value="<c:out value="${SearchOptions.toDate}"/>" />
                </td>

                <td colspan="2">
                    <input type="button" class="ClsButton" id="search" name="search"
                           value="<fmt:message key="common.button.search"/>"
                           onclick="javascript:searchRTIApplication()" />

                    <input type="button" class="ClsButton" id="clear" name="clear"
                           value="<fmt:message key="common.button.clear"/>"
                           onclick="javascript:clearFields('SearchTable');searchRTIApplication()" />
                </td>
            </tr>
        </table>

        <c:if test="${SearchOptions.searchParamSet == true}">
            <script type="text/javascript">
                ToggleSearch('SearchTable', 'searchToggleImage', '<c:out value="${contextRoot}"/>');
            </script>
        </c:if>
    </div>-->

    <!-- Citizen Section -->
    <div class="section-panel" id="citizenSection">
        <button type="button" class="section-toggle">
            <span class="section-title-wrap">
                <span>Fire Applications Received From Citizen</span>
                <span class="section-count-badge"><c:out value="${requestScope.citizenCount}" /></span>
            </span>
            <span class="arrow">+</span>
        </button>

        <div class="section-content">
            <div class="section-inner">
                <div class="table-wrapper">
                    <table cellpadding="0" cellspacing="1" class="dataGrid">
                        <thead>
                            <tr>
                                <td>Application No.</td>
                                <td>Registration Date</td>
                                <td>Applicant Name</td>
                                <td>Category</td>
                                <td>Status</td>
                                <td>Transaction Details</td>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty citizenList}">
                                    <c:forEach var="rtiApplnList" items="${citizenList}">
                                        <tr>
                                            <td>
                                              
                                                    <c:out value="${rtiApplnList.rtiApplnNumber}" />
                                                
                                            </td>
                                            <td><c:out value="${rtiApplnList.registrationDate}" /></td>
                                            <td><c:out value="${rtiApplnList.applicantName}" /></td>
                                            <td><span class="category-badge category-citizen">Citizen</span></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${rtiApplnList.workFlowStatus == 0}">
                                                        <span class="status-badge">Citizen Form Submitted and scrutiny fee paid</span>
                                                    </c:when>
                                                    <c:when test="${rtiApplnList.workFlowStatus == 3}">
                                                        <span class="status-badge">Citizen Payment Pending</span>
                                                    </c:when>
                                                    <c:when test="${rtiApplnList.workFlowStatus == 2}">
                                                        <span class="status-badge">Citizen Payment Completed</span>
                                                    </c:when>
                                                    <c:when test="${rtiApplnList.workFlowStatus == 1}">
                                                        <span class="status-badge">Completed</span>
                                                    </c:when>
                                                    <c:when test="${rtiApplnList.workFlowStatus == 5}">
                                                        <span class="status-badge">Rejected</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge">N/A</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:set var="payments" value="${paymentMap[rtiApplnList.rtiApplicationId]}" />
                                                <c:choose>
                                                    <c:when test="${not empty payments}">
                                                        <c:forEach items="${payments}" var="pay">
                                                            <div class="txn-box">
                                                            <div>
    <span class="txn-label">Amount:</span>
    	    <c:set var="rawAmt" value="${pay.amount}"/><%= fmtIndianAmount(pageContext.getAttribute("rawAmt")) %>
    
<!--<fmt:formatNumber value="${pay.amount}" pattern="##,##,##0" />-->
</div>

                                                                <div><span class="txn-label">Txn Id:</span> <c:out value="${pay.uniqPgid}" /></div>
                                                            </div>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge">No Transaction Details</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" class="empty-records">
                                            No Citizen records found.
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- L1 Section -->
    <div class="section-panel" id="l1Section">
        <button type="button" class="section-toggle">
            <span class="section-title-wrap">
                <span>Fire Applications Received From L1 Level</span>
                <span class="section-count-badge"><c:out value="${requestScope.l1Count}" /></span>
            </span>
            <span class="arrow">+</span>
        </button>

        <div class="section-content">
            <div class="section-inner">
                <div class="table-wrapper">
                    <table cellpadding="0" cellspacing="1" class="dataGrid">
                        <thead>
                            <tr>
                                <td>Application No.</td>
                                <td>Registration Date</td>
                                <td>Applicant Name</td>
                                <td>Category</td>
                                <td>Status</td>
                                <td>Transaction Details</td>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty l1List}">
                                    <c:forEach var="rtiApplnList" items="${l1List}">
                                        <tr>
                                            <td>
                                            
                                                    <c:out value="${rtiApplnList.rtiApplnNumber}" />
                                                
                                            </td>
                                            <td><c:out value="${rtiApplnList.registrationDate}" /></td>
                                            <td><c:out value="${rtiApplnList.applicantName}" /></td>
                                            <td><span class="category-badge category-l1">L1 Level</span></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${rtiApplnList.workFlowStatus == 0}">
                                                        <span class="status-badge">Citizen Form Submitted and scrutiny fee paid</span>
                                                    </c:when>
                                                    <c:when test="${rtiApplnList.workFlowStatus == 3}">
                                                        <span class="status-badge">Citizen Payment Pending</span>
                                                    </c:when>
                                                    <c:when test="${rtiApplnList.workFlowStatus == 2}">
                                                        <span class="status-badge">Citizen Payment Completed</span>
                                                    </c:when>
                                                    <c:when test="${rtiApplnList.workFlowStatus == 1}">
                                                        <span class="status-badge">Completed</span>
                                                    </c:when>
                                                    <c:when test="${rtiApplnList.workFlowStatus == 5}">
                                                        <span class="status-badge">Rejected</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge">N/A</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:set var="payments" value="${paymentMap[rtiApplnList.rtiApplicationId]}" />
                                                <c:choose>
                                                    <c:when test="${not empty payments}">
                                                        <c:forEach items="${payments}" var="pay">
                                                            <div class="txn-box">
                                                                <div><span class="txn-label">Amount:</span> <c:out value="${pay.amount}" /></div>
                                                                <div><span class="txn-label">Txn Id:</span> <c:out value="${pay.uniqPgid}" /></div>
                                                            </div>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge">No Transaction Details</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" class="empty-records">
                                            No L1 Level records found.
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Forwarded Section -->
    <div class="section-panel" id="forwardedSection">
        <button type="button" class="section-toggle">
            <span class="section-title-wrap">
                <span>Forwarded Fire Applications</span>
                <span class="section-count-badge"><c:out value="${requestScope.forwardedCount}" /></span>
            </span>
            <span class="arrow">+</span>
        </button>

        <div class="section-content">
            <div class="section-inner">
                <div class="table-wrapper">
                    <table cellpadding="0" cellspacing="1" class="dataGrid">
                        <thead>
                            <tr>
                                <td>Application No.</td>
                                <td>Registration Date</td>
                                <td>Applicant Name</td>
                                <td>Category</td>
                                <td>Status</td>
                                <td>Transaction Details</td>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty forwardedList}">
                                    <c:forEach var="rtiApplnList" items="${forwardedList}">
                                        <tr>
                                            <td>
                                             
                                                    <c:out value="${rtiApplnList.rtiApplnNumber}" />
                                               
                                            </td>
                                            <td><c:out value="${rtiApplnList.registrationDate}" /></td>
                                            <td><c:out value="${rtiApplnList.applicantName}" /></td>
                                            <td><span class="category-badge category-forwarded">Forwarded</span></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${rtiApplnList.workFlowStatus == 0}">
                                                        <span class="status-badge">Citizen Form Submitted and scrutiny fee paid</span>
                                                    </c:when>
                                                    <c:when test="${rtiApplnList.workFlowStatus == 3}">
                                                        <span class="status-badge">Citizen Payment Pending</span>
                                                    </c:when>
                                                    <c:when test="${rtiApplnList.workFlowStatus == 2}">
                                                        <span class="status-badge">Citizen Payment Completed</span>
                                                    </c:when>
                                                    <c:when test="${rtiApplnList.workFlowStatus == 1}">
                                                        <span class="status-badge">Completed</span>
                                                    </c:when>
                                                    <c:when test="${rtiApplnList.workFlowStatus == 5}">
                                                        <span class="status-badge">Rejected</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge">N/A</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                            <c:set var="payments" value="${paymentMap[rtiApplnList.rtiApplicationId]}" />
<c:choose>
    <c:when test="${not empty payments}">
        <c:forEach items="${payments}" var="pay">
            <div class="txn-box">
                <div><span class="txn-label">Amount:</span> <c:out value="${pay.amount}" /></div>
                <div><span class="txn-label">Txn Id:</span> <c:out value="${pay.uniqPgid}" /></div>
            </div>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <span class="status-badge">No Transaction Details</span>
    </c:otherwise>
</c:choose>
                                              
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" class="empty-records">
                                            No Forwarded records found.
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <input type="hidden" id="rtiApplicationRefId" name="rtiApplicationRefId" value="" />
    <input type="hidden" id="rtiApplicationId" name="rtiApplicationId" value="" />
    <input type="hidden" id="SortBy" name="SortBy" value="<c:out value="${requestScope.SortBy}"/>" />
    <input type="hidden" id="OrderBy" name="OrderBy" value="<c:out value="${requestScope.OrderBy}"/>" />

    <script type="text/javascript">
        insert_image('${contextRoot}');
    </script>
</div>