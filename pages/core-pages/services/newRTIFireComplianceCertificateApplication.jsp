<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.include
	file="/pages/core-pages/nmc_user/dashboard/header.jsp" />
<jsp:directive.page import="com.mars.common.utils.Constants" />
<jsp:directive.page import="com.mars.common.utils.CommonUtils" />



<head>
<title>Nagpur Municipal Corporation</title>
<meta charset="utf-8">

<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="csrf-token"
	content="L1tBXJBCG7Qg3zc8hd8zkv3US8Yq8R7ihDGuzHIc" />
<script src="https://code.jquery.com/jquery-3.6.3.min.js"
	integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous"></script>
<!-- CSS only -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="jquery-3.6.1.min.js"></script>
<!-- JavaScript Bundle with Popper -->
<script src="https://code.jquery.com/jquery-3.6.3.min.js"
	integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous"></script>
<!-- CSS only -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="jquery-3.6.1.min.js"></script>
<!-- JavaScript Bundle with Popper -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript"
	src="<c:out value=" ${contextRoot}" />/scripts/jquery/jquery.ajaxfileupload.js">
        </script>
<link rel="stylesheet"
	href="<c:out value='${contextRoot}'/>/pages/core-pages/nmc_user/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="<c:out value='${contextRoot}'/>/pages/core-pages/nmc_user/css/style2.css" />
<script
	src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.js"></script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://code.jquery.com/jquery-3.6.1.js">
<%pageContext.setAttribute("DATE_FORMAT", Constants.DATE_FORMAT);
pageContext.setAttribute("SESSION_TOKEN_KEY", Constants.SESSION_TOKEN_KEY);
pageContext.setAttribute("STATUS_NO_LABEL", Constants.STATUS_NO_LABEL);
pageContext.setAttribute("STATUS_YES_LABEL", Constants.STATUS_YES_LABEL);
pageContext.setAttribute("STATUS_NO", Constants.STATUS_NO);
pageContext.setAttribute("STATUS_YES", Constants.STATUS_YES);
///pageContext.setAttribute("statusList", CommonUtils.getStatus());%>






</script>

<script src="https://code.jquery.com/jquery-3.6.3.min.js"
	integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
	crossorigin="anonymous"></script>

</head>
<style>
label {
	font-weight: 600;
}

h3 {
	font-weight: 500;
}
@page {
  size: legal landscape; /* Landscape orientation for Legal size */
}
@media print {
  body {
    transform: scale(0.9); /* Adjust the scale factor as needed */
    transform-origin: center center;
  }

}

 @page {
     size: auto ;
     }
</style>
<body>
	<form>
		<div class="container-fluid mt-2" style="width: 180vh">

			<div class="printable">
				<h3 style="text-align: center;" class=" rounded-2">
					<strong> 2) अंतिम आग संरक्षक मान्यता प्रमाणपत्र (Final
						fire safety approval Certificate) </strong>
				</h3>
			</div>
			<h6 style="background-color: #dce2e8; padding: 10px;"
				class="rounded-2">
				<strong> Applicant Details (अर्जदाराचे तपशील) </strong>
			</h6>
			<div class="row">
				<input type="hidden" name="_token" value="xyz">

				<!-- 1. Fire RTS Id (Not Mandatory) -->
				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="firertsid" class="form-label lbleng">Fire RTS Id
						</label> <input type="text" class="form-control" id="firertsid"
							style="background-image: none;" placeholder=""
							onchange="getFireRtsData()" name="firertsid" value="">
						<div class="invalid-feedback">Please Enter Valid Fire Rts
							Id.</div>
					</div>
				</div>
				<script
					src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

				<script>
				function getFireRtsData() {
				    alert("ji");
				    var fireRtsId = $("#firertsid").val();

				    $.ajax({
				        type: "POST",
				        url: "${pageContext.request.contextPath}/rtiapplication/getFireRtsDetail.do",
				        data: {
				            firertsid: fireRtsId
				        },
				        dataType: "json",
				        success: function (data) {
				            /* FIX: the field names below now match the actual
				               name="" attributes rendered on this page (previously
				               pointed at "sidemarginalspace" / "rear", which do not
				               exist, so auto-fetch silently failed). */
				            $('[name="frontMargin"]').val(data.front);
				            $('[name="rearMargin"]').val(data.rear);
				            $('[name="side1Margin"]').val(data.side1);
				            $('[name="side2Margin"]').val(data.side2);
				            $('[name="plotarea"]').val(data.plotArea);
				            $('[name="totalbuiltuparea"]').val(data.buildUpArea);
				            $('[name="typeofBuilding"]').val(data.typeOfBuilding);
				            $('[name="nameofBuildingOwner"]').val(data.ownerName);
				            $('[name="sadressofBuilding"]').val(data.buildingAddress);
				            $('[name="heightofBuilding"]').val(data.height);
				            $('[name="widthapproachroad"]').val(data.widthApproachRoad);
				            $('[name="widthentrance"]').val(data.widthEntrance);
				            $('[name="numberoffloors"]').val(data.noOfFloors);

				            if (data.noofInternalStaircase) {
				                var noofInternalStaircase = data.noofInternalStaircase.split(',');
				                var widthInternalStaircaseProvided = data.widthInternalStaircaseProvided.split(',');
				                var srNumber = 1;
				                var tableBody = $('#heightTable tbody');
				                tableBody.empty();
				                noofInternalStaircase.forEach(function(noofInternalStaircaseItem, index) {
				                    var widthInternalStaircaseItem = widthInternalStaircaseProvided[index];
				                    var row = $('<tr><td>' + srNumber + '</td>' +
				                            '<td><input type="text" class="form-control" style="background-image: none;" name="noofInternalStaircase" value="' + noofInternalStaircaseItem + '"></td>' +
				                            '<td><input type="text" class="form-control" style="background-image: none;" name="widthInternalStaircase" value="' + widthInternalStaircaseItem + '"></td></tr>');
				                    tableBody.append(row);
				                    srNumber++;
				                });
				            }


				            if (data.noofExternalStaircase) {
				                var noofExternalStaircase = data.noofExternalStaircase.split(',');
				                var widthExternalStaircaseProvided = data.widthExternalStaircaseProvided.split(',');
				                var srNumber = 1;
				                var tableBody = $('#heightTable1 tbody');
				                tableBody.empty();
				                noofExternalStaircase.forEach(function(noofExternalStaircaseItem, index) {
				                    var widthExternalStaircaseProvidedItem = widthExternalStaircaseProvided[index];
				                    var row = $('<tr><td>' + srNumber + '</td>' +
				                            '<td><input type="text" class="form-control" style="background-image: none;" name="noofExternalStaircase" value="' + noofExternalStaircaseItem + '"></td>' +
				                            '<td><input type="text" class="form-control" style="background-image: none;" name="widthInternalStaircase" value="' + widthExternalStaircaseProvidedItem + '"></td></tr>');
				                    tableBody.append(row);
				                    srNumber++;
				                });
				            }

				            if (data.noofLiftProvided) {
				                var noofLiftProvided = data.noofLiftProvided.split(',');
				                var srNumber = 1;
				                var tableBody = $('#heightTable2 tbody');
				                tableBody.empty();
				                noofLiftProvided.forEach(function(noofLiftProvidedItem, index) {
				                    var row = $('<tr><td>' + srNumber + '</td>' +
				                            '<td><input type="text" class="form-control" style="background-image: none;" name="noofLiftProvided" value="' + noofLiftProvidedItem + '"></td></tr>');
				                    tableBody.append(row);
				                    srNumber++;
				                });
				            }


							},
				        error: function () {
				            // Handle error if AJAX request fails
				            // alert("Error occurred while calculating.");
				        }
				    });
				}


						</script>

				<!-- 2. Provisional Fire Safety Approval -->
				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="provisionalFireSafetyApproval" class="form-label lbleng">Provisional Fire Safety Approval<span
							class="text-danger">*</span>
						</label> <input type="text" class="form-control" id="provisionalFireSafetyApproval"
							style="background-image: none;" placeholder=""  name="provisionalFireSafetyApproval" value="" required>
						<div class="invalid-feedback">Please Enter Valid Provisional Fire Safety Approval</div>
					</div>
				</div>

				<!-- 3. Name of Building Owner (Auto-Fetched) -->
				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="nameofBuildingOwner" class="form-label lbleng">Name of Building Owner<span
							class="text-danger">*</span>
						</label> <input type="text" class="form-control" id="nameofBuildingOwner"
							style="background-image: none;" placeholder="" name="nameofBuildingOwner"
							value=""   required>
						<div class="invalid-feedback">Please Enter Valid Name of Building Owner.</div>
					</div>
				</div>

				<!-- 4. Address of Building (Auto-Fetched) -->
				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="sadressofBuilding" class="form-label lbleng">Address of Building<span
							class="text-danger">*</span></label> <input
							type="text" class="form-control" id="sadressofBuilding"
							style="background-image: none;" placeholder="" name="sadressofBuilding"
							value="" required>
						<div class="invalid-feedback">Please Enter Valid Address of Building.</div>
					</div>
				</div>

				<!-- 5. Type of Building (Auto-Fetched) -->
				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="typeofBuilding" class="form-label lbleng">Type of Building <span
							class="text-danger" style="color: red;">*</span>
						</label> <input type="text" class="form-control"
							style="background-image: none;" name="typeofBuilding" id="typeofBuilding"
							 required>
						<div class="invalid-feedback">Please Enter Valid Type of Building.</div>
					</div>
				</div>

				<!-- 6. Plot area (Auto-Fetched) -->
				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="plotarea" class="form-label">Plot area</label> <input
							type="text" class="form-control" id="plotarea"
							style="background-image: none;" placeholder="" name="plotarea"
							value="" readonly>
					</div>
				</div>

				<!-- 7. Total Built up area (Auto-Fetched) -->
				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="totalbuiltuparea" class="form-label">Total Built up area</label> <input
							type="text" class="form-control" id="totalbuiltuparea"
							style="background-image: none;" placeholder="" name="totalbuiltuparea"
							value="" readonly>
					</div>
				</div>

				<!-- 8. Height of building (Auto-Fetched) -->
				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="heightofBuilding" class="form-label lbleng">Height of building<span
							class="text-danger">*</span>
						</label> <input class="form-control " rows="2" id="heightofBuilding"
							style="background-image: none;" name="heightofBuilding" required>
						<div class="invalid-feedback">Please Enter Valid Height of Building</div>

					</div>
				</div>

				<!-- 9. Side marginal space (Auto-Fetched): Front / Rear / Side1 / Side2 -->
				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="frontMargin" class="form-label lbleng">Front Margin<span
							class="text-danger">*</span>
						</label> <input class="form-control " rows="2" id="frontMargin"
							style="background-image: none;" name="frontMargin" required>
						<div class="invalid-feedback">Please Enter Valid Front Margin</div>

					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="rearMargin" class="form-label lbleng">Rear Margin<span
							class="text-danger">*</span>
						</label> <input class="form-control " rows="2" id="rearMargin"
							style="background-image: none;" name="rearMargin" required>
						<div class="invalid-feedback">Please Enter Valid Rear Margin</div>

					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="side1Margin" class="form-label lbleng">Side1 Margin<span
							class="text-danger">*</span>
						</label> <input class="form-control " rows="2" id="side1Margin"
							style="background-image: none;" name="side1Margin" required>
						<div class="invalid-feedback">Please Enter Valid Side1 Margin</div>

					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="side2Margin" class="form-label lbleng">Side2 Margin<span
							class="text-danger">*</span>
						</label> <input class="form-control " rows="2" id="side2Margin"
							style="background-image: none;" name="side2Margin" required>
						<div class="invalid-feedback">Please Enter Valid Side2 Margin</div>

					</div>
				</div>

				<!-- 13. Width of approach road to the building premises (Auto-Fetched) -->
				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="widthapproachroad" class="form-label lbleng">Width of approach road</label>
						<input type="text" class="form-control" id="widthapproachroad"
							style="background-image: none;" placeholder="" name="widthapproachroad"
							value="" readonly>
					</div>
				</div>

				<!-- 14. Width of entrance (Auto-Fetched) -->
				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="widthentrance" class="form-label lbleng">Width of entrance</label>
						<input type="text" class="form-control" id="widthentrance"
							style="background-image: none;" placeholder="" name="widthentrance"
							value="" readonly>
					</div>
				</div>

				<!-- 15. Number of floors (including basement floor) (Auto-Fetched) -->
				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="numberoffloors" class="form-label lbleng">Number of floors (incl. basement)</label>
						<input type="text" class="form-control" id="numberoffloors"
							style="background-image: none;" placeholder="" name="numberoffloors"
							value="" readonly>
					</div>
				</div>

				<!-- 16. Basement load bearing strength -->
				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="basementloadbearingstrength" class="form-label lbleng">Load bearing strength of
							basement roof (if basement extends beyond building line)</label>
						<input type="text" class="form-control" id="basementloadbearingstrength"
							style="background-image: none;" placeholder="" name="basementloadbearingstrength"
							value="">
					</div>
				</div>

				<!-- 10 / 11 / 12: Lift / Internal Staircase / External Staircase (Auto-Fetched tables) -->
				<div class="table-responsive" style="display: flex; justify-content: space-between;">
				    <div style="width: 49%;">
				    <label>No. of Internal Staircase Provided</label>
				        <table id="heightTable" class="table table-striped table-bordered" style="width: 100%;background-color: #dce2e8;">
				            <thead style="background-color: #dce2e8;">
				                <tr>
				                    <th>Sr Number</th>
				                    <th>No. of Internal Staircase</th>
				                    <th>Width of Internal Staircase</th>
				                </tr>
				            </thead>
				            <tbody>
				            </tbody>
				        </table>
				    </div>
				    <div style="width: 49%;">
				        <label>No. of External Staircase Provided</label>
				        <table id="heightTable1" class="table table-striped table-bordered" style="width: 100%;background-color: #dce2e8;">
				            <thead style="background-color: #dce2e8;">
				                <tr>
				                    <th>Sr Number</th>
				                    <th>No. of External Staircase</th>
				                    <th>Width of External Staircase</th>
				                </tr>
				            </thead>
				            <tbody>
				            </tbody>
				        </table>
				    </div>

				</div>
				<div class="table-responsive" style="display: flex; justify-content: space-between;">
				 <div style="width: 49%;">
				        <label>No. of Lift Provided</label>
				        <table id="heightTable2" class="table table-striped table-bordered" style="width: 100%;background-color: #dce2e8;">
				            <thead style="background-color: #dce2e8;">
				                <tr>
				                    <th>Sr Number</th>
				                    <th>No. of Lift Provided</th>
				                </tr>
				            </thead>
				            <tbody>
				            </tbody>
				        </table>
				    </div>
				</div>

			</div>

			<!-- 17. Exposure Hazards -->
			<h6 style="background-color: #dce2e8; padding: 10px;" class="mt-3 rounded-2">
				<strong>Exposure Hazards (Please give details)</strong>
			</h6>
			<div class="table-responsive">
				<table class="table table-bordered">
					<thead style="background-color: #dce2e8;">
						<tr>
							<th style="width: 40%;">Compass direction in relation to the building</th>
							<th>Type of property / features</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>NORTH</td>
							<td><input type="text" class="form-control" style="background-image: none;" name="exposurehazardNorth"></td>
						</tr>
						<tr>
							<td>SOUTH</td>
							<td><input type="text" class="form-control" style="background-image: none;" name="exposurehazardSouth"></td>
						</tr>
						<tr>
							<td>EAST</td>
							<td><input type="text" class="form-control" style="background-image: none;" name="exposurehazardEast"></td>
						</tr>
						<tr>
							<td>WEST</td>
							<td><input type="text" class="form-control" style="background-image: none;" name="exposurehazardWest"></td>
						</tr>
					</tbody>
				</table>
			</div>

			<!-- 18. Fire & Safety measures as per Provisional Fire Safety Approval Certificate & NBC Norms -->
			<h6 style="background-color: #dce2e8; padding: 10px;" class="mt-3 rounded-2">
				<strong>Fire &amp; Safety Measures (as per Provisional Fire Safety Approval Certificate &amp; NBC Norms)</strong>
			</h6>
			<div class="table-responsive">
				<table class="table table-bordered table-sm">
					<thead style="background-color: #dce2e8;">
						<tr>
							<th style="width: 4%;">Sr.No.</th>
							<th style="width: 28%;">Fire and Safety Measures</th>
							<th style="width: 30%;">Provided / Not Provided / Not Required</th>
							<th style="width: 14%;">Quantity</th>
							<th>Location</th>
						</tr>
					</thead>
					<tbody>
						<%
						String[] measureLabels = new String[] {
							"Portable Fire Extinguisher",
							"Hose Reel",
							"Hose Box",
							"Wet Riser/Down Comer",
							"Yard Hydrant or Ring Hydrant around the building",
							"Automatic Sprinkler System",
							"Manually Operated Electronic Fire Alarm System",
							"Automatic Detection and Alarm System",
							"Underground Static water Storage tank for fire fighting purpose",
							"Terrace Tank over Respective Tower Terrace for fire fighting purpose",
							"Pump Near Underground Static Water Storage Tank (Fire Pump) with minimum pressure of 3.5 kg/cm\u00B2 at Remotest location",
							"Pump near the terrace tank level with minimum Pressure of 3.5 kg/cm\u00B2",
							"Fire Brigade connection for Static water tank and for Hydrant System",
							"Exit signage & escape lighting for all fire safety safe evacuation of occupants in case of emergency signs",
							"Auto DG Backup/Stand by power supply",
							"Fire Resistance Door",
							"Public address system",
							"Fire Control Room",
							"Fire Damper",
							"Refuge Area",
							"Lightning Arrester",
							"Any Other information",
							"Switchgear and transformer",
							"Qualified Fire Officer appointed for building (Yes/No)"
						};
						for (int i = 0; i < measureLabels.length; i++) {
							int sr = i + 1;
						%>
						<tr>
							<td><%= sr %></td>
							<td><%= measureLabels[i] %></td>
							<td>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="measureStatus_<%= sr %>" id="measureStatus_<%= sr %>_provided" value="Provided">
									<label class="form-check-label" for="measureStatus_<%= sr %>_provided">Provided</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="measureStatus_<%= sr %>" id="measureStatus_<%= sr %>_notprovided" value="NotProvided">
									<label class="form-check-label" for="measureStatus_<%= sr %>_notprovided">Not Provided</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="measureStatus_<%= sr %>" id="measureStatus_<%= sr %>_notrequired" value="NotRequired">
									<label class="form-check-label" for="measureStatus_<%= sr %>_notrequired">Not Required</label>
								</div>
							</td>
							<td><input type="text" class="form-control" style="background-image: none;" name="measureQty_<%= sr %>"></td>
							<td><input type="text" class="form-control" style="background-image: none;" name="measureLocation_<%= sr %>"></td>
						</tr>
						<% } %>
					</tbody>
				</table>
			</div>

			<!-- 22. Other information -->
			<div class="row">
				<div class="col-md-12">
					<div class="mb-3 mt-3">
						<label for="otherinfo" class="form-label lbleng">Other information related to fire fighting &amp; life safety arrangement</label>
						<textarea class="form-control" rows="2" id="otherinfo" style="background-image: none;" name="otherinfo"></textarea>
						<small class="text-muted">Above information is true to the best of knowledge as of date.</small>
					</div>
				</div>
			</div>

			<!-- 23-27. Certifying Architect / Owner details -->
			<h6 style="background-color: #dce2e8; padding: 10px;" class="mt-3 rounded-2">
				<strong>Certifying Architect / Owner Details</strong>
			</h6>
			<div class="row">
				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="nameofarchitect" class="form-label lbleng">Name of Architect<span class="text-danger">*</span></label>
						<input type="text" class="form-control" id="nameofarchitect" style="background-image: none;" name="nameofarchitect" required>
						<div class="invalid-feedback">Please Enter Valid Name of Architect</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="architectlicenseno" class="form-label lbleng">License No.<span class="text-danger">*</span></label>
						<input type="text" class="form-control" id="architectlicenseno" style="background-image: none;" name="architectlicenseno" required>
						<div class="invalid-feedback">Please Enter Valid License No.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="addressofarchitect" class="form-label lbleng">Address (Architect)<span class="text-danger">*</span></label>
						<input type="text" class="form-control" id="addressofarchitect" style="background-image: none;" name="addressofarchitect" required>
						<div class="invalid-feedback">Please Enter Valid Address</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="nameofownerdeclaration" class="form-label lbleng">Name of Owner<span class="text-danger">*</span></label>
						<input type="text" class="form-control" id="nameofownerdeclaration" style="background-image: none;" name="nameofownerdeclaration" required>
						<div class="invalid-feedback">Please Enter Valid Name of Owner</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="addressofownerdeclaration" class="form-label lbleng">Address (Owner)<span class="text-danger">*</span></label>
						<input type="text" class="form-control" id="addressofownerdeclaration" style="background-image: none;" name="addressofownerdeclaration" required>
						<div class="invalid-feedback">Please Enter Valid Address</div>
					</div>
				</div>
			</div>

			<div class="row">

				<h6 style="background-color: white; padding: 10px;"
					class="mt-3 rounded-2">
					<strong> List of Documents (with attachment) </strong>
				</h6>

				<div class="alert alert-info mb-0 p-2 mb-4">
					<small><strong>Note: </strong> Upload Below Files only
						pdf, .jpg, .jpeg, .bmp etc..(Max upto 5MB) </small>
				</div>

				<input type="hidden" name="filesPath" id="filesPath" />

				<!-- i. Fitness certificate from licensing agency -->
				<div class="col-md-3">
					<div class="mb-3 mt-3 ">
						<label for="doc1" class="form-label">Fitness certificate
							from licensing agency<span class="mand_error"
							style="color: red;">*</span>
						</label> <input type="file" class="form-control"
							style="background-image: none;" id="doc1" placeholder=""
							name="Fitness_certificate_from_licensing_agency" required>
						<div class="invalid-feedback">File selected is either
							greater than 5Mb or not of type pdf</div>

					</div>
				</div>

				<!-- ii. Civil Engineer certificate of Structural stability -->
				<div class="col-md-3">
					<div class="mb-3 mt-5">
						<label for="doc2" class="form-label">Civil Engineer
							certificate of Structural stability<span class="mand_error" style="color: red;">*</span>
						</label> <input type="file" class="form-control"
							style="background-image: none;" id="doc2" placeholder=""
							name="civil_Engineer_certificate_of_Structural_stability" required>
						<div class="invalid-feedback">File selected is either
							greater than 5Mb or not of type pdf</div>

					</div>
				</div>

				<!-- iii. Architect certificate for fire water tanks -->
				<div class="col-md-3">
					<div class="mb-3 mt-4">
						<label for="doc3" class="form-label"> Architect certificate
							for fire water tanks<span class="mand_error"
							style="color: red;">*</span>
						</label> <input type="file" class="form-control"
							style="background-image: none;" id="doc3" placeholder=""
							name="architect_certificate_for_fire_water_tanks" required>
						<div class="invalid-feedback">File selected is either
							greater than 5Mb or not of type pdf</div>
					</div>
				</div>

				<!-- iv. Electrical inspector certificate -->
				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="doc4" class="form-label"> Electrical inspector
							certificate <span class="mand_error" style="color: red;">*</span>
						</label> <input type="file" class="form-control"
							style="background-image: none;" id="doc4" placeholder=""
							name="electrical_inspector_certificate" required>
						<div class="invalid-feedback">File selected is either
							greater than 5Mb or not of type pdf</div>
					</div>
				</div>

				<!-- v. Sanctioned building plan -->
				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="doc5" class="form-label"> Sanctioned building
							plan <span class="mand_error" style="color: red;">*</span>
						</label> <input type="file" class="form-control"
							style="background-image: none;"
							name="sanctioned_building_plan" id="doc5" placeholder=""
							required>
						<div class="invalid-feedback">File selected is either
							greater than 5Mb or not of type pdf</div>
					</div>
				</div>

				<!-- vi. License copy of lift -->
				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="doc6" class="form-label"> License copy of lift<span
							class="mand_error" style="color: red;">*</span>
						</label> <input type="file" class="form-control"
							style="background-image: none;" name="License_copy_of_lift"
							id="doc6" placeholder="" required>
						<div class="invalid-feedback">File selected is either
							greater than 5Mb or not of type pdf</div>
					</div>
				</div>
			</div>



			<div class="col-md-12">
				<div class="mb-5 mt-4 ">
					<div class="form-check">
						<input class="form-check-input" type="checkbox" id="check11"
							name="declaration" value="something" required> <label
							class="form-check-label ms-3 lbleng" style="margin-top: 0px;">
							<strong>Declaration <span class="text-danger"
								style="color: red;">*</span>:-
						</strong>I hereby declare that, all the information provided by me
							in the above application is true. If it is found wrong or not
							related, I permit the authority to reject the application.
						</label>
						<div class="invalid-feedback">Please check the
							declaration.</div>
					</div>
				</div>
			</div>
			<div class="col-md-12 text-start mb-5">
				<div class="text-center">
					<button type="button" class="btn btn-danger btn_sm printMe">
						View and Print</button>
					<button class="btn btn-success btn_sm" type="submit" id="submit"
						onclick="javascript:upload();">Submit</button>
				</div>
			</div>
		</div>
	</form>
</body>




<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://code.jquery.com/jquery-3.6.1.js"></script>

<script type="text/javascript">
$('.printMe').on('click', function () {

    window.print();
});
</script>

<script type="text/javascript">


    $.ajaxSetup({
        beforeSend: function () {
            $("#overlay").fadeIn();
            $('body').css({
                'cursor': 'progress'
            });

        },
        complete: function () {
            $("#overlay").fadeOut();
            $('body').css({
                'cursor': 'default'
            });
        }
    });



    function permitnoo(permitno) {
        document.getElementById('permitno').innerText = permitno.value;
    }

    function reciptno(pname2) {
        document.getElementById('receiptno').innerText = pname2.value;
    }
    function letterno(pname3) {
        document.getElementById('letterno').innerText = pname3.value;
    }
    function date1(date11) {
        document.getElementById('date1').innerText = date11.value;
    }
    function date2(date12) {
        document.getElementById('date2').innerText = date12.value;
    }
    function date3(date13) {
        document.getElementById('date3').innerText = date13.value;
    }
</script>

<script type="text/javascript">
    $(document).ready(function () {

        $("#submit").click(function () {


            $("form:first").addClass("needs-validation");
            $("form:first").attr("novalidate", "");
            // Fetch all the forms we want to apply custom Bootstrap validation styles to
            const forms = document.querySelectorAll('.needs-validation')

            // Loop over them and prevent submission
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    } else {
                        onPageSubmit('<c:out value="${contextRoot}"/>/rtsapplication/saveFireComplianceCertificates.do');
                    }

                    form.classList.add('was-validated')
                }, false)
            })
        });

        $('input,select,textarea').on('focusout', function () {

            var isFileAllowed = true;
            if (this.getAttribute("type") === 'file') {
                var name = this.files[0].name;
                if ((this.files[0].size < 5000000) && (name.endsWith('.pdf'))) {
                    isFileAllowed = true;
                } else {
                    isFileAllowed = false;
                }
            }

            if (this.checkValidity() && isFileAllowed) {
                this.classList.remove('is-invalid')
                this.classList.add('is-valid')
            } else {
                this.classList.remove('is-valid')
                this.classList.add('is-invalid')
            }
        });
    });



    function upload() {
        console.log("@@upoading@@");
        var url = window.location.href;
		//var url = 'https://rtsnagpur.egovmars.in'; // The window.location.href property in JavaScript returns the URL of the currently open web page. This property can even be used to update the URL of a web page.
        var basePath = url.split('${contextRoot}')[0] + '${contextRoot}/';
        var filesPath = "";
        var data = new FormData();

        data.append('idProof1', $("#doc1").get(0).files[0]);
        data.append('idProof2', $("#doc2").get(0).files[0]);
        data.append('idProof3', $("#doc3").get(0).files[0]);
        data.append('idProof4', $("#doc4").get(0).files[0]);
        data.append('idProof5', $("#doc5").get(0).files[0]);
        data.append('idProof6', $("#doc6").get(0).files[0]);
        var isFileSelected = false

        var array_element = "";
        var file = $('input[type="file"]');
        for (var i = 0; i < file.length; i++) {
			var array_element = file[i];
			var element = array_element.value.split("\\");
			var a = element[element.length-1];
			const splitName = a.split(".pdf")[0].replaceAll(/[^a-zA-Z0-9]/g, ""); 
			const value = splitName + ".pdf";
			 if(value==='' && value===undefined){
				filesPath = "";
				isFileSelected = false;
				break;
            } else {
                filesPath = filesPath + basePath + "firecompliancecertificate/" + i + value + ","
                isFileSelected = true;
            }
        }
        $.ajax({
            url: "<c:out value='${contextRoot}'/>/rtsapplication/uploadDocumentFirecomplianceCertificate.do",
            type: 'POST',
            data: data,
            cache: false,
            dataType: 'json',
            processData: false, // Don't process the files
            contentType: false // Set content type to false as jQuery will tell the server its a query string request
        }).done(function (data) {

        });

        var a = filesPath.substring(0, filesPath.lastIndexOf(","));
        filesPath = filesPath.replace(/\s/g, "");
        $("#filesPath").val(filesPath);
        console.log(filesPath);

    }
</script>
