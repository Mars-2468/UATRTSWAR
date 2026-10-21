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
         onPageSubmit('<c:out value="${contextRoot}"/>/rtsapplication/saveLodgingLicence.do');
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
				<h3 class="text-center">Application for Issue of Lodging Licence</h3>
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
						<label for="applicantAddress" class="form-label lbleng">Applicant Address </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="applicantAddress" name="applicantAddress" value="">
						<div class="invalid-feedback">Please enter a valid Applicant Address.</div>
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
						<label for="aadhaarNo" class="form-label lbleng">Aadhaar No </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="aadhaarNo" name="aadhaarNo" value="" pattern="^[0-9]{12}$" maxlength="12">
						<div class="invalid-feedback">Please enter a valid Aadhaar No.</div>
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
						<label for="businessAddress" class="form-label lbleng">Business Address </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="businessAddress" name="businessAddress" value="">
						<div class="invalid-feedback">Please enter a valid Business Address.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="businessType" class="form-label lbleng">Business Type </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="businessType" name="businessType" value="">
						<div class="invalid-feedback">Please enter a valid Business Type.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="natureOfActivity" class="form-label lbleng">Nature Of Activity </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="natureOfActivity" name="natureOfActivity" value="">
						<div class="invalid-feedback">Please enter a valid Nature Of Activity.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="operatingLocation" class="form-label lbleng">Operating Location </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="operatingLocation" name="operatingLocation" value="">
						<div class="invalid-feedback">Please enter a valid Operating Location.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="licenceType" class="form-label lbleng">Licence Type </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="licenceType" name="licenceType" value="">
						<div class="invalid-feedback">Please enter a valid Licence Type.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="previousLicenceNo" class="form-label lbleng">Previous Licence No </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="previousLicenceNo" name="previousLicenceNo" value="">
						<div class="invalid-feedback">Please enter a valid Previous Licence No.</div>
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
						<label for="businessProof" class="form-label lbleng">Business Proof </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="businessProof" name="businessProof" value="">
						<div class="invalid-feedback">Please enter a valid Business Proof.</div>
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
						<label for="previousLicenceCopy" class="form-label lbleng">Previous Licence Copy </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="previousLicenceCopy" name="previousLicenceCopy" value="">
						<div class="invalid-feedback">Please enter a valid Previous Licence Copy.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="applicantPhotograph" class="form-label lbleng">Applicant Photograph </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="applicantPhotograph" name="applicantPhotograph" value="">
						<div class="invalid-feedback">Please enter a valid Applicant Photograph.</div>
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
