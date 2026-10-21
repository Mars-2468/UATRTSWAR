<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.page import="com.mars.common.utils.Constants" />
<jsp:directive.page import="com.mars.common.utils.CommonUtils" />

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">

<style>
label { color: #87837e; font-weight: 400; }
.container {
	margin-top: 200px; padding: 5px; border-radius: 15px; background: #fff;
	box-sizing: content-box; border: 1px rgb(187, 134, 225);
	box-shadow: 0.3em 0.3em 2em rgba(0, 0, 0, 0.3);
}
body {
	background-image: linear-gradient(rgb(243, 248, 248), rgb(251, 252, 252));
	font-family: Arial, sans-serif; height: 73vh;
}
</style>

<body>
<div class="container" style="width: 558px; align-items: center;">
	<h2 class="text-center" style="color: #12c238; margin-top: 28px; font-size: 25px;">
		<strong> Form submitted successfully </strong>
	</h2>
	<div>
		<h3 style="color: #524f4c; margin-left: 90px; font-weight: lighter; font-size: 18px; margin-top: 20px;">
			Your application number : <strong>
			<c:if test="${hallLicenceRenewal.rtiapplrefno != null}">
				<c:out value="${hallLicenceRenewal.rtiapplrefno}"></c:out>
			</c:if>
			</strong>
		</h3>
	</div>
	<h5 class="text-center" style="color: #524f4c; margin-top: 29px; font-size: 20px;">
		Please use this application number for further reference
	</h5>

	<div class="col-md-12 text-start mb-3 mt-4" style="justify-content: center;">
		<div class="text-center">
			<a class="btn btn-primary btn_sm" type="submit" id="submitBtn"
				href='<c:out value="${contextRoot}"/>/ws/nmc/dashboard.do'>
				Back to home
			</a>
		</div>
	</div>
</div>
</body>
