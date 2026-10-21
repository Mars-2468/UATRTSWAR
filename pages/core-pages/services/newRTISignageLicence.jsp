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
         onPageSubmit('<c:out value="${contextRoot}"/>/rtsapplication/saveSignageLicence.do');
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
				<h3 class="text-center">Application for Issuance / Renewal of Signage Licence</h3>
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
						<label for="existingLicenceNo" class="form-label lbleng">Existing Licence No </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="existingLicenceNo" name="existingLicenceNo" value="">
						<div class="invalid-feedback">Please enter a valid Existing Licence No.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="existingLicenceExpiryDate" class="form-label lbleng">Existing Licence Expiry Date </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="existingLicenceExpiryDate" name="existingLicenceExpiryDate" value="">
						<div class="invalid-feedback">Please enter a valid Existing Licence Expiry Date.</div>
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
						<label for="firmName" class="form-label lbleng">Firm Name </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="firmName" name="firmName" value="">
						<div class="invalid-feedback">Please enter a valid Firm Name.</div>
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
						<label for="panNumber" class="form-label lbleng">Pan Number </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="panNumber" name="panNumber" value="">
						<div class="invalid-feedback">Please enter a valid Pan Number.</div>
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
						<label for="signageBuildingName" class="form-label lbleng">Signage Building Name </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="signageBuildingName" name="signageBuildingName" value="">
						<div class="invalid-feedback">Please enter a valid Signage Building Name.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="signageAddress" class="form-label lbleng">Signage Address </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="signageAddress" name="signageAddress" value="">
						<div class="invalid-feedback">Please enter a valid Signage Address.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="signageZoneWard" class="form-label lbleng">Signage Zone Ward </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="signageZoneWard" name="signageZoneWard" value="">
						<div class="invalid-feedback">Please enter a valid Signage Zone Ward.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="propertyOwnerName" class="form-label lbleng">Property Owner Name </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="propertyOwnerName" name="propertyOwnerName" value="">
						<div class="invalid-feedback">Please enter a valid Property Owner Name.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="signageType" class="form-label lbleng">Signage Type </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="signageType" name="signageType" value="">
						<div class="invalid-feedback">Please enter a valid Signage Type.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="signagePurpose" class="form-label lbleng">Signage Purpose </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="signagePurpose" name="signagePurpose" value="">
						<div class="invalid-feedback">Please enter a valid Signage Purpose.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="signageContent" class="form-label lbleng">Signage Content </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="signageContent" name="signageContent" value="">
						<div class="invalid-feedback">Please enter a valid Signage Content.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="signageLength" class="form-label lbleng">Signage Length </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="signageLength" name="signageLength" value="">
						<div class="invalid-feedback">Please enter a valid Signage Length.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="signageWidth" class="form-label lbleng">Signage Width </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="signageWidth" name="signageWidth" value="">
						<div class="invalid-feedback">Please enter a valid Signage Width.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="signageTotalArea" class="form-label lbleng">Signage Total Area </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="signageTotalArea" name="signageTotalArea" value="">
						<div class="invalid-feedback">Please enter a valid Signage Total Area.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="numberOfBoards" class="form-label lbleng">Number Of Boards </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="numberOfBoards" name="numberOfBoards" value="">
						<div class="invalid-feedback">Please enter a valid Number Of Boards.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="installationLocation" class="form-label lbleng">Installation Location </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="installationLocation" name="installationLocation" value="">
						<div class="invalid-feedback">Please enter a valid Installation Location.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="proposedInstallationDate" class="form-label lbleng">Proposed Installation Date </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="proposedInstallationDate" name="proposedInstallationDate" value="">
						<div class="invalid-feedback">Please enter a valid Proposed Installation Date.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="licenceValidityRequested" class="form-label lbleng">Licence Validity Requested </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="licenceValidityRequested" name="licenceValidityRequested" value="">
						<div class="invalid-feedback">Please enter a valid Licence Validity Requested.</div>
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
						<label for="locationPhotograph" class="form-label lbleng">Location Photograph </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="locationPhotograph" name="locationPhotograph" value="">
						<div class="invalid-feedback">Please enter a valid Location Photograph.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="signageDesign" class="form-label lbleng">Signage Design </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="signageDesign" name="signageDesign" value="">
						<div class="invalid-feedback">Please enter a valid Signage Design.</div>
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
						<label for="ownerNoc" class="form-label lbleng">Owner Noc </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="ownerNoc" name="ownerNoc" value="">
						<div class="invalid-feedback">Please enter a valid Owner Noc.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="structuralCertificate" class="form-label lbleng">Structural Certificate </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="structuralCertificate" name="structuralCertificate" value="">
						<div class="invalid-feedback">Please enter a valid Structural Certificate.</div>
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
						<label for="previousFeeReceipt" class="form-label lbleng">Previous Fee Receipt </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="previousFeeReceipt" name="previousFeeReceipt" value="">
						<div class="invalid-feedback">Please enter a valid Previous Fee Receipt.</div>
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
						<label for="licenceFee" class="form-label lbleng">Licence Fee </label>
						<input type="number" class="form-control" style="background-image: none;"
							id="licenceFee" name="licenceFee" value="" step="0.01" min="0">
						<div class="invalid-feedback">Please enter a valid Licence Fee.</div>
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
						<label for="totalAmountPaid" class="form-label lbleng">Total Amount Paid </label>
						<input type="number" class="form-control" style="background-image: none;"
							id="totalAmountPaid" name="totalAmountPaid" value="" step="0.01" min="0">
						<div class="invalid-feedback">Please enter a valid Total Amount Paid.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="paymentTransactionNo" class="form-label lbleng">Payment Transaction No </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="paymentTransactionNo" name="paymentTransactionNo" value="">
						<div class="invalid-feedback">Please enter a valid Payment Transaction No.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="paymentDate" class="form-label lbleng">Payment Date </label>
						<input type="text" class="form-control" style="background-image: none;"
							id="paymentDate" name="paymentDate" value="">
						<div class="invalid-feedback">Please enter a valid Payment Date.</div>
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
