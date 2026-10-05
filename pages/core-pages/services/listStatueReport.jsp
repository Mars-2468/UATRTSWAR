<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.page import="com.mars.common.utils.Constants" />
<jsp:directive.page import="com.mars.common.utils.CommonUtils" />

<%
	pageContext.setAttribute("DATE_FORMAT", Constants.DATE_FORMAT);
	pageContext.setAttribute("SESSION_TOKEN_KEY",
			Constants.SESSION_TOKEN_KEY);
	pageContext.setAttribute("STATUS_NO_LABEL",
			Constants.STATUS_NO_LABEL);
	pageContext.setAttribute("STATUS_YES_LABEL",
			Constants.STATUS_YES_LABEL);
	pageContext.setAttribute("STATUS_NO", Constants.STATUS_NO);
	pageContext.setAttribute("STATUS_YES", Constants.STATUS_YES);
	///pageContext.setAttribute("statusList", CommonUtils.getStatus());
%>

<script type="text/javascript">
/* function generateReport(url) {

	
	const startDateElement = document.getElementById('startDate');
    const startDate = startDateElement.value.trim();
    
    const endDateElement = document.getElementById('endDate');
    const endDate = endDateElement.value.trim();

    if (!endDate) {
        alert("End Date is mandatory. Please enter a valid End Date.");
        endDateElement.focus(); // Focus the field for user convenience
        return false; // Prevent further execution
    }

    if (window.confirm("Do you want to generate the report?")) {
        onPageSubmit('<c:out value="${contextRoot}"/>/rtiapplication/' + url);
    } else {
        return false;
    }
} */


function generateReport(url) {

    const startDateElement = document.getElementById('startDate');
    const startDate = startDateElement.value.trim();
    
    const endDateElement = document.getElementById('endDate');
    const endDate = endDateElement.value.trim();

    if (!startDate || !endDate) {
        alert("Date fields are mandatory. Please enter valid dates.");
        if (!startDate) {
            startDateElement.focus(); // Focus the field for user convenience
        } else {
            endDateElement.focus(); // Focus the field for user convenience
        }
        return false; // Prevent further execution
    }

    if (new Date(startDate) > new Date(endDate)) {
        alert("Start Date cannot be after End Date. Please enter a valid date range.");
        startDateElement.focus(); // Focus the field for user convenience
        return false; // Prevent further execution
    }

    if (window.confirm("Do you want to generate the report?")) {
        onPageSubmit('<c:out value="${contextRoot}"/>/rtiapplication/' + url+'?startDate='+startDate+'&endDate='+endDate);
    } else {
        return false;
    }
}

</script>
<style type="text/css">
input[type=text] {
	background-color: whitesmoke;
	width: 290px;
	font: italic;
	box-sizing: border-box;
	border: 1px solid #c8c8c8;
	box-shadow: 0 0 2px;
	border-radius: 5px;
}

textarea[type=text] {
	background-color: whitesmoke;
	width: 290px;
	font: italic;
	box-sizing: border-box;
	border: 1px solid #c8c8c8;
	box-shadow: 0 0 2px;
	border-radius: 5px;
}

.ClsSelect {
	background-color: whitesmoke;
	width: 200px;
	font: italic;
	box-sizing: border-box;
	border: 1px solid #c8c8c8;
	box-shadow: 0 0 2px;
	border-radius: 5px;
}

.ClsButton {
	background-color: #0596b5;;
	border: 1px solid #212529;
	color: #f8f9fa;
	border-color: #b6effb;;
	box-shadow: 0 0 2px;
}

.imagefile downloadFile:HOVER {
	background-color: #008CBA;
	color: white;
}

.mainHdr {
	background-color: white;
}

.form {
	background-color: white;
	border: 1px solid #b88b8b;
	border-style: solid;
	background-image: url("D:\nmmc_RTS1\RTI\web\images\flag-bg.jpg");
	background-color: white;
	background-position: right center;
	background: #eceff3 url("img_tree.gif") no-repeat fixed center;
}

.ClsLabel {
	font-style: normal;
	font-family: inherit;
	font-size: 10px;
	font-weight: 100;
}

.ClsTextbox {
	background-color: whitesmoke
}
</style>
<div valign="top" id="SetFormHeight">

	<div class="mainHdr">
		<h3>

			<fmt:message key="Report For Statue Cleaning " />


		</h3>
	</div>
	<table>

		<tr>
			<td><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="From Date" /><span class="ClsRequiredFields"></span>:</span>
			</td>
			
				<td><input type="date" class="ClsTextbox" style="width: 170px"
				id="startDate" maxlength="50" name="startDate" value="">
				</td>
			
		</tr>
		
		
		<tr>
			<td><span class="ClsLabel" style="font-size: 14px"><fmt:message
						key="TO Date" /><span class="ClsRequiredFields"></span>:</span>
			</td>
			
			<td><input type="date" class="ClsTextbox" style="width: 170px"
				id="endDate" maxlength="50" name="endDate"
				value=""></td>
			
		</tr>

		<tr>

			<td colspan=2; style="text-align: center;">
				<button class="ClsButton"
					onclick="javascript:generateReport('statueReport.do');">GENERATE
					REPORT</button>
			</td>
		</tr>


	</table>


	<script type="text/javascript">
		insert_image('${contextRoot}');
	</script>
</div>