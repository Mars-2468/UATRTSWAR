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
	<div class="vtitle">Application for Grant of Road Cutting Permission</div>
	<div class="vsub">Nagpur Municipal Corporation &nbsp;|&nbsp; Right to Services</div>

	<c:choose>
		<c:when test="${empty roadCuttingPermission}">
			<div class="alert alert-warning">No application was found for this reference.</div>
		</c:when>
		<c:otherwise>

		<div class="rts-strip">
			<div><div class="k">Application No.</div>
				<div class="v"><c:out value="${roadCuttingPermission.rtiapplrefno}" default="-"/></div></div>
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
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.applicationType}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.applicationType}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Date of Application</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.applicationDate}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.applicationDate}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Previous Permission / License Number (for renewal)</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.previousPermissionNo}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.previousPermissionNo}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Previous Permission Valid Up To</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.previousPermissionValidUpto}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.previousPermissionValidUpto}"/></c:otherwise></c:choose></div>
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
					<div class="vk">Full Name of Applicant / Authorized Person</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.applicantName}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.applicantName}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Name of Department / Agency / Company</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.agencyName}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.agencyName}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Applicant Category</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.applicantCategory}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.applicantCategory}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Mobile Number</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.mobileNo}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.mobileNo}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Email ID</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.email}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.email}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell wide">
					<div class="vk">Correspondence Address</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.correspondenceAddress}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.correspondenceAddress}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">PAN / GST Number (if applicable)</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.panGstNumber}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.panGstNumber}"/></c:otherwise></c:choose></div>
				</div>
			</div>
		</div>

		<div class="rts-card">
			<div class="rts-card-head">
				<span class="rts-step">3</span>
				<h6>Road Cutting Location Details</h6>
			</div>
			<div class="vrow">
				<div class="vcell">
					<div class="vk">Name of Road / Street</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.roadName}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.roadName}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Exact Location / Landmark</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.exactLocation}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.exactLocation}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Zone Number <span style="color:#8a9798">(&#2333;&#2379;&#2344; &#2325;&#2381;&#2352;.)</span></div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.zoneNo}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.zoneNo}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Ward Number</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.wardNo}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.wardNo}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Road Category</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.roadCategory}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.roadCategory}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Road Ownership / Maintaining Department</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.roadOwningDepartment}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.roadOwningDepartment}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">From Location</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.fromLocation}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.fromLocation}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">To Location</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.toLocation}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.toLocation}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">GPS Coordinates (if available)</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.gpsCoordinates}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.gpsCoordinates}"/></c:otherwise></c:choose></div>
				</div>
			</div>
		</div>

		<div class="rts-card">
			<div class="rts-card-head">
				<span class="rts-step">4</span>
				<h6>Road Cutting Work Details</h6>
			</div>
			<div class="vrow">
				<div class="vcell">
					<div class="vk">Purpose of Road Cutting</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.cuttingPurpose}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.cuttingPurpose}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell wide">
					<div class="vk">Detailed Description of Work</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.workDescription}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.workDescription}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Total Length of Road Cutting (metres)</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.cuttingLength}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.cuttingLength}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Width of Road Cutting (metres)</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.cuttingWidth}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.cuttingWidth}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Total Area Proposed for Cutting (sq. metres)</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.cuttingTotalArea}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.cuttingTotalArea}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Proposed Work Start Date</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.workStartDate}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.workStartDate}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Proposed Work Completion Date</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.workCompletionDate}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.workCompletionDate}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Road Restoration Responsibility</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.restorationResponsibility}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.restorationResponsibility}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Executing Contractor / Agency Name</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.executingContractor}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.executingContractor}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Traffic Diversion Required</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.trafficDiversionRequired}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.trafficDiversionRequired}"/></c:otherwise></c:choose></div>
				</div>
			</div>
		</div>

		<div class="rts-card">
			<div class="rts-card-head">
				<span class="rts-step">5</span>
				<h6>Fee and Deposit Details</h6>
			</div>
			<div class="vrow">
				<div class="vcell">
					<div class="vk">Application Fee (Rs.)</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.applicationFee}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.applicationFee}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Road Cutting Charges (Rs.)</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.roadCuttingCharges}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.roadCuttingCharges}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Restoration Charges (Rs.)</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.restorationCharges}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.restorationCharges}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Security Deposit (Rs.)</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.securityDeposit}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.securityDeposit}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Other Charges (Rs.)</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.otherCharges}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.otherCharges}"/></c:otherwise></c:choose></div>
				</div>
				<div class="vcell">
					<div class="vk">Total Amount Payable (Rs.)</div>
					<div class="vv"><c:choose><c:when test="${empty roadCuttingPermission.totalAmountPayable}"><span class="empty">Not provided</span></c:when><c:otherwise><c:out value="${roadCuttingPermission.totalAmountPayable}"/></c:otherwise></c:choose></div>
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
					<div class="vk">Applicant / Agency Identity Proof</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty roadCuttingPermission.identityProof or roadCuttingPermission.identityProof eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${roadCuttingPermission.identityProof}'/>"
									data-path="<c:out value='${roadCuttingPermission.identityProof}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Authorization Letter (if applicable)</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty roadCuttingPermission.authorizationLetter or roadCuttingPermission.authorizationLetter eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${roadCuttingPermission.authorizationLetter}'/>"
									data-path="<c:out value='${roadCuttingPermission.authorizationLetter}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Work Order / Administrative Approval</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty roadCuttingPermission.workOrder or roadCuttingPermission.workOrder eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${roadCuttingPermission.workOrder}'/>"
									data-path="<c:out value='${roadCuttingPermission.workOrder}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Road Cutting Location Map / Site Plan</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty roadCuttingPermission.locationMap or roadCuttingPermission.locationMap eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${roadCuttingPermission.locationMap}'/>"
									data-path="<c:out value='${roadCuttingPermission.locationMap}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Proposed Road Cutting Layout</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty roadCuttingPermission.cuttingLayout or roadCuttingPermission.cuttingLayout eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${roadCuttingPermission.cuttingLayout}'/>"
									data-path="<c:out value='${roadCuttingPermission.cuttingLayout}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Utility Plan / Service Line Details</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty roadCuttingPermission.utilityPlan or roadCuttingPermission.utilityPlan eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${roadCuttingPermission.utilityPlan}'/>"
									data-path="<c:out value='${roadCuttingPermission.utilityPlan}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Method Statement for Execution of Work</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty roadCuttingPermission.methodStatement or roadCuttingPermission.methodStatement eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${roadCuttingPermission.methodStatement}'/>"
									data-path="<c:out value='${roadCuttingPermission.methodStatement}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Traffic Diversion Plan (if applicable)</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty roadCuttingPermission.trafficDiversionPlan or roadCuttingPermission.trafficDiversionPlan eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${roadCuttingPermission.trafficDiversionPlan}'/>"
									data-path="<c:out value='${roadCuttingPermission.trafficDiversionPlan}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Previous Road Cutting Permission Copy (for renewal)</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty roadCuttingPermission.previousPermissionCopy or roadCuttingPermission.previousPermissionCopy eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${roadCuttingPermission.previousPermissionCopy}'/>"
									data-path="<c:out value='${roadCuttingPermission.previousPermissionCopy}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Previous Permission Fee Receipt (for renewal)</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty roadCuttingPermission.previousFeeReceipt or roadCuttingPermission.previousFeeReceipt eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${roadCuttingPermission.previousFeeReceipt}'/>"
									data-path="<c:out value='${roadCuttingPermission.previousFeeReceipt}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Road Restoration Plan</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty roadCuttingPermission.restorationPlan or roadCuttingPermission.restorationPlan eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${roadCuttingPermission.restorationPlan}'/>"
									data-path="<c:out value='${roadCuttingPermission.restorationPlan}'/>"
									onclick="docDownload(this.getAttribute('data-path'));">
									<span class="ico">&#8681;</span> Download
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="vcell">
					<div class="vk">Other Required Documents</div>
					<div class="doc-list">
						<c:choose>
							<c:when test="${empty roadCuttingPermission.otherDocument or roadCuttingPermission.otherDocument eq 'null'}">
								<span class="doc-chip none">Not attached</span>
							</c:when>
							<c:otherwise>
								<button type="button" class="doc-btn"
									title="<c:out value='${roadCuttingPermission.otherDocument}'/>"
									data-path="<c:out value='${roadCuttingPermission.otherDocument}'/>"
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
				href='<c:out value="${contextRoot}"/>/rtsapplication/listRTSRoadCuttingPermission.do'>Back to List</a>
		</div>

		</c:otherwise>
	</c:choose>
</div>
