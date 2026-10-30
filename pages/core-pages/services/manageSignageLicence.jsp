<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.page import="com.mars.common.utils.Constants" />
<jsp:directive.page import="com.mars.common.utils.CommonUtils" />
<jsp:directive.page import="com.mars.rti.utils.CoreConstants" />

<%
pageContext.setAttribute("DATE_FORMAT", Constants.DATE_FORMAT);
pageContext.setAttribute("UPLOAD_PATH", CoreConstants.UPLOAD_PATH);
%>

<style id="rts-view-styles">
	.rts-view { max-width: 1280px; margin: 0 auto; padding: 0 16px 28px; }
	.rts-view .vtitle { font-size: 20px; font-weight: 600; color: #0f3d3e;
		text-align: center; margin: 16px 0 6px; }
	.rts-view .vsub { text-align: center; font-size: 13px; color: #6b7b7c; margin-bottom: 18px; }
	.rts-strip { display: flex; flex-wrap: wrap; gap: 10px; background: #0f6c70; color: #fff;
		border-radius: 8px; padding: 12px 16px; margin-bottom: 18px; }
	.rts-strip div { flex: 1 1 200px; }
	.rts-strip .k { font-size: 11px; opacity: .85; text-transform: uppercase; letter-spacing: .4px; }
	.rts-strip .v { font-size: 15px; font-weight: 600; word-break: break-word; }
	.rts-card { background: #f7fbfc; border: 1px solid #dbe7ea; border-radius: 10px;
		padding: 0 18px 10px; margin-bottom: 16px; }
	.rts-card-head { display: flex; align-items: center; gap: 10px; padding: 12px 0 9px;
		border-bottom: 1px solid #dbe7ea; margin-bottom: 4px; }
	.rts-step { display: inline-flex; align-items: center; justify-content: center;
		width: 22px; height: 22px; border-radius: 5px; background: #0f6c70; color: #fff;
		font-size: 12px; font-weight: 600; flex: 0 0 22px; }
	.rts-card-head h6 { margin: 0; font-size: 14px; font-weight: 600; color: #15393a; }
	.vrow { display: flex; flex-wrap: wrap; margin: 0 -8px; }
	.vcell { flex: 0 0 33.333%; max-width: 33.333%; padding: 8px; }
	.vcell.wide { flex-basis: 100%; max-width: 100%; }
	.vk { font-size: 12px; color: #6b7b7c; margin-bottom: 2px; }
	.vv { font-size: 14px; color: #15393a; border-bottom: 1px dotted #c7d6d8;
		padding-bottom: 3px; min-height: 21px; word-break: break-word; }
	.vv .empty { color: #a9b6b7; font-style: italic; }
	.doc-list { display: flex; flex-wrap: wrap; gap: 8px; }
	.doc-chip { display: inline-flex; align-items: center; gap: 6px; font-size: 13px;
		background: #fff; border: 1px solid #cdd9db; border-radius: 6px; padding: 6px 10px; }
	.doc-chip.none { color: #a9b6b7; }
	.doc-btn { display: inline-flex; align-items: center; gap: 6px; font-size: 13px;
		background: #0f6c70; color: #fff; border: 1px solid #0f6c70; border-radius: 6px;
		padding: 6px 12px; cursor: pointer; }
	.doc-btn:hover { background: #0c585b; border-color: #0c585b; }
	.doc-btn:focus { outline: 2px solid #8ecfd1; outline-offset: 1px; }
	.doc-btn .ico { font-size: 14px; line-height: 1; }
	.rts-actions { display: flex; justify-content: center; gap: 12px; padding: 8px 0 4px; }
	.rts-actions .btn { min-width: 160px; }
	@media (max-width: 991px) { .vcell { flex-basis: 50%; max-width: 50%; } }
	@media (max-width: 575px) { .vcell { flex-basis: 100%; max-width: 100%; } }
	@media print {
		@page { size: A4 portrait; margin: 12mm 10mm; }
		header, .header, nav, .navbar, footer, .footer, .breadcrumb,
		.rts-actions { display: none !important; }
		.rts-strip { background: #fff !important; color: #000; border: 1px solid #000;
			-webkit-print-color-adjust: exact; print-color-adjust: exact; }
		.rts-strip .k, .rts-strip .v { color: #000; }
		.rts-card { background: #fff; border: 1px solid #000; border-radius: 0;
			break-inside: avoid; }
		.rts-step { background: #000 !important; -webkit-print-color-adjust: exact;
			print-color-adjust: exact; }
		.vv { font-size: 11px; } .vk { font-size: 9px; }
		.doc-btn { background: #fff !important; color: #000; border: 1px solid #000; }
	}
</style>

<script type="text/javascript">
	// Opens an attached document. The absolute path is URL encoded then base64 encoded
	// and handed to the shared /rtsApplication/getPdf.do endpoint, which is how the
	// other service view pages serve their attachments.
	function docDownload(filesPath) {
		if (!filesPath || filesPath === 'null') { return; }
		var encodedFilePath = encodeURIComponent(filesPath);
		var encodedFilesPath = btoa(encodedFilePath);
		window.open('<c:out value="${contextRoot}"/>/rtsApplication/getPdf.do?fp=' + encodedFilesPath,
				'_blank');
	}
</script>

<div class="rts-view">
	<div class="vtitle">Application for Issuance / Renewal of Signage Licence</div>
	<div class="vsub">Nagpur Municipal Corporation &nbsp;|&nbsp; Right to Services</div>

	<c:choose>
		<c:when test="${empty signageLicence}">
			<div class="alert alert-warning">No application was found for this reference.</div>
		</c:when>
		<c:otherwise>

		<div class="rts-strip">
			<div><div class="k">Application No.</div>
				<div class="v"><c:out value="${signageLicence.rtiapplrefno}" default="-"/></div></div>
			<div><div class="k">Submitted On</div>
				<div class="v"><c:out value="${rtiApplication.registrationDate}" default="-"/></div></div>
			<div><div class="k">Applicant</div>
				<div class="v"><c:out value="${rtiApplication.applicantName}" default="-"/></div></div>
			<div><div class="k">Status</div>
				<div class="v">
					<c:choose>
						<c:when test="${rtiApplication.workFlowStatus == 0}">In Progress</c:when>
						<c:when test="${rtiApplication.workFlowStatus == 1}">Completed</c:when>
						<c:when test="${rtiApplication.workFlowStatus == 2}">Payment Completed</c:when>
						<c:when test="${rtiApplication.workFlowStatus == 3}">Payment Pending</c:when>
						<c:when test="${rtiApplication.workFlowStatus == 5}">Rejected</c:when>
						<c:otherwise>-</c:otherwise>
					</c:choose>
				</div></div>
		</div>

		<div class="rts-card">
			<div class="rts-card-head">
				<span class="rts-step">1</span>
				<h6>Application Details</h6>
			</div>
			<div class="vrow">
				<div class="vcell">
					<div class="vk">Application Type</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.applicationType}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.applicationType}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Application Date</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.applicationDate}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.applicationDate}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Existing License Number (for renewal)</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.existingLicenceNo}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.existingLicenceNo}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Existing License Expiry Date (for renewal)</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.existingLicenceExpiryDate}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.existingLicenceExpiryDate}"/></c:otherwise></c:choose></div>
				</div>
			</div>
		</div>

		<div class="rts-card">
			<div class="rts-card-head">
				<span class="rts-step">2</span>
				<h6>Applicant Details</h6>
			</div>
			<div class="vrow">
				<div class="vcell">
					<div class="vk">Full Name of Applicant / Business Owner</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.applicantName}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.applicantName}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Name of Firm / Company (if applicable)</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.firmName}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.firmName}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Father's / Husband's Name</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.fatherHusbandName}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.fatherHusbandName}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Mobile Number</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.mobileNo}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.mobileNo}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Alternate Contact Number</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.alternateContactNo}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.alternateContactNo}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Email ID</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.email}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.email}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">PAN Number (if applicable)</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.panNumber}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.panNumber}"/></c:otherwise></c:choose></div>
				</div>
			</div>
		</div>

		<div class="rts-card">
			<div class="rts-card-head">
				<span class="rts-step">3</span>
				<h6>Address Details</h6>
			</div>
			<div class="vrow">
				<div class="vcell">
					<div class="vk">House / Flat No.</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.houseFlatNo}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.houseFlatNo}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Street / Area</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.streetArea}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.streetArea}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Ward / Zone No. <span style="color:#8a9798">(&#2333;&#2379;&#2344; &#2325;&#2381;&#2352;.)</span></div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.zoneNo}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.zoneNo}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Ward No.</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.wardNo}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.wardNo}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">City</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.city}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.city}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">PIN Code</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.pinCode}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.pinCode}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Building / Property Name (location of signage)</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.signageBuildingName}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.signageBuildingName}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell wide">
					<div class="vk">Complete Address of Signage Location</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.signageAddress}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.signageAddress}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Signage Ward / Zone No.</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.signageZoneWard}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.signageZoneWard}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Property Owner's Name</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.propertyOwnerName}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.propertyOwnerName}"/></c:otherwise></c:choose></div>
				</div>
			</div>
		</div>

		<div class="rts-card">
			<div class="rts-card-head">
				<span class="rts-step">4</span>
				<h6>Signage Details</h6>
			</div>
			<div class="vrow">
				<div class="vcell">
					<div class="vk">Type of Signage</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.signageType}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.signageType}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Purpose of Signage</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.signagePurpose}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.signagePurpose}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell wide">
					<div class="vk">Signage Content / Description</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.signageContent}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.signageContent}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Length (feet / metres)</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.signageLength}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.signageLength}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Width (feet / metres)</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.signageWidth}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.signageWidth}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Total Area (sq. ft. / sq. m.)</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.signageTotalArea}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.signageTotalArea}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Number of Signage Boards</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.numberOfBoards}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.numberOfBoards}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Installation Location</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.installationLocation}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.installationLocation}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Proposed Installation Date</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.proposedInstallationDate}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.proposedInstallationDate}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">License Validity Requested</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.licenceValidityRequested}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.licenceValidityRequested}"/></c:otherwise></c:choose></div>
				</div>
			</div>
		</div>

		<div class="rts-card">
			<div class="rts-card-head">
				<span class="rts-step">5</span>
				<h6>Fee Details</h6>
			</div>
			<div class="vrow">
				<div class="vcell">
					<div class="vk">Application Fee (Rs.)</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.applicationFee}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.applicationFee}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">License Fee (Rs.)</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.licenceFee}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.licenceFee}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Other Charges, if applicable (Rs.)</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.otherCharges}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.otherCharges}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Total Amount Paid (Rs.)</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.totalAmountPaid}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.totalAmountPaid}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Payment Transaction / Receipt Number</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.paymentTransactionNo}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.paymentTransactionNo}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Payment Date</div>
					<div class="vv"><c:choose><c:when test="${empty signageLicence.paymentDate}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${signageLicence.paymentDate}"/></c:otherwise></c:choose></div>
				</div>
			</div>
		</div>

		<div class="rts-card">
			<div class="rts-card-head">
				<span class="rts-step">6</span>
				<h6>Supporting Documents</h6>
			</div>
			<div class="vrow">
				<div class="vcell">
					<div class="vk">Applicant's Identity Proof</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty signageLicence.identityProof or signageLicence.identityProof eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${signageLicence.identityProof}'/>"
									data-path="<c:out value='${signageLicence.identityProof}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Applicant's Address Proof</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty signageLicence.addressProof or signageLicence.addressProof eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${signageLicence.addressProof}'/>"
									data-path="<c:out value='${signageLicence.addressProof}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Photograph of Proposed Signage Location</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty signageLicence.locationPhotograph or signageLicence.locationPhotograph eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${signageLicence.locationPhotograph}'/>"
									data-path="<c:out value='${signageLicence.locationPhotograph}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Signage Design / Layout</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty signageLicence.signageDesign or signageLicence.signageDesign eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${signageLicence.signageDesign}'/>"
									data-path="<c:out value='${signageLicence.signageDesign}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Property Ownership Proof / Rent Agreement</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty signageLicence.ownershipProof or signageLicence.ownershipProof eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${signageLicence.ownershipProof}'/>"
									data-path="<c:out value='${signageLicence.ownershipProof}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Property Owner's NOC (if applicable)</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty signageLicence.ownerNoc or signageLicence.ownerNoc eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${signageLicence.ownerNoc}'/>"
									data-path="<c:out value='${signageLicence.ownerNoc}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Structural Stability Certificate (if applicable)</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty signageLicence.structuralCertificate or signageLicence.structuralCertificate eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${signageLicence.structuralCertificate}'/>"
									data-path="<c:out value='${signageLicence.structuralCertificate}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Previous Signage Licence Copy (for renewal)</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty signageLicence.previousLicenceCopy or signageLicence.previousLicenceCopy eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${signageLicence.previousLicenceCopy}'/>"
									data-path="<c:out value='${signageLicence.previousLicenceCopy}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Previous Licence Fee Receipt (for renewal)</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty signageLicence.previousFeeReceipt or signageLicence.previousFeeReceipt eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${signageLicence.previousFeeReceipt}'/>"
									data-path="<c:out value='${signageLicence.previousFeeReceipt}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Other Required Document</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty signageLicence.otherDocument or signageLicence.otherDocument eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${signageLicence.otherDocument}'/>"
									data-path="<c:out value='${signageLicence.otherDocument}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>

		<div class="rts-actions">
			<button class="btn btn-outline-secondary" type="button"
				onclick="window.print();">View and Print</button>
			<a class="btn btn-primary"
				href='<c:out value="${contextRoot}"/>/rtsapplication/listRTSSignageLicence.do'>Back to List</a>
		</div>

		</c:otherwise>
	</c:choose>
</div>
