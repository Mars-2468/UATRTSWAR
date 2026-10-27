<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.include
	file="/pages/core-pages/nmc_user/dashboard/header.jsp" />
<jsp:directive.page import="com.mars.common.utils.Constants" />
<jsp:directive.page import="com.mars.common.utils.CommonUtils" />
<jsp:directive.page import="com.mars.rti.utils.CoreConstants" />

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
<script type="text/javascript"
	src="<c:out value='${contextRoot}'/>/scripts/jquery/jquery.ajaxfileupload.js"></script>

<%
pageContext.setAttribute("UPLOAD_PATH", CoreConstants.UPLOAD_PATH);
%>

<script type="text/javascript">
$(document).ready(function(){
var isUploadInProgress = false;

$("#submit").click(function(){
   $("form:first").addClass("needs-validation");
   $("form:first").attr("novalidate","");
   const forms = document.querySelectorAll('.needs-validation')
   Array.from(forms).forEach(form => {
     form.addEventListener('submit', event => {
       var isFileValid = true;
       form.querySelectorAll('input[type="file"]').forEach(fileInput => {
         if (fileInput.files.length > 0) {
           var fname = fileInput.files[0].name;
           if (!fname.toLowerCase().endsWith('.pdf') || fileInput.files[0].size >= 2000000) {
             isFileValid = false;
             fileInput.classList.remove('is-valid');
             fileInput.classList.add('is-invalid');
           } else {
             fileInput.classList.remove('is-invalid');
             fileInput.classList.add('is-valid');
           }
         }
       });
       var isOrderValid = (typeof window.rtsCheckOrder === 'function') ? window.rtsCheckOrder() : true;
       if (!form.checkValidity() || !isFileValid || !isOrderValid) {
         event.preventDefault()
         event.stopPropagation()
       } else {
         if (isUploadInProgress) { return false; }
         isUploadInProgress = true;
         uploadDocuments(function (status) {
           if (status === true || status === 'true') {
             $("#submit").attr("disabled", true);
             onPageSubmit('<c:out value="${contextRoot}"/>/rtsapplication/saveSignageLicence.do');
           }
           isUploadInProgress = false;
         });
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
<style id="rts-form-styles">
	/* ---- form shell: cards per section, three fields to a row ---- */
	.rts-form { max-width: 1280px; margin: 0 auto; padding: 0 16px 32px; }
	.rts-title { font-size: 22px; font-weight: 600; color: #0f3d3e; text-align: center;
		margin: 18px 0 22px; line-height: 1.35; }
	.rts-card { background: #f7fbfc; border: 1px solid #dbe7ea; border-radius: 10px;
		padding: 0 18px 6px; margin-bottom: 18px; }
	.rts-card > .rts-card-head { display: flex; align-items: center; gap: 10px;
		padding: 14px 0 10px; border-bottom: 1px solid #dbe7ea; margin-bottom: 6px; }
	.rts-step { display: inline-flex; align-items: center; justify-content: center;
		width: 24px; height: 24px; border-radius: 5px; background: #0f6c70; color: #fff;
		font-size: 13px; font-weight: 600; flex: 0 0 24px; }
	.rts-card-head h6 { margin: 0; font-size: 15px; font-weight: 600; color: #15393a; }
	.fld { margin: 12px 0; }
	.fld-label { font-size: 13px; font-weight: 500; color: #3c4b4c; margin-bottom: 4px; }
	.fld-label .req { color: #d32f2f; margin-left: 2px; }
	.fld-label .mr { color: #6b7b7c; font-weight: 400; }
	.hint { font-size: 12px; color: #7a8a8b; margin-top: 3px; }
	.rts-form .form-control, .rts-form .form-select { background-image: none; font-size: 14px;
		border-color: #cdd9db; }
	.rts-form .form-control:focus, .rts-form .form-select:focus {
		border-color: #0f6c70; box-shadow: 0 0 0 .18rem rgba(15,108,112,.15); }
	.rts-form textarea.form-control { min-height: 62px; }
	.choice-set { display: flex; flex-wrap: wrap; gap: 4px 18px; padding-top: 2px; }
	.choice-set .form-check { margin-right: 0; }
	.choice-set .form-check-label { font-size: 14px; }
	.rts-declaration { background: #fff; border: 1px solid #dbe7ea; border-radius: 10px;
		padding: 14px 18px; margin-bottom: 18px; }
	.rts-declaration .form-check-label { font-size: 13px; color: #3c4b4c; }
	.rts-actions { display: flex; justify-content: center; gap: 12px; padding: 6px 0 10px; }
	.rts-actions .btn { min-width: 170px; }
	/* keep the invalid message visible for a choice group */
	.was-validated .choice-set .form-check-input:invalid ~ .invalid-feedback { display: block; }
	@media (max-width: 575px) { .rts-actions .btn { min-width: 0; width: 100%; } }

	/* ---- print: the filled form on paper, nothing else ---- */
	.rts-print-head { display: none; }
	@media print {
		@page { size: A4 portrait; margin: 12mm 10mm; }
		body { background: #fff !important; }
		header, .header, nav, .navbar, footer, .footer, .breadcrumb,
		#myModal, .modal, .modal-backdrop, .rts-actions, .hint,
		.invalid-feedback, .alert { display: none !important; }
		.rts-print-head { display: block; text-align: center; margin-bottom: 10px; }
		.rts-print-head .nmc { font-size: 15px; font-weight: 700; color: #000; }
		.rts-print-head .dept { font-size: 12px; color: #000; }
		.rts-print-head hr { margin: 6px 0; border-top: 1px solid #000; }
		.rts-form { max-width: none; padding: 0; }
		.rts-title { font-size: 14px; margin: 6px 0 10px; color: #000; }
		.rts-card { background: #fff; border: 1px solid #000; border-radius: 0;
			padding: 0 8px 4px; margin-bottom: 8px; break-inside: avoid; }
		.rts-card-head { padding: 6px 0 4px; border-bottom: 1px solid #000; }
		.rts-step { background: #000 !important; -webkit-print-color-adjust: exact;
			print-color-adjust: exact; width: 18px; height: 18px; font-size: 11px; }
		.rts-card-head h6 { font-size: 12px; }
		.fld { margin: 5px 0; break-inside: avoid; }
		.fld-label { font-size: 10px; color: #000; margin-bottom: 1px; }
		/* show what was entered as text on a ruled line, not as an empty input box */
		.rts-form .form-control, .rts-form .form-select {
			border: 0; border-bottom: 1px solid #000; border-radius: 0; padding: 0 2px;
			font-size: 11px; color: #000; background: #fff !important; min-height: 0;
			height: auto; -webkit-appearance: none; appearance: none; }
		.rts-form textarea.form-control { min-height: 0; }
		.rts-declaration { border: 1px solid #000; border-radius: 0; padding: 6px 8px;
			break-inside: avoid; }
		.rts-declaration .form-check-label { font-size: 10px; color: #000; }
		.rts-sign { display: block !important; margin-top: 18px; font-size: 11px;
			display: flex; justify-content: space-between; }
	}
	.rts-sign { display: none; }
</style>
</head>
<body>


<script>
$(window).on('load', function () {
	$('#myModal').modal('show');
	$('#myModal .modal-footer .btn').on('click', function (e) {
		$('#myModal').modal('hide');
	});
})
</script>
<div id="myModal" class="modal fade">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h6>
					<strong>Note(&#2344;&#2379;&#2306;&#2342;): </strong> Upload below files in .pdf...Max upto 2 MB
					(&#2326;&#2366;&#2354;&#2368;&#2354; &#2347;&#2366;&#2311;&#2354; .pdf &#2350;&#2343;&#2381;&#2351;&#2375; &#2309;&#2346;&#2354;&#2379;&#2337; &#2325;&#2352;&#2366;..&#2325;&#2350;&#2366;&#2354; &#2408; MB &#2346;&#2352;&#2381;&#2351;&#2306;&#2340;)
				</h6>
			</div>
			<div class="modal-body" style="color: green">
				<p style="color: red">
					<strong>List of document to be attached :</strong>
				</p>
				<ul style="color: rgb(3, 125, 76)">
					<li>1. Applicant's Identity Proof <span class="text-danger" style="color: red;">*</span></li>
					<li>2. Applicant's Address Proof <span class="text-danger" style="color: red;">*</span></li>
					<li>3. Photograph of Proposed Signage Location <span class="text-danger" style="color: red;">*</span></li>
					<li>4. Signage Design / Layout <span class="text-danger" style="color: red;">*</span></li>
					<li>5. Property Ownership Proof / Rent Agreement</li>
					<li>6. Property Owner's NOC (if applicable)</li>
					<li>7. Structural Stability Certificate (if applicable)</li>
					<li>8. Previous Signage Licence Copy (for renewal)</li>
					<li>9. Previous Licence Fee Receipt (for renewal)</li>
					<li>10. Other Required Document</li>
				</ul>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary">Ok</button>
			</div>
		</div>
	</div>
</div>

	<form class="needs-validation" novalidate>
		<div class="rts-form">
			<div class="rts-print-head">
				<div class="nmc">NAGPUR MUNICIPAL CORPORATION</div>
				<div class="nmc">&#2344;&#2366;&#2327;&#2346;&#2370;&#2352; &#2350;&#2361;&#2366;&#2344;&#2327;&#2352;&#2346;&#2366;&#2354;&#2367;&#2325;&#2366;</div>
				<div class="dept">Right to Services (RTS) &nbsp;|&nbsp; Aaple Sarkar</div>
				<hr>
			</div>
			<div class="printable">
				<h3 class="rts-title">Application for Issuance / Renewal of Signage Licence</h3>
			</div>

			<div class="rts-card">
				<div class="rts-card-head">
					<span class="rts-step">1</span>
					<h6>Application Details</h6>
				</div>
				<div class="row">
					<input type="hidden" name="_token" value="xyz">
					<input type="hidden" name="str" value="<c:out value='${str}'/>">
					<input type="hidden" name="serviceId" value="<c:out value='${serviceId}'/>">
					<input type="hidden" name="fields" value="<c:out value='${fields_aps}'/>">
					<input type="hidden" name="distric" value="<c:out value='${distric}'/>">
					<input type="hidden" name="trackid" value="<c:out value='${trackid}'/>">
					<input type="hidden" name="user" value="<c:out value='${user}'/>">
					<input type="hidden" name="mobile" value="<c:out value='${mobile}'/>">
					<input type="hidden" name="name" value="<c:out value='${name}'/>">

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="applicationType" class="form-label fld-label">Application Type <span class="req">*</span></label>
						<select class="form-select" id="applicationType" name="applicationType" required>
							<option value="" selected="">Select</option>
							<option value="New License / Issuance">New License / Issuance</option>
							<option value="Renewal">Renewal</option>
						</select>
						<div class="invalid-feedback">Please select application type.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="applicationDate" class="form-label fld-label">Application Date <span class="req">*</span></label>
						<input type="date" class="form-control" id="applicationDate" name="applicationDate" value=""
							 max="<c:out value='${today}'/>" required>
						<div class="invalid-feedback">Enter a valid date. A future date is not accepted here.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="existingLicenceNo" class="form-label fld-label">Existing License Number (for renewal)</label>
						<input type="text" class="form-control" id="existingLicenceNo" name="existingLicenceNo" value=""
							placeholder="Enter existing license number (for renewal)" pattern="^[A-Za-z0-9][A-Za-z0-9/\-]{0,49}$" maxlength="50">
						<div class="invalid-feedback">Use letters, digits, / and - only.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="existingLicenceExpiryDate" class="form-label fld-label">Existing License Expiry Date (for renewal)</label>
						<input type="date" class="form-control" id="existingLicenceExpiryDate" name="existingLicenceExpiryDate" value=""
							>
						<div class="invalid-feedback">Enter a valid date.</div>
					</div>
				</div>

				</div>
			</div>

			<div class="rts-card">
				<div class="rts-card-head">
					<span class="rts-step">2</span>
					<h6>Applicant Details</h6>
				</div>
				<div class="row">
				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="applicantName" class="form-label fld-label">Full Name of Applicant / Business Owner <span class="req">*</span></label>
						<input type="text" class="form-control" id="applicantName" name="applicantName" value=""
							placeholder="Enter full name of applicant / business owner" pattern="^[A-Za-z\u0900-\u097F][A-Za-z\u0900-\u097F .'\-]{1,99}$" maxlength="100" required>
						<div class="invalid-feedback">Enter a valid name using letters only, at least 2 characters.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="firmName" class="form-label fld-label">Name of Firm / Company (if applicable)</label>
						<input type="text" class="form-control" id="firmName" name="firmName" value=""
							placeholder="Enter name of firm / company (if applicable)" pattern="^(?=.*[A-Za-z0-9\u0900-\u097F]).{2,150}$" maxlength="150">
						<div class="invalid-feedback">Enter at least 2 characters.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="fatherHusbandName" class="form-label fld-label">Father's / Husband's Name</label>
						<input type="text" class="form-control" id="fatherHusbandName" name="fatherHusbandName" value=""
							placeholder="Enter father's / husband's name" pattern="^[A-Za-z\u0900-\u097F][A-Za-z\u0900-\u097F .'\-]{1,99}$" maxlength="100">
						<div class="invalid-feedback">Enter a valid name using letters only, at least 2 characters.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="mobileNo" class="form-label fld-label">Mobile Number <span class="req">*</span></label>
						<input type="text" class="form-control" id="mobileNo" name="mobileNo" value=""
							placeholder="Enter mobile number" pattern="^[6-9][0-9]{9}$" maxlength="10" inputmode="numeric" required>
						<div class="invalid-feedback">Enter a 10 digit mobile number starting with 6, 7, 8 or 9.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="alternateContactNo" class="form-label fld-label">Alternate Contact Number</label>
						<input type="text" class="form-control" id="alternateContactNo" name="alternateContactNo" value=""
							placeholder="Enter alternate contact number" pattern="^[6-9][0-9]{9}$" maxlength="10" inputmode="numeric">
						<div class="invalid-feedback">Enter a 10 digit contact number starting with 6, 7, 8 or 9.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="email" class="form-label fld-label">Email ID</label>
						<input type="email" class="form-control" id="email" name="email" value=""
							placeholder="Enter email id" pattern="^(?=.*[A-Za-z0-9\u0900-\u097F]).{2,150}$" maxlength="150">
						<div class="invalid-feedback">Enter at least 2 characters.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="panNumber" class="form-label fld-label">PAN Number (if applicable)</label>
						<input type="text" class="form-control" id="panNumber" name="panNumber" value=""
							placeholder="Enter pan number (if applicable)" pattern="^[A-Za-z]{5}[0-9]{4}[A-Za-z]$" maxlength="10">
						<div class="invalid-feedback">Enter a valid PAN, for example ABCDE1234F.</div>
					</div>
				</div>

				</div>
			</div>

			<div class="rts-card">
				<div class="rts-card-head">
					<span class="rts-step">3</span>
					<h6>Address Details</h6>
				</div>
				<div class="row">
				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="houseFlatNo" class="form-label fld-label">House / Flat No.</label>
						<input type="text" class="form-control" id="houseFlatNo" name="houseFlatNo" value=""
							placeholder="Enter house / flat no." pattern="^[A-Za-z0-9][A-Za-z0-9/\-]{0,49}$" maxlength="50">
						<div class="invalid-feedback">Use letters, digits, / and - only.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="streetArea" class="form-label fld-label">Street / Area</label>
						<input type="text" class="form-control" id="streetArea" name="streetArea" value=""
							placeholder="Enter street / area" pattern="^(?=.*[A-Za-z0-9\u0900-\u097F]).{2,150}$" maxlength="150">
						<div class="invalid-feedback">Enter at least 2 characters.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="iFunction" class="form-label fld-label">Ward / Zone No. <span class="mr">(&#2333;&#2379;&#2344; &#2325;&#2381;&#2352;.)</span> <span class="req">*</span></label>
						<select class="form-select" id="iFunction" name="zoneNo" onchange="changeddl(this)" required>
							<option value="" selected="">Select Zone</option>
							<option value="1">Zone No.1 - Laxmi Nagar (&#2354;&#2325;&#2381;&#2359;&#2381;&#2350;&#2368; &#2344;&#2327;&#2352;)</option>
							<option value="2">Zone No.2 - Dharmpeth (&#2343;&#2352;&#2350;&#2346;&#2375;&#2336;)</option>
							<option value="3">Zone No.3 - Hanuman Nagar (&#2361;&#2344;&#2369;&#2350;&#2366;&#2344; &#2344;&#2327;&#2352;)</option>
							<option value="4">Zone No.4 - Dhantoli (&#2343;&#2306;&#2340;&#2379;&#2354;&#2368;)</option>
							<option value="5">Zone No.5 - Nehru Nagar (&#2344;&#2375;&#2361;&#2352;&#2370; &#2344;&#2327;&#2352;)</option>
							<option value="6">Zone No.6 - Gandhibag (&#2327;&#2366;&#2306;&#2343;&#2368;&#2348;&#2366;&#2327;)</option>
							<option value="7">Zone No.7 - Satranjipura (&#2360;&#2340;&#2352;&#2306;&#2332;&#2368;&#2346;&#2369;&#2352;&#2366;)</option>
							<option value="8">Zone No.8 - Lakadganj (&#2354;&#2325;&#2337;&#2327;&#2306;&#2332;)</option>
							<option value="9">Zone No.9 - Aashi Nagar (&#2310;&#2358;&#2368; &#2344;&#2327;&#2352;)</option>
							<option value="10">Zone No.10 - Mangalwari (&#2350;&#2306;&#2327;&#2355;&#2357;&#2366;&#2352;&#2368;)</option>
						</select>
						<div class="invalid-feedback">Please select the zone.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="iOperation" class="form-label fld-label">Ward No. <span class="mr">(&#2346;&#2381;&#2352;&#2349;&#2366;&#2327; &#2325;&#2381;&#2352;.)</span> <span class="req">*</span></label>
						<select class="form-select" id="iOperation" name="wardNo" disabled required>
							<option value="" selected="">Select Ward</option>
							<option value="16">Ward No. 16</option>
							<option value="36">Ward No. 36</option>
							<option value="37">Ward No. 37</option>
							<option value="38">Ward No. 38</option>
							<option value="12">Ward No. 12</option>
							<option value="13">Ward No. 13</option>
							<option value="14">Ward No. 14</option>
							<option value="15">Ward No. 15</option>
							<option value="29">Ward No. 29</option>
							<option value="31">Ward No. 31</option>
							<option value="32">Ward No. 32</option>
							<option value="34">Ward No. 34</option>
							<option value="17">Ward No. 17</option>
							<option value="33">Ward No. 33</option>
							<option value="35">Ward No. 35</option>
							<option value="26">Ward No. 26</option>
							<option value="27">Ward No. 27</option>
							<option value="28">Ward No. 28</option>
							<option value="30">Ward No. 30</option>
							<option value="8">Ward No. 8</option>
							<option value="18">Ward No. 18</option>
							<option value="19">Ward No. 19</option>
							<option value="22">Ward No. 22</option>
							<option value="5">Ward No. 5</option>
							<option value="20">Ward No. 20</option>
							<option value="21">Ward No. 21</option>
							<option value="4">Ward No. 4</option>
							<option value="23">Ward No. 23</option>
							<option value="24">Ward No. 24</option>
							<option value="25">Ward No. 25</option>
							<option value="2">Ward No. 2</option>
							<option value="3">Ward No. 3</option>
							<option value="6">Ward No. 6</option>
							<option value="7">Ward No. 7</option>
							<option value="1">Ward No. 1</option>
							<option value="9">Ward No. 9</option>
							<option value="10">Ward No. 10</option>
							<option value="11">Ward No. 11</option>
						</select>
						<div class="invalid-feedback">Please select the prabhag.</div>
						<div class="hint">Choose a zone first.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="city" class="form-label fld-label">City</label>
						<input type="text" class="form-control bg-light" id="city" name="city"
							value="Nagpur" readonly>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="pinCode" class="form-label fld-label">PIN Code</label>
						<input type="text" class="form-control" id="pinCode" name="pinCode" value=""
							placeholder="Enter pin code" pattern="^[1-9][0-9]{5}$" maxlength="6" inputmode="numeric">
						<div class="invalid-feedback">Enter a 6 digit PIN code.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="signageBuildingName" class="form-label fld-label">Building / Property Name (location of signage)</label>
						<input type="text" class="form-control" id="signageBuildingName" name="signageBuildingName" value=""
							placeholder="Enter building / property name (location of signage)" pattern="^(?=.*[A-Za-z0-9\u0900-\u097F]).{2,150}$" maxlength="150">
						<div class="invalid-feedback">Enter at least 2 characters.</div>
					</div>
				</div>

				<div class="col-12">
					<div class="fld">
						<label for="signageAddress" class="form-label fld-label">Complete Address of Signage Location <span class="req">*</span></label>
						<textarea class="form-control" id="signageAddress" name="signageAddress" rows="2"
							maxlength="500" minlength="5" placeholder="Enter complete address of signage location" required></textarea>
						<div class="invalid-feedback">Please enter complete address of signage location, at least 5 characters.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="signageZoneWard" class="form-label fld-label">Signage Ward / Zone No.</label>
						<input type="text" class="form-control" id="signageZoneWard" name="signageZoneWard" value=""
							placeholder="Enter signage ward / zone no." pattern="^(?=.*[A-Za-z0-9\u0900-\u097F]).{2,150}$" maxlength="150">
						<div class="invalid-feedback">Enter at least 2 characters.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="propertyOwnerName" class="form-label fld-label">Property Owner's Name</label>
						<input type="text" class="form-control" id="propertyOwnerName" name="propertyOwnerName" value=""
							placeholder="Enter property owner's name" pattern="^[A-Za-z\u0900-\u097F][A-Za-z\u0900-\u097F .'\-]{1,99}$" maxlength="100">
						<div class="invalid-feedback">Enter a valid name using letters only, at least 2 characters.</div>
					</div>
				</div>

				</div>
			</div>

			<div class="rts-card">
				<div class="rts-card-head">
					<span class="rts-step">4</span>
					<h6>Signage Details</h6>
				</div>
				<div class="row">
				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="signageType" class="form-label fld-label">Type of Signage <span class="req">*</span></label>
						<select class="form-select" id="signageType" name="signageType" required>
							<option value="" selected="">Select</option>
							<option value="Advertisement Board">Advertisement Board</option>
							<option value="Shop Name Board">Shop Name Board</option>
							<option value="Hoarding">Hoarding</option>
							<option value="Glow Sign Board / LED Display">Glow Sign Board / LED Display</option>
							<option value="Directional Sign Board">Directional Sign Board</option>
							<option value="Other">Other</option>
						</select>
						<div class="invalid-feedback">Please select type of signage.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="signagePurpose" class="form-label fld-label">Purpose of Signage</label>
						<input type="text" class="form-control" id="signagePurpose" name="signagePurpose" value=""
							placeholder="Enter purpose of signage" pattern="^(?=.*[A-Za-z0-9\u0900-\u097F]).{2,150}$" maxlength="150">
						<div class="invalid-feedback">Enter at least 2 characters.</div>
					</div>
				</div>

				<div class="col-12">
					<div class="fld">
						<label for="signageContent" class="form-label fld-label">Signage Content / Description</label>
						<textarea class="form-control" id="signageContent" name="signageContent" rows="2"
							maxlength="500" placeholder="Enter signage content / description"></textarea>
						<div class="invalid-feedback">Please enter signage content / description.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="signageLength" class="form-label fld-label">Length (feet / metres)</label>
						<input type="number" class="form-control" id="signageLength" name="signageLength" value=""
							placeholder="0" min="0" max="99999" step="0.01" inputmode="decimal">
						<div class="invalid-feedback">Enter a number between 0 and 99999.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="signageWidth" class="form-label fld-label">Width (feet / metres)</label>
						<input type="number" class="form-control" id="signageWidth" name="signageWidth" value=""
							placeholder="0" min="0" max="99999" step="0.01" inputmode="decimal">
						<div class="invalid-feedback">Enter a number between 0 and 99999.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="signageTotalArea" class="form-label fld-label">Total Area (sq. ft. / sq. m.)</label>
						<input type="number" class="form-control" id="signageTotalArea" name="signageTotalArea" value=""
							placeholder="0" min="0" max="9999999" step="0.01" inputmode="decimal">
						<div class="invalid-feedback">Enter a number between 0 and 9999999.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="numberOfBoards" class="form-label fld-label">Number of Signage Boards</label>
						<input type="number" class="form-control" id="numberOfBoards" name="numberOfBoards" value=""
							placeholder="0" min="0" max="9999" step="1" inputmode="decimal">
						<div class="invalid-feedback">Enter a number between 0 and 9999.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="installationLocation" class="form-label fld-label">Installation Location <span class="req">*</span></label>
						<select class="form-select" id="installationLocation" name="installationLocation" required>
							<option value="" selected="">Select</option>
							<option value="Building / Shop">Building / Shop</option>
							<option value="Terrace / Rooftop">Terrace / Rooftop</option>
							<option value="Standalone Structure">Standalone Structure</option>
							<option value="Other">Other</option>
						</select>
						<div class="invalid-feedback">Please select installation location.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="proposedInstallationDate" class="form-label fld-label">Proposed Installation Date</label>
						<input type="date" class="form-control" id="proposedInstallationDate" name="proposedInstallationDate" value=""
							>
						<div class="invalid-feedback">Enter a valid date.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="licenceValidityRequested" class="form-label fld-label">License Validity Requested</label>
						<input type="text" class="form-control" id="licenceValidityRequested" name="licenceValidityRequested" value=""
							placeholder="Enter license validity requested" pattern="^(?=.*[A-Za-z0-9\u0900-\u097F]).{2,150}$" maxlength="150">
						<div class="invalid-feedback">Enter at least 2 characters.</div>
					</div>
				</div>

				</div>
			</div>

			<div class="rts-card">
				<div class="rts-card-head">
					<span class="rts-step">5</span>
					<h6>Fee Details</h6>
				</div>
				<div class="row">
				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="applicationFee" class="form-label fld-label">Application Fee (Rs.)</label>
						<input type="number" class="form-control" id="applicationFee" name="applicationFee" value=""
							placeholder="0" min="0" max="99999999" step="0.01" inputmode="decimal">
						<div class="invalid-feedback">Enter a number between 0 and 99999999.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="licenceFee" class="form-label fld-label">License Fee (Rs.)</label>
						<input type="number" class="form-control" id="licenceFee" name="licenceFee" value=""
							placeholder="0" min="0" max="99999999" step="0.01" inputmode="decimal">
						<div class="invalid-feedback">Enter a number between 0 and 99999999.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="otherCharges" class="form-label fld-label">Other Charges, if applicable (Rs.)</label>
						<input type="number" class="form-control" id="otherCharges" name="otherCharges" value=""
							placeholder="0" min="0" max="99999999" step="0.01" inputmode="decimal">
						<div class="invalid-feedback">Enter a number between 0 and 99999999.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="totalAmountPaid" class="form-label fld-label">Total Amount Paid (Rs.)</label>
						<input type="number" class="form-control" id="totalAmountPaid" name="totalAmountPaid" value=""
							placeholder="0" min="0" max="99999999" step="0.01" inputmode="decimal">
						<div class="invalid-feedback">Enter a number between 0 and 99999999.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="paymentTransactionNo" class="form-label fld-label">Payment Transaction / Receipt Number</label>
						<input type="text" class="form-control" id="paymentTransactionNo" name="paymentTransactionNo" value=""
							placeholder="Enter payment transaction / receipt number" pattern="^[A-Za-z0-9][A-Za-z0-9/\-]{0,49}$" maxlength="50">
						<div class="invalid-feedback">Use letters, digits, / and - only.</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-12">
					<div class="fld">
						<label for="paymentDate" class="form-label fld-label">Payment Date</label>
						<input type="date" class="form-control" id="paymentDate" name="paymentDate" value=""
							 max="<c:out value='${today}'/>">
						<div class="invalid-feedback">Enter a valid date. A future date is not accepted here.</div>
					</div>
				</div>

				</div>
			</div>

			<div class="rts-declaration">
				<div class="form-check">
					<input class="form-check-input" type="checkbox" id="declarationCheck"
						name="declaration" value="Yes" required>
					<label class="form-check-label ms-2" for="declarationCheck">
						I hereby declare that the information given above is true and correct to the best of
						my knowledge, and I agree to comply with the rules, regulations and conditions
						prescribed by Nagpur Municipal Corporation. <span class="req">*</span>
					</label>
					<div class="invalid-feedback">Please accept the declaration before submitting.</div>
				</div>
			</div>

			<div class="rts-sign">
				<span>Place: Nagpur</span>
				<span>Date: ____________________</span>
				<span>Signature of Applicant: ____________________</span>
			</div>

				<strong> Supporting Documents </strong>
			</h6>
			<div class="alert alert-info mb-0 p-2 mb-4 ms-2">
				<small class="form-label"><strong class="form-label">Note(&#2344;&#2379;&#2306;&#2342;): </strong>Upload below files in .pdf (Max upto 2 MB) (&#2326;&#2366;&#2354;&#2368;&#2354; &#2347;&#2366;&#2311;&#2354; .pdf &#2350;&#2343;&#2381;&#2351;&#2375; &#2309;&#2346;&#2354;&#2379;&#2337; &#2325;&#2352;&#2366; (&#2325;&#2350;&#2366;&#2354; &#2408; MB &#2346;&#2352;&#2381;&#2351;&#2306;&#2340;))</small>
			</div>
			<input type="hidden" name="filesPath" id="filesPath" />
			<div class="row">

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="doc1" class="form-label lbleng">Applicant's Identity Proof <span class="text-danger" style="color: red;">*</span></label>
						<input type="file" accept=".pdf" class="form-control"
							style="background-image: none;" id="doc1" name="doc1" required>
						<input type="hidden" name="identityProof" id="path_identityProof" />
						<div class="invalid-feedback">File selected is either greater than 2 MB or not of type .pdf.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="doc2" class="form-label lbleng">Applicant's Address Proof <span class="text-danger" style="color: red;">*</span></label>
						<input type="file" accept=".pdf" class="form-control"
							style="background-image: none;" id="doc2" name="doc2" required>
						<input type="hidden" name="addressProof" id="path_addressProof" />
						<div class="invalid-feedback">File selected is either greater than 2 MB or not of type .pdf.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="doc3" class="form-label lbleng">Photograph of Proposed Signage Location <span class="text-danger" style="color: red;">*</span></label>
						<input type="file" accept=".pdf" class="form-control"
							style="background-image: none;" id="doc3" name="doc3" required>
						<input type="hidden" name="locationPhotograph" id="path_locationPhotograph" />
						<div class="invalid-feedback">File selected is either greater than 2 MB or not of type .pdf.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="doc4" class="form-label lbleng">Signage Design / Layout <span class="text-danger" style="color: red;">*</span></label>
						<input type="file" accept=".pdf" class="form-control"
							style="background-image: none;" id="doc4" name="doc4" required>
						<input type="hidden" name="signageDesign" id="path_signageDesign" />
						<div class="invalid-feedback">File selected is either greater than 2 MB or not of type .pdf.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="doc5" class="form-label lbleng">Property Ownership Proof / Rent Agreement</label>
						<input type="file" accept=".pdf" class="form-control"
							style="background-image: none;" id="doc5" name="doc5">
						<input type="hidden" name="ownershipProof" id="path_ownershipProof" />
						<div class="invalid-feedback">File selected is either greater than 2 MB or not of type .pdf.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="doc6" class="form-label lbleng">Property Owner's NOC (if applicable)</label>
						<input type="file" accept=".pdf" class="form-control"
							style="background-image: none;" id="doc6" name="doc6">
						<input type="hidden" name="ownerNoc" id="path_ownerNoc" />
						<div class="invalid-feedback">File selected is either greater than 2 MB or not of type .pdf.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="doc7" class="form-label lbleng">Structural Stability Certificate (if applicable)</label>
						<input type="file" accept=".pdf" class="form-control"
							style="background-image: none;" id="doc7" name="doc7">
						<input type="hidden" name="structuralCertificate" id="path_structuralCertificate" />
						<div class="invalid-feedback">File selected is either greater than 2 MB or not of type .pdf.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="doc8" class="form-label lbleng">Previous Signage Licence Copy (for renewal)</label>
						<input type="file" accept=".pdf" class="form-control"
							style="background-image: none;" id="doc8" name="doc8">
						<input type="hidden" name="previousLicenceCopy" id="path_previousLicenceCopy" />
						<div class="invalid-feedback">File selected is either greater than 2 MB or not of type .pdf.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="doc9" class="form-label lbleng">Previous Licence Fee Receipt (for renewal)</label>
						<input type="file" accept=".pdf" class="form-control"
							style="background-image: none;" id="doc9" name="doc9">
						<input type="hidden" name="previousFeeReceipt" id="path_previousFeeReceipt" />
						<div class="invalid-feedback">File selected is either greater than 2 MB or not of type .pdf.</div>
					</div>
				</div>

				<div class="col-md-3">
					<div class="mb-3 mt-3">
						<label for="doc10" class="form-label lbleng">Other Required Document</label>
						<input type="file" accept=".pdf" class="form-control"
							style="background-image: none;" id="doc10" name="doc10">
						<input type="hidden" name="otherDocument" id="path_otherDocument" />
						<div class="invalid-feedback">File selected is either greater than 2 MB or not of type .pdf.</div>
					</div>
				</div>

			</div>
			<div class="rts-actions">
				<button class="btn btn-primary" type="submit" id="submit">Submit Application</button>
				<button class="btn btn-outline-secondary" type="button" id="printForm" onclick="window.print();">View and Print</button>
			</div>
		</div>
	</form>

<script type="text/javascript">
	// Uploads every chosen document, then reports back so the form can be saved.
	// Each file lands at UPLOAD_PATH/signagelicence/<id><name>.pdf and that path is written
	// into the hidden input bound to the matching entity property.
	function uploadDocuments(callback) {
		var basePath = '${pageContext.getAttribute("UPLOAD_PATH")}';
		var data = new FormData();
		var id = Math.floor(Math.random() * 9000) + 1000;
		var inputs = $('input[type="file"]');
		var paths = [];
		var filesPath = "";
		var anySelected = false;

		if ($('#doc1').get(0).files[0]) { data.append('doc1', $('#doc1').get(0).files[0]); }
		if ($('#doc2').get(0).files[0]) { data.append('doc2', $('#doc2').get(0).files[0]); }
		if ($('#doc3').get(0).files[0]) { data.append('doc3', $('#doc3').get(0).files[0]); }
		if ($('#doc4').get(0).files[0]) { data.append('doc4', $('#doc4').get(0).files[0]); }
		if ($('#doc5').get(0).files[0]) { data.append('doc5', $('#doc5').get(0).files[0]); }
		if ($('#doc6').get(0).files[0]) { data.append('doc6', $('#doc6').get(0).files[0]); }
		if ($('#doc7').get(0).files[0]) { data.append('doc7', $('#doc7').get(0).files[0]); }
		if ($('#doc8').get(0).files[0]) { data.append('doc8', $('#doc8').get(0).files[0]); }
		if ($('#doc9').get(0).files[0]) { data.append('doc9', $('#doc9').get(0).files[0]); }
		if ($('#doc10').get(0).files[0]) { data.append('doc10', $('#doc10').get(0).files[0]); }

		for (var i = 0; i < inputs.length; i++) {
			var element = inputs[i].value.split("\\");
			var a = element[element.length - 1];
			if (a === '' || a === undefined) {
				paths.push("");
				filesPath += "null,";
			} else {
				var splitName = a.split(".pdf")[0].replace(/[^a-zA-Z0-9]/g, "");
				var stored = basePath + "signagelicence/" + id + splitName + ".pdf";
				paths.push(stored);
				filesPath += stored + ",";
				anySelected = true;
			}
		}

		$('#path_identityProof').val(paths[0]);
		$('#path_addressProof').val(paths[1]);
		$('#path_locationPhotograph').val(paths[2]);
		$('#path_signageDesign').val(paths[3]);
		$('#path_ownershipProof').val(paths[4]);
		$('#path_ownerNoc').val(paths[5]);
		$('#path_structuralCertificate').val(paths[6]);
		$('#path_previousLicenceCopy').val(paths[7]);
		$('#path_previousFeeReceipt').val(paths[8]);
		$('#path_otherDocument').val(paths[9]);

		filesPath = filesPath.substring(0, filesPath.lastIndexOf(",")).replace(/\s/g, "");
		$("#filesPath").val(filesPath);

		if (!anySelected) {   // nothing chosen - let the save go through
			callback(true);
			return;
		}

		$.ajax({
			url: "<c:out value='${contextRoot}'/>/rtiapplication/uploadSignageLicence.do?id=" + id,
			type: 'POST',
			data: data,
			cache: false,
			dataType: 'json',
			processData: false,
			contentType: false,
			async: false,
			success: function (res) {
				if (res.status == true) {
					callback(true);
				} else {
					alert(res.message ? res.message : "Document upload failed.");
					callback(false);
				}
			},
			error: function (jqXHR, textStatus, errorThrown) {
				console.error("Upload error:", textStatus, errorThrown);
				alert("Document upload failed. Please try again.");
				callback(false);
			}
		});
	}
</script>
<script type="text/javascript">
	// Shows only the prabhags that belong to the chosen zone, and keeps the ward list
	// disabled until a zone is picked. Same behaviour as the forms already live.
	var ZONE_WARDS = {
		"1": [16, 36, 37, 38],
		"2": [12, 13, 14, 15],
		"3": [29, 31, 32, 34],
		"4": [17, 33, 35],
		"5": [26, 27, 28, 30],
		"6": [8, 18, 19, 22],
		"7": [5, 20, 21],
		"8": [4, 23, 24, 25],
		"9": [2, 3, 6, 7],
		"10": [1, 9, 10, 11]
	};

	function changeddl(obj) {
		var ward = document.getElementById('iOperation');
		if (!ward) { return; }
		var zone = obj.value;
		ward.selectedIndex = 0;
		if (!zone) {
			ward.setAttribute('disabled', 'disabled');
			return;
		}
		ward.removeAttribute('disabled');
		var allowed = ZONE_WARDS[zone] || [];
		for (var i = 1; i < ward.options.length; i++) {
			var show = allowed.indexOf(parseInt(ward.options[i].value, 10)) > -1;
			ward.options[i].hidden = !show;
			ward.options[i].disabled = !show;
			ward.options[i].style.display = show ? '' : 'none';
		}
	}
</script>
<script type="text/javascript">
	// Validation that one field alone cannot express: fields that only become
	// mandatory because of an earlier answer, dates that must not run backwards,
	// and totals that have to agree with their parts.
	window.rtsRulesLoaded = true;
	(function () {
		function byName(n) { return document.getElementsByName(n); }
		function valueOf(n) {
			var els = byName(n);
			for (var i = 0; i < els.length; i++) {
				if (els[i].type === 'radio' || els[i].type === 'checkbox') {
					if (els[i].checked) { return els[i].value; }
				} else { return els[i].value; }
			}
			return '';
		}
		function setRequired(n, on) {
			var els = byName(n);
			for (var i = 0; i < els.length; i++) {
				if (on) { els[i].setAttribute('required', 'required'); }
				else { els[i].removeAttribute('required'); els[i].setCustomValidity(''); }
				var lab = document.querySelector('label[for="' + els[i].id + '"]');
				if (lab && lab.className.indexOf('fld-label') > -1) {
					var star = lab.querySelector('.req');
					if (on && !star) { lab.insertAdjacentHTML('beforeend', ' <span class=\"req\">*</span>'); }
					if (!on && star) { star.parentNode.removeChild(star); }
				}
			}
		}

		function applyConditional() {
			var on_applicationType = ['Renewal'].indexOf(valueOf('applicationType')) > -1;
			['existingLicenceNo', 'existingLicenceExpiryDate'].forEach(function (t) { setRequired(t, on_applicationType); });
		}
		document.addEventListener('change', function (e) {
			if (e.target && e.target.name) { applyConditional(); }
		}, true);
		applyConditional();

		function num(n) { var v = parseFloat(valueOf(n)); return isNaN(v) ? 0 : v; }
		function setVal(n, v) {
			var els = byName(n);
			if (els.length) { els[0].value = v ? (Math.round(v * 100) / 100) : ''; }
		}
		function recalc() {
			setVal('signageTotalArea', num('signageLength') * num('signageWidth'));
			setVal('totalAmountPaid', num('applicationFee') + num('licenceFee') + num('otherCharges'));
		}
		['signageLength', 'signageWidth', 'applicationFee', 'licenceFee', 'otherCharges'].forEach(function (n) {
			var els = byName(n);
			for (var i = 0; i < els.length; i++) { els[i].addEventListener('input', recalc); }
		});
		recalc();

		['signageTotalArea', 'totalAmountPaid'].forEach(function (n) {
			var els = byName(n);
			for (var i = 0; i < els.length; i++) {
				els[i].setAttribute('readonly', 'readonly');
				els[i].className += ' bg-light';
				var w = els[i].parentNode.querySelector('.hint');
				if (!w) { els[i].insertAdjacentHTML('afterend',
					'<div class=\"hint\">Worked out from the values above.</div>'); }
			}
		});

		window.rtsCheckOrder = function () {
			var ok = true;
			return ok;
		};
	})();
</script>
</body>
