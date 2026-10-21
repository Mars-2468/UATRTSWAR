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
         onPageSubmit('<c:out value="${contextRoot}"/>/rtsapplication/saveHawkerRegistration.do');
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
				<h3 class="text-center">Application for Issuance of Hawker Registration Certificate</h3>
			</div>

			<h6 style="background-color: #dce2e8; padding: 10px;" class="rounded-2">
				<strong> Application Details </strong>
			</h6>
			<div class="row">
				<input type="hidden" name="_token" value="xyz">

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
						<label for="dateOfBirth" class="form-label lbleng">Date Of Birth </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="dateOfBirth" name="dateOfBirth" value="">
						<div class="invalid-feedback">Please enter a valid Date Of Birth.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="gender" class="form-label lbleng">Gender </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="gender" name="gender" value="">
						<div class="invalid-feedback">Please enter a valid Gender.</div>
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
						<label for="alternateContactNo" class="form-label lbleng">Alternate Contact No </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="alternateContactNo" name="alternateContactNo" value="" pattern="^[0-9]{10}$" maxlength="10">
						<div class="invalid-feedback">Please enter a valid Alternate Contact No.</div>
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
						<label for="houseFlatNo" class="form-label lbleng">House Flat No </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="houseFlatNo" name="houseFlatNo" value="">
						<div class="invalid-feedback">Please enter a valid House Flat No.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="streetArea" class="form-label lbleng">Street Area </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="streetArea" name="streetArea" value="">
						<div class="invalid-feedback">Please enter a valid Street Area.</div>
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
						<label for="city" class="form-label lbleng">City </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="city" name="city" value="">
						<div class="invalid-feedback">Please enter a valid City.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="pinCode" class="form-label lbleng">Pin Code </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="pinCode" name="pinCode" value="" pattern="^[0-9]{6}$" maxlength="6">
						<div class="invalid-feedback">Please enter a valid Pin Code.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="hawkingBusinessType" class="form-label lbleng">Hawking Business Type </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="hawkingBusinessType" name="hawkingBusinessType" value="">
						<div class="invalid-feedback">Please enter a valid Hawking Business Type.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="businessName" class="form-label lbleng">Business Name </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="businessName" name="businessName" value="">
						<div class="invalid-feedback">Please enter a valid Business Name.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="goodsCategory" class="form-label lbleng">Goods Category </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="goodsCategory" name="goodsCategory" value="">
						<div class="invalid-feedback">Please enter a valid Goods Category.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="hawkingActivityType" class="form-label lbleng">Hawking Activity Type </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="hawkingActivityType" name="hawkingActivityType" value="">
						<div class="invalid-feedback">Please enter a valid Hawking Activity Type.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="hawkingLocation" class="form-label lbleng">Hawking Location </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="hawkingLocation" name="hawkingLocation" value="">
						<div class="invalid-feedback">Please enter a valid Hawking Location.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="hawkingZoneWard" class="form-label lbleng">Hawking Zone Ward </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="hawkingZoneWard" name="hawkingZoneWard" value="">
						<div class="invalid-feedback">Please enter a valid Hawking Zone Ward.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="natureOfBusiness" class="form-label lbleng">Nature Of Business </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="natureOfBusiness" name="natureOfBusiness" value="">
						<div class="invalid-feedback">Please enter a valid Nature Of Business.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="workingDaysTimings" class="form-label lbleng">Working Days Timings </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="workingDaysTimings" name="workingDaysTimings" value="">
						<div class="invalid-feedback">Please enter a valid Working Days Timings.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="cartStallVehicleDetails" class="form-label lbleng">Cart Stall Vehicle Details </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="cartStallVehicleDetails" name="cartStallVehicleDetails" value="">
						<div class="invalid-feedback">Please enter a valid Cart Stall Vehicle Details.</div>
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
						<label for="addressProof" class="form-label lbleng">Address Proof </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="addressProof" name="addressProof" value="">
						<div class="invalid-feedback">Please enter a valid Address Proof.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="photograph" class="form-label lbleng">Photograph </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="photograph" name="photograph" value="">
						<div class="invalid-feedback">Please enter a valid Photograph.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="existingHawkerCertificate" class="form-label lbleng">Existing Hawker Certificate </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="existingHawkerCertificate" name="existingHawkerCertificate" value="">
						<div class="invalid-feedback">Please enter a valid Existing Hawker Certificate.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="hawkingActivityProof" class="form-label lbleng">Hawking Activity Proof </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="hawkingActivityProof" name="hawkingActivityProof" value="">
						<div class="invalid-feedback">Please enter a valid Hawking Activity Proof.</div>
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
