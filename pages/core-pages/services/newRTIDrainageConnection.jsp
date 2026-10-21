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
         onPageSubmit('<c:out value="${contextRoot}"/>/rtsapplication/saveDrainageConnection.do');
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
				<h3 class="text-center">Application for Grant of Drainage / Sewerage Connection</h3>
			</div>

			<h6 style="background-color: #dce2e8; padding: 10px;" class="rounded-2">
				<strong> Application Details </strong>
			</h6>
			<div class="row">
				<input type="hidden" name="_token" value="xyz">

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
						<label for="fatherHusbandName" class="form-label lbleng">Father Husband Name </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="fatherHusbandName" name="fatherHusbandName" value="">
						<div class="invalid-feedback">Please enter a valid Father Husband Name.</div>
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
						<label for="propertyNo" class="form-label lbleng">Property No </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="propertyNo" name="propertyNo" value="">
						<div class="invalid-feedback">Please enter a valid Property No.</div>
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
						<label for="wardNo" class="form-label lbleng">Ward No </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="wardNo" name="wardNo" value="">
						<div class="invalid-feedback">Please enter a valid Ward No.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="propertyAddress" class="form-label lbleng">Property Address </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="propertyAddress" name="propertyAddress" value="">
						<div class="invalid-feedback">Please enter a valid Property Address.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="propertyType" class="form-label lbleng">Property Type </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="propertyType" name="propertyType" value="">
						<div class="invalid-feedback">Please enter a valid Property Type.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="occupancyStatus" class="form-label lbleng">Occupancy Status </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="occupancyStatus" name="occupancyStatus" value="">
						<div class="invalid-feedback">Please enter a valid Occupancy Status.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="propertyTaxNo" class="form-label lbleng">Property Tax No </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="propertyTaxNo" name="propertyTaxNo" value="">
						<div class="invalid-feedback">Please enter a valid Property Tax No.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="requestType" class="form-label lbleng">Request Type </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="requestType" name="requestType" value="">
						<div class="invalid-feedback">Please enter a valid Request Type.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="sewerLineAvailable" class="form-label lbleng">Sewer Line Available </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="sewerLineAvailable" name="sewerLineAvailable" value="">
						<div class="invalid-feedback">Please enter a valid Sewer Line Available.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="connectionUse" class="form-label lbleng">Connection Use </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="connectionUse" name="connectionUse" value="">
						<div class="invalid-feedback">Please enter a valid Connection Use.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="numberOfFloors" class="form-label lbleng">Number Of Floors </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="numberOfFloors" name="numberOfFloors" value="">
						<div class="invalid-feedback">Please enter a valid Number Of Floors.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="approxOccupants" class="form-label lbleng">Approx Occupants </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="approxOccupants" name="approxOccupants" value="">
						<div class="invalid-feedback">Please enter a valid Approx Occupants.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="contractorName" class="form-label lbleng">Contractor Name </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="contractorName" name="contractorName" value="">
						<div class="invalid-feedback">Please enter a valid Contractor Name.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="contractorContact" class="form-label lbleng">Contractor Contact </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="contractorContact" name="contractorContact" value="">
						<div class="invalid-feedback">Please enter a valid Contractor Contact.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="otherDetails" class="form-label lbleng">Other Details </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="otherDetails" name="otherDetails" value="">
						<div class="invalid-feedback">Please enter a valid Other Details.</div>
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
						<label for="ownershipProof" class="form-label lbleng">Ownership Proof </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="ownershipProof" name="ownershipProof" value="">
						<div class="invalid-feedback">Please enter a valid Ownership Proof.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="propertyTaxReceipt" class="form-label lbleng">Property Tax Receipt </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="propertyTaxReceipt" name="propertyTaxReceipt" value="">
						<div class="invalid-feedback">Please enter a valid Property Tax Receipt.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="buildingPermission" class="form-label lbleng">Building Permission </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="buildingPermission" name="buildingPermission" value="">
						<div class="invalid-feedback">Please enter a valid Building Permission.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="sitePlan" class="form-label lbleng">Site Plan </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="sitePlan" name="sitePlan" value="">
						<div class="invalid-feedback">Please enter a valid Site Plan.</div>
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
						<label for="otherDocument" class="form-label lbleng">Other Document </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="otherDocument" name="otherDocument" value="">
						<div class="invalid-feedback">Please enter a valid Other Document.</div>
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
