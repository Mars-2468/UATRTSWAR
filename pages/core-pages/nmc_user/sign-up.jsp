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
  <title>Register</title>
  
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
</head>
<body id="home" class="bg-grey">
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

<form>

	<div class="row p-5" >
    	<div class="col-md-12 pl-md-0">        	
        	<div class="row align-items-center justify-content-center">
            	<div class="col-md-5 p-md-0 ">
                	<div class="sign-card">
                    	<h3 class="h3 text-center pb-3">Register</h3>
                    	<c:choose>
                        <c:when test="${not empty msg}">
                        
                        <p  style="color:red" ><c:out value="${msg}"/></p>
       
                        </c:when>
                        <c:otherwise>
                              
                        </c:otherwise>
                        </c:choose>  
                        <div  class="input-group">
                        <div>
                        		<input id="fname" class="search form-control form-control-lg mb-3" type="text"   pattern="[A-Za-z]+" style="width:243px;" placeholder="Enter First Name" name="firstName" required onblur="validateName()" 
                        		 <c:choose>
                        <c:when test="${not empty mobileNo}">
                              readOnly=”true” value="<%= request.getParameter("firstName") %>"
                        </c:when>
                        <c:otherwise>
                        </c:otherwise>
                        </c:choose>  >
								
								</div>
								&nbsp &nbsp 						
								
								<div>
									<input id="lname" class="search form-control form-control-lg mb-3" type="text"   pattern="[A-Za-z]+" style="width:243px;" placeholder="Enter Last Name" name="lastName" required onblur="validateName()"
                        		 <c:choose>
                        <c:when test="${not empty mobileNo}">
                              readOnly=”true” value="<%= request.getParameter("lastName") %>"
                        </c:when>
                        <c:otherwise>
                        </c:otherwise>
                        </c:choose>  >
								</div>
					         </div>
							 <p id="nameError" style="color:red"></p>
					
						
                                <input id="email" class="search form-control form-control-lg mb-3" type="email"  placeholder="Enter E-Mail" name="email" required onblur="validateEmail()"
                                 <c:choose>
                        <c:when test="${not empty mobileNo}">
                              readOnly=”true” value="<%= request.getParameter("email") %>"
                        </c:when>
                        <c:otherwise>
                        </c:otherwise>
                        </c:choose>  >
                                <p id="emailError" style="color:red"></p>
							
                       		    <input id="mobile" class="search form-control form-control-lg mb-3"  pattern="[6-9]{1}[0-9]{9}"
								   maxlength="10" required placeholder="Enter Mobile Number" name="mobileNo" type="number"  onblur="validateMobile()"
								    <c:choose>
                        <c:when test="${not empty mobileNo}">
                              readOnly=”true” value="<%= request.getParameter("mobileNo") %>"
                        </c:when>
                        <c:otherwise>
                        </c:otherwise>
                        </c:choose>  
								   >
								   <p id="mobileError" style="color:red"></p>
								
								<c:choose>
                         <c:when test="${not empty mobileNo}">
                               <div>
                               <input id="otp" class="search form-control form-control-lg mb-1" name="otp" placeholder="Enter OTP" type="number"  onblur="validateOTP()">
                               </div>
                                <p id="otpError" style="color:red"></p>
                                
                               <div>
                                <a   class="bg-button btn btn-primary bd-highlight" onclick="javascript:submit(this.form);">Register</a>
                                <a class="active float-right" onclick="javascript:resend(this.form);">Resend OTP</a>
                                </div>
                          </c:when>
                          <c:otherwise>
                                <div class="pt-4">
                                <a   class="bg-button btn btn-primary bd-highlight" onclick="javascript:save(this.form);">Send OTP</a>
                                <a class="active float-right" onclick="javascript:login(this.form);">Login</a>
                                
                                </div>  
                          </c:otherwise>
                          </c:choose>						   
                                
							</div>               
                    </div>
                    	
                </div>
            	
                    </div>
                </div>
             </div>   
        </div>
    </div>

             </form>     	

</div>

<script>

function save(){

	if (!validateEmail() || !validateMobile() || !validateName) {
	    return; // stop form from submitting if validation fails
	} else{
	    onPageSubmit('<c:out value="${contextRoot}"/>/nmc/user/registration.do');
	}
	}

	function submit() {
		if(!validateOTP()){
			return;
		} else{
		onPageSubmit('<c:out value="${contextRoot}"/>/nmc/user/home.do');
		}
	}

	function resend() {
		
		onPageSubmit('<c:out value="${contextRoot}"/>/nmc/user/registration.do');
	}

	function login() {
		
			onPageSubmit('<c:out value="${contextRoot}"/>/ws/user/login.do');
		}
	
</script>

</body>