<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.page import="com.mars.common.utils.Constants" />
<jsp:directive.page import="com.mars.common.utils.CommonUtils" />

<%
pageContext.setAttribute("DATE_FORMAT", Constants.DATE_FORMAT);
pageContext.setAttribute("SESSION_TOKEN_KEY", Constants.SESSION_TOKEN_KEY);
pageContext.setAttribute("STATUS_NO_LABEL", Constants.STATUS_NO_LABEL);
pageContext.setAttribute("STATUS_YES_LABEL", Constants.STATUS_YES_LABEL);
pageContext.setAttribute("STATUS_NO", Constants.STATUS_NO);
pageContext.setAttribute("STATUS_YES", Constants.STATUS_YES);
String contextPath = request.getContextPath();
String url = contextPath + "/pages/core-pages/nmc_user/";
String name = (String) session.getAttribute("name");
%>

<!-- Only ONE Bootstrap version should be loaded. Pick the one the rest of
     the app already uses; loading 4 conflicting CDN copies causes the
     inconsistent spacing/alignment you were seeing. -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">

<!-- Font Awesome, since the "Back to home" button uses fa-solid icons -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/css/all.min.css">

<style>
:root {
	--brand-green: #12c238;
	--text-muted: #524f4c;
	--label-color: #87837e;
}

body {
	background-image: linear-gradient(rgb(243, 248, 248), rgb(251, 252, 252));
	font-family: Arial, sans-serif;
	min-height: 100vh;
	margin: 0;
	/* Flexbox centering replaces the old margin-top:200px hack, so the
	   card stays centered on any screen size. */
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 40px 16px;
}

label {
	color: var(--label-color);
	font-weight: 400;
}

.success-card {
	width: 100%;
	max-width: 480px;
	background: #fff;
	padding: 32px 28px;
	border-radius: 15px;
	box-shadow: 0 6px 24px rgba(0, 0, 0, 0.12);
	text-align: center;
	box-sizing: border-box;
}

.success-icon {
	width: 60px;
	height: 60px;
	border-radius: 50%;
	background: var(--brand-green);
	color: #fff;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	font-size: 28px;
	border: none;
}

.success-title {
	color: var(--brand-green);
	font-size: 22px;
	font-weight: 700;
	margin-top: 20px;
	margin-bottom: 0;
}

.app-number,
.app-date {
	color: var(--text-muted);
	font-weight: 400;
	font-size: 16px;
	margin-top: 16px;
}

.app-number strong,
.app-date strong {
	font-weight: 700;
}

.helper-text {
	color: var(--text-muted);
	font-size: 15px;
	margin-top: 20px;
}

.action-area {
	margin-top: 28px;
	display: flex;
	flex-direction: column;
	align-items: center;
	gap: 14px;
}

.pdf-link {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	color: #0d6efd;
	text-decoration: none;
	font-size: 14px;
}

.pdf-link:hover {
	text-decoration: underline;
}

.pdf-link img {
	width: 22px;
	height: 22px;
}
</style>

<body>
	<div class="success-card">
		<button type="button" class="success-icon" aria-label="Success">
			<i class="fa-solid fa-check"></i>
		</button>

		<h2 class="success-title">Form submitted successfully</h2>

		<c:if test="${requestScope.rtiApplicationNumberi != null}">
			<h3 class="app-number">
				<fmt:message key="Your application number" /> :
				<strong><c:out value="${requestScope.rtiApplicationNumberi}" /></strong>
			</h3>

			<h4 class="app-date">
				<fmt:message key="Date" /> :
				<strong><c:out value="${requestScope.createdDate}" /></strong>
			</h4>
		</c:if>

		<p class="helper-text">Please use this application number for further reference</p>

		<div class="action-area">
			<button class="btn btn-primary" type="submit" id="submitBtn"
				value="Save" onclick="javascript:save(this.form);">
				<i class="fa-solid fa-check"></i> Back to home
			</button>

			<a href="#" class="pdf-link"
				onclick="downloadPdf('<c:out value="${requestScope.rtiapplrefid}"/>')">
				View &amp; Download Application PDF
				<img src="<%=url%>img/pdf.png" alt="PDF icon">
			</a>
		</div>
	</div>
</body>

<script type="text/javascript">
	function save() {
		onPageSubmit('<c:out value="${contextRoot}"/>/ws/nmc/dashboard.do');
	}

	function downloadPdf(rtiapplrefid) {
		var xhr = new XMLHttpRequest();
		xhr.open("POST", "<%= request.getContextPath() %>/fireapplication/generateApplicationPdf.do", true);
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xhr.responseType = "blob";

		xhr.onload = function () {
			if (this.status === 200) {
				var blob = new Blob([this.response], { type: "application/pdf" });
				var link = document.createElement('a');
				link.href = window.URL.createObjectURL(blob);
				link.download = "FireNoc.pdf";
				link.click();
			}
		};

		xhr.send("rtiapplrefid=" + encodeURIComponent(rtiapplrefid));
	}
</script>
