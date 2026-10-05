<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.page	import="com.mars.common.utils.Constants" />
<jsp:directive.page	import="com.mars.common.utils.CommonUtils" />
<script type="text/javascript"
	src="<c:out value=" ${contextRoot}" />/scripts/jquery/user-script.js"></script>
    
  <meta charset="UTF-8">
  <meta name="keywords" content="human centered design process, ihcd">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
  <title>Sign In</title>
  
  <link rel="icon" href="img/favicon.ico" type="image/x-icon">
  
  <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@200;400&display=swap" rel="stylesheet">
  <!-- Bootstrap core CSS -->
  <link rel="stylesheet" href="css/bootstrap.min.css">
  
  
<link rel="stylesheet" type="text/css" href="<c:out value='${contextRoot}'/>/pages/core-pages/nmc_user/css/style1.css" /> 
	
 <%
pageContext.setAttribute("DATE_FORMAT", Constants.DATE_FORMAT);
pageContext.setAttribute("SESSION_TOKEN_KEY", Constants.SESSION_TOKEN_KEY);
pageContext.setAttribute("STATUS_NO_LABEL", Constants.STATUS_NO_LABEL);
pageContext.setAttribute("STATUS_YES_LABEL", Constants.STATUS_YES_LABEL);
pageContext.setAttribute("STATUS_NO", Constants.STATUS_NO);
pageContext.setAttribute("STATUS_YES", Constants.STATUS_YES);
///pageContext.setAttribute("statusList", CommonUtils.getStatus());
String contextPath = request.getContextPath();
String url = contextPath + "/pages/core-pages/nmc_user/";

%>
 
</head>
<style>
#home{

background-image:url('<c:out value=" ${contextRoot}" />/pages/core-pages/nmc_user/img/citizenbackground.jpg');
background-position: bottom center;
    background-size: cover; 
  background-repeat:no-repeat;

}

#xyz {
        background-image: url("<%= url %>img/dashbackground.jpg");
        background-size: cover; 
        background-repeat: no-repeat; 
        background-position: center; 
    }
</style>
<body id="home">
<div class="container-fluid"  style="height:100vh;">
    <div class="row p-2 border bg-blue d-flex align-items-center" id="xyz">
        <div class="col-md-1">
            <img src="<%=url%>img/nagpur.png" class="img-fluid">
        </div>

        <div class="col-md-10"> <!-- Modified column width to 10 -->
            <h3 class="m-0" style="color:white;align-content: end;font-size:22;">नागपूर महानगरपालिका, नागपूर</h3>
            <h3 class="m-0" style="color:white;font-size:22;">Right to Services</h3>
        </div>
            	    	<div class="col-md-1"><img src="<%= url%>img/g21.png" class="img-fluid"></div>
    </div>
    
    <%--  <div class="row p-2 border bg-blue d-flex align-items-center" id="xyz" style="padding-left: 0rem !important;padding-right: 0rem !important;">
        <div class="col-md-1">
            <img src="<%=url%>img/nagpur.png" class="img-fluid">
        </div>
         <div class="col-md-1">
             <img src="<%=url%>img/mars_logo.jpg"  class="img-responsive" style="height:95px;width:125px;margin-left:-8px">
        </div>

        <div class="col-md-9"> <!-- Modified column width to 10 -->
            <h3 class="m-0 ms-2" style="color:white;align-content: end;font-size:22;">नागपूर महानगरपालिका, नागपूर</h3>
            <h3 class="m-0 ms-2" style="color:white;font-size:22;">Right to Services</h3>
        </div>
            	    	<div class="col-md-1"><img src="<%= url%>img/g21.png" class="img-fluid"></div>
    </div> --%>
   <form action=""> 
    
	<div class="row p-5 mt-5" >
    	<div class="col-md-12 pl-md-0">        	
        	<div class="row align-items-center justify-content-center">
            	<div class="col-md-5 p-md-0 ">
                	<div class="sign-card">
                    	<h3 class="h3 text-center pb-3">Sign In</h3>
                   <!--    <ul class="nav nav-tabs mb-4">
                          <li class="nav-item w-50">
                            <a  href="" target="_blank" class="border-button btn btn-primary bd-highlight w-100" style="border-radius:.25rem 0 0 .25rem">User Id</a>
                          </li>  
                          <li class="nav-item w-50" >
                            <a  href="" target="_blank" class="bg-button btn btn-primary bd-highlight w-100" style="border-radius: 0 .25rem .25rem 0">Mobile number</a>
                          </li>--> 
                          
                        </ul>
                        
                         <input id="mobile" class="search form-control form-control-lg mb-3" type="number" maxlength="10" placeholder="Enter Mobile Number"  name="mobileNo"   onblur="validateMobile()"
                        <c:choose>
                        <c:when test="${not empty mobileNo}">
                              readOnly=”true” value="<%= request.getParameter("mobileNo") %>"
                        </c:when>
                        <c:otherwise>
                        </c:otherwise>
                        </c:choose>  >
                        
                        <c:choose>
                        <c:when test="${not empty msg}">
                        
                        <p  style="color:red" ><c:out value="${msg}"/></p>
       
                        </c:when>
                        <c:otherwise>
                              
                        </c:otherwise>
                   </c:choose>  
                               
                             
                          <p id="mobileError" style="color:red"></p>
                             
                         <c:choose>
                         <c:when test="${not empty otp}">
                               <div>
                               <input id="otp" class="search form-control form-control-lg mb-1" type="number" name="otp" placeholder="Enter OTP"   onblur="validateOTP()">
                               </div>
                              <p id="otpError" style="color:red"></p>
                              
                               <div>
                                <a   class="bg-button btn btn-primary bd-highlight"  onclick="javascript:login(this.form);" >Login</a>
                                <a class="active float-right" onclick="javascript:resend(this.form);">Resend OTP</a>                                
                                </div>
                          </c:when>
                          <c:otherwise>
                                <div class="pt-4">
                                <a   class="bg-button btn btn-primary bd-highlight" onclick="javascript:save(this.form);">Send OTP</a>
                                <a class="active float-right" onclick="javascript:register(this.form);">Register</a>
                                
                                </div>  
                          </c:otherwise>
                          </c:choose>
                          
                          	
                </div>
         </div>
   	
        </div>
    </div>
	
</div>
</form>
</body>
<script type="text/javascript">
function save(){
console.log("hello");
if(!validateMobile()){
	return;
} else{
onPageSubmit('<c:out value="${contextRoot}"/>/ws/nmc/user/login.do');
}
}


function login() {
	
	if(!validateOTP()){
		return;
	} else{
		onPageSubmit('<c:out value="${contextRoot}"/>/ws/user/dashboard.do');
	}
}

function resend() {
	
	onPageSubmit('<c:out value="${contextRoot}"/>/ws/nmc/user/login.do');

}


function register() {
	
	onPageSubmit('<c:out value="${contextRoot}"/>/ws/user/registration.do');

}
</script>
</html>