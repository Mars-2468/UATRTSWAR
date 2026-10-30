<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.page import="com.mars.common.utils.Constants" />
<jsp:directive.page import="com.mars.common.utils.CommonUtils" />

<%
pageContext.setAttribute("DATE_FORMAT", Constants.DATE_FORMAT);
pageContext.setAttribute("SESSION_TOKEN_KEY", Constants.SESSION_TOKEN_KEY);
%>

<script type="text/javascript">
	// Opens one submitted application. The id travels in the hidden field the row sets,
	// the same way the other RTS list pages do it.
	function editRTIApplication(id) {
		document.getElementById('rtiApplicationRefId').value = id;
		onPageSubmit('<c:out value="${contextRoot}"/>/rtiapplication/editLodgingLicenceRenewal.do');
	}
	function searchRTIApplication() {
		onPageSubmit('<c:out value="${contextRoot}"/>/rtsapplication/listRTSLodgingLicenceRenewal.do');
	}
</script>

<div class="mainHdr">
	<h3><fmt:message key="rtiApplication.list.pagetitle.list" /> - Renewal of Lodging Licence</h3>
</div>

<div valign="top" id="SetFormHeight">
	<div id="SearchDivId" class="ClsSearch">
		<div class="ClsSearchTitle">
			<img src="<c:out value="${contextRoot}"/>/images/closed.gif" id="searchToggleImage"
				onclick="javascript:ToggleSearch('SearchTable','searchToggleImage','<c:out value="${contextRoot}"/>')" />
			<fmt:message key="search.label.heading" />
		</div>
		<table id="SearchTable" class="searchForm" style="display: none;">
			<tr>
				<td><span class="ClsLabel"><fmt:message key="rtiApplication.list.label.rtiApplnNumber" /></span></td>
				<td><input type="text" class="ClsTextbox" id="searchrtiApplnNumber" maxlength="45"
					style="width: 170px" name="searchrtiApplnNumber"
					value="<c:out value="${SearchfileCreate.rtiApplicationNumber}"/>" /></td>
				<td><span class="ClsLabel"><fmt:message key="rtiApplication.manage.label.appdate" />
					<fmt:message key="search.label.between" /></span></td>
				<td><input type="date" class="ClsTextbox" id="fromDate" name="fromDate" style="width: 160px"
					value="<c:out value="${SearchfileCreate.creationFromDate}"/>" />
					<span class="ClsLabel">-</span>
					<input type="date" class="ClsTextbox" id="toDate" name="toDate" style="width: 160px"
					value="<c:out value="${SearchfileCreate.creationToDate}"/>" /></td>
			</tr>
			<tr>
				<td colspan="4">
					<input type="submit" class="ClsButton" id="search" name="search"
						value="<fmt:message key="common.button.search"/>" onclick="javascript:searchRTIApplication()" />
					&nbsp;
					<input type="button" class="ClsButton" id="clear" name="clear"
						value="<fmt:message key="common.button.clear"/>"
						onclick="javascript:clearFields('SearchTable');searchRTIApplication()" />
				</td>
			</tr>
		</table>
	</div>

	<table cellpadding="0" cellspacing="1" width="98%" class="dataGrid">
		<thead>
			<tr>
				<td onclick="javascript:resort('upper(rtiApplnNumber)');" style="cursor: pointer" wrap>
					<fmt:message key="rtiApplication.list.label.rtiApplnNumber" />
					<span id="upper(rtiApplnNumber)"></span></td>
				<td onclick="javascript:resort('upper(createdDate)');" style="cursor: pointer" wrap>
					<fmt:message key="rtiApplication.manage.label.createdDate" />
					<span id="upper(createdDate)"></span></td>
				<td onclick="javascript:resort('upper(name)');" style="cursor: pointer" wrap>
					<fmt:message key="rtiApplication.manage.label.name" />
					<span id="upper(name)"></span></td>
				<td onclick="javascript:resort('workflowStatus');" style="cursor: pointer" wrap>
					<fmt:message key="feeMaster.manage.label.status" />
					<span id="status"></span></td>
			</tr>
		</thead>
		<tbody>
			<c:set var="hasRows" value="false" />
			<c:forEach var="rtiApplnList" items="${requestScope.rtiapplicationList}" varStatus="rowNumber">
				<c:set var="hasRows" value="true" />
				<tr>
					<td><a title="<fmt:message key="list.link.EditOrViewLink"/>"
						href="javascript:editRTIApplication('${rtiApplnList.rtiApplicationRefId}');">
						<c:out value="${rtiApplnList.rtiApplnNumber}" /></a></td>
					<td><c:out value="${rtiApplnList.registrationDate}" /></td>
					<td><c:out value="${rtiApplnList.applicantName}" /></td>
					<td>
						<c:if test="${rtiApplnList.workFlowStatus==0}">In Progress</c:if>
						<c:if test="${rtiApplnList.workFlowStatus==1}">Completed</c:if>
						<c:if test="${rtiApplnList.workFlowStatus==2}">Citizen Payment Completed</c:if>
						<c:if test="${rtiApplnList.workFlowStatus==3}">Citizen Payment Pending</c:if>
						<c:if test="${rtiApplnList.workFlowStatus==5}">Rejected</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${hasRows == false}">
				<tr>
					<td colspan="4" class="clsNoRecords" align="center">
						<fmt:message key="list.label.norecords" />
					</td>
				</tr>
			</c:if>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="4">
					<c:if test="${requestScope.rtiapplicationList != null && requestScope.totalCount>0}">
						<span><%@include file="/pages/common/pagination.jsp"%></span>
					</c:if>
				</td>
			</tr>
		</tfoot>
	</table>

	<input type="hidden" id="rtiApplicationRefId" name="rtiApplicationRefId" value="" />
	<input type="hidden" id="SortBy" name="SortBy" value="<c:out value="${requestScope.SortBy}"/>" />
	<input type="hidden" id="OrderBy" name="OrderBy" value="<c:out value="${requestScope.OrderBy}"/>" />
	<%-- setSearchParameters reads serviceId with Integer.parseInt and is wrapped in a
	     try/catch, so when it is absent the parse throws and every search value set
	     after it - including the two dates - is silently skipped. Posting it back keeps
	     the search working. --%>
	<input type="hidden" id="serviceId" name="serviceId" value="<c:out value="${serviceId}"/>" />
	<script type="text/javascript">insert_image('<c:out value="${contextRoot}"/>');</script>
</div>
