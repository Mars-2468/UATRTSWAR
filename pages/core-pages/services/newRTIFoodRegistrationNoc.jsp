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
         onPageSubmit('<c:out value="${contextRoot}"/>/rtsapplication/saveFoodRegistrationNoc.do');
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
				<h3 class="text-center">Application for Health NOC for Food Registration Certificate</h3>
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
						<label for="applicantType" class="form-label lbleng">Applicant Type </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="applicantType" name="applicantType" value="">
						<div class="invalid-feedback">Please enter a valid Applicant Type.</div>
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
						<label for="businessName" class="form-label lbleng">Business Name </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="businessName" name="businessName" value="">
						<div class="invalid-feedback">Please enter a valid Business Name.</div>
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
						<label for="businessAddress" class="form-label lbleng">Business Address </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="businessAddress" name="businessAddress" value="">
						<div class="invalid-feedback">Please enter a valid Business Address.</div>
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
						<label for="premisesOwnership" class="form-label lbleng">Premises Ownership </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="premisesOwnership" name="premisesOwnership" value="">
						<div class="invalid-feedback">Please enter a valid Premises Ownership.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="businessArea" class="form-label lbleng">Business Area </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="businessArea" name="businessArea" value="">
						<div class="invalid-feedback">Please enter a valid Business Area.</div>
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
						<label for="registrationType" class="form-label lbleng">Registration Type </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="registrationType" name="registrationType" value="">
						<div class="invalid-feedback">Please enter a valid Registration Type.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="foodRegistrationNo" class="form-label lbleng">Food Registration No </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="foodRegistrationNo" name="foodRegistrationNo" value="">
						<div class="invalid-feedback">Please enter a valid Food Registration No.</div>
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
						<label for="rentAgreement" class="form-label lbleng">Rent Agreement </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="rentAgreement" name="rentAgreement" value="">
						<div class="invalid-feedback">Please enter a valid Rent Agreement.</div>
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
						<label for="registrationAcknowledgement" class="form-label lbleng">Registration Acknowledgement </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="registrationAcknowledgement" name="registrationAcknowledgement" value="">
						<div class="invalid-feedback">Please enter a valid Registration Acknowledgement.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="businessRegistrationProof" class="form-label lbleng">Business Registration Proof </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="businessRegistrationProof" name="businessRegistrationProof" value="">
						<div class="invalid-feedback">Please enter a valid Business Registration Proof.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="waterSanitationProof" class="form-label lbleng">Water Sanitation Proof </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="waterSanitationProof" name="waterSanitationProof" value="">
						<div class="invalid-feedback">Please enter a valid Water Sanitation Proof.</div>
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
