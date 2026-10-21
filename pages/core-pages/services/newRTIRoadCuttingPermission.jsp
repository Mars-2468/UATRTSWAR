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

<script type="text/javascript">
$(document).ready(function(){

$("#submit").click(function(){
   $("form:first").addClass("needs-validation");
   $("form:first").attr("novalidate","");
   const forms = document.querySelectorAll('.needs-validation')
   Array.from(forms).forEach(form => {
     form.addEventListener('submit', event => {
       if (!form.checkValidity()) {
         event.preventDefault()
         event.stopPropagation()
       } else {
         onPageSubmit('<c:out value="${contextRoot}"/>/rtsapplication/saveRoadCuttingPermission.do');
       }
       form.classList.add('was-validated')
     }, false)
   })
});

$('input,select,textarea').on('focusout', function() {
	if (this.checkValidity()) {
		this.classList.remove('is-invalid')
		this.classList.add('is-valid')
	} else {
		this.classList.remove('is-valid')
		this.classList.add('is-invalid')
	}
});

});
</script>
</head>
<body>

	<form class="needs-validation" novalidate>
		<div class="container-fluid mt-2" style="width: 180vh">
			<div class="printable">
				<h3 class="text-center">Application for Grant of Road Cutting Permission</h3>
			</div>

			<h6 style="background-color: #dce2e8; padding: 10px;" class="rounded-2">
				<strong> Application Details </strong>
			</h6>
			<div class="row">
				<input type="hidden" name="_token" value="xyz">

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="applicationType" class="form-label lbleng">Application Type </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="applicationType" name="applicationType" value="">
						<div class="invalid-feedback">Please enter a valid Application Type.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="applicationDate" class="form-label lbleng">Application Date </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="applicationDate" name="applicationDate" value="">
						<div class="invalid-feedback">Please enter a valid Application Date.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="previousPermissionNo" class="form-label lbleng">Previous Permission No </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="previousPermissionNo" name="previousPermissionNo" value="">
						<div class="invalid-feedback">Please enter a valid Previous Permission No.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="previousPermissionValidUpto" class="form-label lbleng">Previous Permission Valid Upto </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="previousPermissionValidUpto" name="previousPermissionValidUpto" value="">
						<div class="invalid-feedback">Please enter a valid Previous Permission Valid Upto.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="applicantName" class="form-label lbleng">Applicant Name <span class="text-danger">*</span></label>
						<input type="text" class="form-control" style="background-image: none;"
							id="applicantName" name="applicantName" value="" required>
						<div class="invalid-feedback">Please enter a valid Applicant Name.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="agencyName" class="form-label lbleng">Agency Name </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="agencyName" name="agencyName" value="">
						<div class="invalid-feedback">Please enter a valid Agency Name.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="applicantCategory" class="form-label lbleng">Applicant Category </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="applicantCategory" name="applicantCategory" value="">
						<div class="invalid-feedback">Please enter a valid Applicant Category.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="mobileNo" class="form-label lbleng">Mobile No <span class="text-danger">*</span></label>
						<input type="text" class="form-control" style="background-image: none;"
							id="mobileNo" name="mobileNo" value="" pattern="^[0-9]{10}$" maxlength="10" required>
						<div class="invalid-feedback">Please enter a valid Mobile No.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="email" class="form-label lbleng">Email </label>
						<input type="email" class="form-control" style="background-image: none;"
							id="email" name="email" value="">
						<div class="invalid-feedback">Please enter a valid Email.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="correspondenceAddress" class="form-label lbleng">Correspondence Address </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="correspondenceAddress" name="correspondenceAddress" value="">
						<div class="invalid-feedback">Please enter a valid Correspondence Address.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="panGstNumber" class="form-label lbleng">Pan Gst Number </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="panGstNumber" name="panGstNumber" value="">
						<div class="invalid-feedback">Please enter a valid Pan Gst Number.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="roadName" class="form-label lbleng">Road Name </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="roadName" name="roadName" value="">
						<div class="invalid-feedback">Please enter a valid Road Name.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="exactLocation" class="form-label lbleng">Exact Location </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="exactLocation" name="exactLocation" value="">
						<div class="invalid-feedback">Please enter a valid Exact Location.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="wardNo" class="form-label lbleng">Ward No </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="wardNo" name="wardNo" value="">
						<div class="invalid-feedback">Please enter a valid Ward No.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="zoneNo" class="form-label lbleng">Zone No </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="zoneNo" name="zoneNo" value="">
						<div class="invalid-feedback">Please enter a valid Zone No.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="roadCategory" class="form-label lbleng">Road Category </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="roadCategory" name="roadCategory" value="">
						<div class="invalid-feedback">Please enter a valid Road Category.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="roadOwningDepartment" class="form-label lbleng">Road Owning Department </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="roadOwningDepartment" name="roadOwningDepartment" value="">
						<div class="invalid-feedback">Please enter a valid Road Owning Department.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="fromLocation" class="form-label lbleng">From Location </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="fromLocation" name="fromLocation" value="">
						<div class="invalid-feedback">Please enter a valid From Location.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="toLocation" class="form-label lbleng">To Location </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="toLocation" name="toLocation" value="">
						<div class="invalid-feedback">Please enter a valid To Location.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="gpsCoordinates" class="form-label lbleng">Gps Coordinates </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="gpsCoordinates" name="gpsCoordinates" value="">
						<div class="invalid-feedback">Please enter a valid Gps Coordinates.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="cuttingPurpose" class="form-label lbleng">Cutting Purpose </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="cuttingPurpose" name="cuttingPurpose" value="">
						<div class="invalid-feedback">Please enter a valid Cutting Purpose.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="workDescription" class="form-label lbleng">Work Description </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="workDescription" name="workDescription" value="">
						<div class="invalid-feedback">Please enter a valid Work Description.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="cuttingLength" class="form-label lbleng">Cutting Length </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="cuttingLength" name="cuttingLength" value="">
						<div class="invalid-feedback">Please enter a valid Cutting Length.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="cuttingWidth" class="form-label lbleng">Cutting Width </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="cuttingWidth" name="cuttingWidth" value="">
						<div class="invalid-feedback">Please enter a valid Cutting Width.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="cuttingTotalArea" class="form-label lbleng">Cutting Total Area </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="cuttingTotalArea" name="cuttingTotalArea" value="">
						<div class="invalid-feedback">Please enter a valid Cutting Total Area.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="workStartDate" class="form-label lbleng">Work Start Date </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="workStartDate" name="workStartDate" value="">
						<div class="invalid-feedback">Please enter a valid Work Start Date.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="workCompletionDate" class="form-label lbleng">Work Completion Date </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="workCompletionDate" name="workCompletionDate" value="">
						<div class="invalid-feedback">Please enter a valid Work Completion Date.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="restorationResponsibility" class="form-label lbleng">Restoration Responsibility </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="restorationResponsibility" name="restorationResponsibility" value="">
						<div class="invalid-feedback">Please enter a valid Restoration Responsibility.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="executingContractor" class="form-label lbleng">Executing Contractor </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="executingContractor" name="executingContractor" value="">
						<div class="invalid-feedback">Please enter a valid Executing Contractor.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="trafficDiversionRequired" class="form-label lbleng">Traffic Diversion Required </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="trafficDiversionRequired" name="trafficDiversionRequired" value="">
						<div class="invalid-feedback">Please enter a valid Traffic Diversion Required.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="identityProof" class="form-label lbleng">Identity Proof </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="identityProof" name="identityProof" value="">
						<div class="invalid-feedback">Please enter a valid Identity Proof.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="authorizationLetter" class="form-label lbleng">Authorization Letter </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="authorizationLetter" name="authorizationLetter" value="">
						<div class="invalid-feedback">Please enter a valid Authorization Letter.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="workOrder" class="form-label lbleng">Work Order </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="workOrder" name="workOrder" value="">
						<div class="invalid-feedback">Please enter a valid Work Order.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="locationMap" class="form-label lbleng">Location Map </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="locationMap" name="locationMap" value="">
						<div class="invalid-feedback">Please enter a valid Location Map.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="cuttingLayout" class="form-label lbleng">Cutting Layout </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="cuttingLayout" name="cuttingLayout" value="">
						<div class="invalid-feedback">Please enter a valid Cutting Layout.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="utilityPlan" class="form-label lbleng">Utility Plan </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="utilityPlan" name="utilityPlan" value="">
						<div class="invalid-feedback">Please enter a valid Utility Plan.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="methodStatement" class="form-label lbleng">Method Statement </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="methodStatement" name="methodStatement" value="">
						<div class="invalid-feedback">Please enter a valid Method Statement.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="trafficDiversionPlan" class="form-label lbleng">Traffic Diversion Plan </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="trafficDiversionPlan" name="trafficDiversionPlan" value="">
						<div class="invalid-feedback">Please enter a valid Traffic Diversion Plan.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="previousPermissionCopy" class="form-label lbleng">Previous Permission Copy </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="previousPermissionCopy" name="previousPermissionCopy" value="">
						<div class="invalid-feedback">Please enter a valid Previous Permission Copy.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="previousFeeReceipt" class="form-label lbleng">Previous Fee Receipt </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="previousFeeReceipt" name="previousFeeReceipt" value="">
						<div class="invalid-feedback">Please enter a valid Previous Fee Receipt.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="restorationPlan" class="form-label lbleng">Restoration Plan </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="restorationPlan" name="restorationPlan" value="">
						<div class="invalid-feedback">Please enter a valid Restoration Plan.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="otherDocument" class="form-label lbleng">Other Document </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="otherDocument" name="otherDocument" value="">
						<div class="invalid-feedback">Please enter a valid Other Document.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="applicationFee" class="form-label lbleng">Application Fee </label>
						<input type="number" class="form-control" style="background-image: none;"
							id="applicationFee" name="applicationFee" value="" step="0.01" min="0">
						<div class="invalid-feedback">Please enter a valid Application Fee.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="roadCuttingCharges" class="form-label lbleng">Road Cutting Charges </label>
						<input type="number" class="form-control" style="background-image: none;"
							id="roadCuttingCharges" name="roadCuttingCharges" value="" step="0.01" min="0">
						<div class="invalid-feedback">Please enter a valid Road Cutting Charges.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="restorationCharges" class="form-label lbleng">Restoration Charges </label>
						<input type="number" class="form-control" style="background-image: none;"
							id="restorationCharges" name="restorationCharges" value="" step="0.01" min="0">
						<div class="invalid-feedback">Please enter a valid Restoration Charges.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="securityDeposit" class="form-label lbleng">Security Deposit </label>
						<input type="number" class="form-control" style="background-image: none;"
							id="securityDeposit" name="securityDeposit" value="" step="0.01" min="0">
						<div class="invalid-feedback">Please enter a valid Security Deposit.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="otherCharges" class="form-label lbleng">Other Charges </label>
						<input type="number" class="form-control" style="background-image: none;"
							id="otherCharges" name="otherCharges" value="" step="0.01" min="0">
						<div class="invalid-feedback">Please enter a valid Other Charges.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="totalAmountPayable" class="form-label lbleng">Total Amount Payable </label>
						<input type="number" class="form-control" style="background-image: none;"
							id="totalAmountPayable" name="totalAmountPayable" value="" step="0.01" min="0">
						<div class="invalid-feedback">Please enter a valid Total Amount Payable.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="declaration" class="form-label lbleng">Declaration </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="declaration" name="declaration" value="">
						<div class="invalid-feedback">Please enter a valid Declaration.</div>
					</div>
				</div>

			</div>

			<div class="col-md-12 text-center mb-3 mt-4">
				<button class="btn btn-primary btn_sm" type="submit" id="submit">
					Submit Application
				</button>
			</div>
		</div>
	</form>

</body>
