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
	<div class="vtitle">Application for Renewal of Licence for Hall</div>
	<div class="vsub">Nagpur Municipal Corporation &nbsp;|&nbsp; Right to Services</div>

	<c:choose>
		<c:when test="${empty hallLicenceRenewal}">
			<div class="alert alert-warning">No application was found for this reference.</div>
		</c:when>
		<c:otherwise>

		<div class="rts-strip">
			<div><div class="k">Application No.</div>
				<div class="v"><c:out value="${hallLicenceRenewal.rtiapplrefno}" default="-"/></div></div>
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
				<h6>Applicant Details</h6>
			</div>
			<div class="vrow">
				<div class="vcell">
					<div class="vk">Full Name of Applicant / Organization</div>
					<div class="vv"><c:choose><c:when test="${empty hallLicenceRenewal.applicantName}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${hallLicenceRenewal.applicantName}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Name of Authorized Representative (if applicable)</div>
					<div class="vv"><c:choose><c:when test="${empty hallLicenceRenewal.authorizedRepresentative}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${hallLicenceRenewal.authorizedRepresentative}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Mobile Number</div>
					<div class="vv"><c:choose><c:when test="${empty hallLicenceRenewal.mobileNo}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${hallLicenceRenewal.mobileNo}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Email ID</div>
					<div class="vv"><c:choose><c:when test="${empty hallLicenceRenewal.email}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${hallLicenceRenewal.email}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell wide">
					<div class="vk">Correspondence Address</div>
					<div class="vv"><c:choose><c:when test="${empty hallLicenceRenewal.correspondenceAddress}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${hallLicenceRenewal.correspondenceAddress}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Applicant Type</div>
					<div class="vv"><c:choose><c:when test="${empty hallLicenceRenewal.applicantType}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${hallLicenceRenewal.applicantType}"/></c:otherwise></c:choose></div>
				</div>
			</div>
		</div>

		<div class="rts-card">
			<div class="rts-card-head">
				<span class="rts-step">2</span>
				<h6>Hall and Existing Licence Details</h6>
			</div>
			<div class="vrow">
				<div class="vcell">
					<div class="vk">Name of Hall</div>
					<div class="vv"><c:choose><c:when test="${empty hallLicenceRenewal.hallName}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${hallLicenceRenewal.hallName}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell wide">
					<div class="vk">Complete Address of Hall</div>
					<div class="vv"><c:choose><c:when test="${empty hallLicenceRenewal.hallAddress}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${hallLicenceRenewal.hallAddress}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Zone Number <span style="color:#8a9798">(&#2333;&#2379;&#2344; &#2325;&#2381;&#2352;.)</span></div>
					<div class="vv"><c:choose><c:when test="${empty hallLicenceRenewal.zoneNo}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${hallLicenceRenewal.zoneNo}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Ward Number</div>
					<div class="vv"><c:choose><c:when test="${empty hallLicenceRenewal.wardNo}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${hallLicenceRenewal.wardNo}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Property ID / Property Tax Number</div>
					<div class="vv"><c:choose><c:when test="${empty hallLicenceRenewal.propertyTaxNo}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${hallLicenceRenewal.propertyTaxNo}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Existing Licence Number</div>
					<div class="vv"><c:choose><c:when test="${empty hallLicenceRenewal.existingLicenceNo}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${hallLicenceRenewal.existingLicenceNo}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Licence Issue Date</div>
					<div class="vv"><c:choose><c:when test="${empty hallLicenceRenewal.licenceIssueDate}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${hallLicenceRenewal.licenceIssueDate}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Existing Licence Expiry Date</div>
					<div class="vv"><c:choose><c:when test="${empty hallLicenceRenewal.licenceExpiryDate}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${hallLicenceRenewal.licenceExpiryDate}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Type of Hall</div>
					<div class="vv"><c:choose><c:when test="${empty hallLicenceRenewal.hallType}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${hallLicenceRenewal.hallType}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Maximum Capacity of Hall</div>
					<div class="vv"><c:choose><c:when test="${empty hallLicenceRenewal.maximumCapacity}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${hallLicenceRenewal.maximumCapacity}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Any Change in Hall Details Since Previous Licence?</div>
					<div class="vv"><c:choose><c:when test="${empty hallLicenceRenewal.anyChangeInDetails}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${hallLicenceRenewal.anyChangeInDetails}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell wide">
					<div class="vk">If yes, provide details</div>
					<div class="vv"><c:choose><c:when test="${empty hallLicenceRenewal.changeDetails}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${hallLicenceRenewal.changeDetails}"/></c:otherwise></c:choose></div>
				</div>
			</div>
		</div>

		<div class="rts-card">
			<div class="rts-card-head">
				<span class="rts-step">3</span>
				<h6>Supporting Documents</h6>
			</div>
			<div class="vrow">
				<div class="vcell">
					<div class="vk">Copy of Existing Hall Licence</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty hallLicenceRenewal.existingLicenceCopy or hallLicenceRenewal.existingLicenceCopy eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${hallLicenceRenewal.existingLicenceCopy}'/>"
									data-path="<c:out value='${hallLicenceRenewal.existingLicenceCopy}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Applicant's Identity Proof</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty hallLicenceRenewal.identityProof or hallLicenceRenewal.identityProof eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${hallLicenceRenewal.identityProof}'/>"
									data-path="<c:out value='${hallLicenceRenewal.identityProof}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Ownership Proof / Valid Lease Agreement</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty hallLicenceRenewal.ownershipProof or hallLicenceRenewal.ownershipProof eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${hallLicenceRenewal.ownershipProof}'/>"
									data-path="<c:out value='${hallLicenceRenewal.ownershipProof}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Latest Property Tax Paid Receipt</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty hallLicenceRenewal.propertyTaxReceipt or hallLicenceRenewal.propertyTaxReceipt eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${hallLicenceRenewal.propertyTaxReceipt}'/>"
									data-path="<c:out value='${hallLicenceRenewal.propertyTaxReceipt}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Previous Licence Renewal Receipt (if applicable)</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty hallLicenceRenewal.renewalReceipt or hallLicenceRenewal.renewalReceipt eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${hallLicenceRenewal.renewalReceipt}'/>"
									data-path="<c:out value='${hallLicenceRenewal.renewalReceipt}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Valid Fire Safety NOC / Compliance Certificate (if applicable)</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty hallLicenceRenewal.fireSafetyNoc or hallLicenceRenewal.fireSafetyNoc eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${hallLicenceRenewal.fireSafetyNoc}'/>"
									data-path="<c:out value='${hallLicenceRenewal.fireSafetyNoc}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Approved Building Plan / Occupancy Certificate (if required)</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty hallLicenceRenewal.buildingPlan or hallLicenceRenewal.buildingPlan eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${hallLicenceRenewal.buildingPlan}'/>"
									data-path="<c:out value='${hallLicenceRenewal.buildingPlan}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Other Documents Required by NMC</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty hallLicenceRenewal.otherDocument or hallLicenceRenewal.otherDocument eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${hallLicenceRenewal.otherDocument}'/>"
									data-path="<c:out value='${hallLicenceRenewal.otherDocument}'/>"
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
				href='<c:out value="${contextRoot}"/>/rtsapplication/listRTSHallLicenceRenewal.do'>Back to List</a>
		</div>

		</c:otherwise>
	</c:choose>
</div>
