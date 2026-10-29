<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.include
	file="/pages/core-pages/nmc_user/dashboard/header.jsp" />
<jsp:directive.page import="com.mars.common.utils.Constants" />
<jsp:directive.page import="com.mars.common.utils.CommonUtils" />
		<jsp:directive.page import="com.mars.rti.utils.CoreConstants" />

<!DOCTYPE html>
<html>
<head>
    <title>RTS Aaple Sarkar Dashboard Push</title>

   
    <style>
        body { font-family: Arial; margin: 30px; }
        .btn {
            padding: 10px 20px;
            background: #2e7d32;
            color: #fff;
            border: none;
            cursor: pointer;
        }
        .btn:disabled {
            background: #999;
            cursor: not-allowed;
        }
        .success { color: green; font-weight: bold; }
        .error { color: red; font-weight: bold; }
        pre {
            background: #f5f5f5;
            padding: 10px;
            border: 1px solid #ccc;
        }
    </style>

    
    <script>
        function pushRTSData() {

            var btn = document.getElementById("pushBtn");
            var msgDiv = document.getElementById("msg");
            var respDiv = document.getElementById("response");

            // UI changes
            btn.disabled = true;
            msgDiv.innerHTML = "Pushing data to RTS, please wait...";
            msgDiv.className = "";
            respDiv.innerHTML = "";

            var xhr = new XMLHttpRequest();
            xhr.open("POST",
                "${pageContext.request.contextPath}/rtsapplication/pushData.do",
                true);

            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4) {
                    btn.disabled = false;

                    if (xhr.status === 200) {
                        msgDiv.className = "success";
                        msgDiv.innerHTML = "RTS data pushed successfully";
                        respDiv.innerHTML = "<pre>" + xhr.responseText + "</pre>";
                    } else {
                        msgDiv.className = "error";
                        msgDiv.innerHTML = "Error while pushing RTS data";
                        respDiv.innerHTML = "<pre>" + xhr.responseText + "</pre>";
                    }
                }
            };

            xhr.send(); // no request body needed
        }
    </script>
    
</head>

<body>

<h3>RTS AapleSarkar Dashboard – Push Data</h3>

<button id="pushBtn" class="btn" onclick="pushRTSData()">
    Push Data to RTS
</button>

<div id="msg" style="margin-top:20px;"></div>
<div id="response" style="margin-top:10px;"></div>

</body>
</html>