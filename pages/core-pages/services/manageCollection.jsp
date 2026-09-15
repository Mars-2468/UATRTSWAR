  <jsp:directive.include file="/pages/common/include.jsp" />
  <%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="com.mars.common.utils.SessionUser"%>
<%@ page import="com.mars.common.model.User"%>
  <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Collection Form</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .hidden {
            display: none;
        }
    </style>
    <style>
    body {
        background: #f4f6f9;
        font-family: 'Segoe UI', Arial, sans-serif;
    }
    .hidden {
        display: none;
    }
    .container {
        max-width: 600px;
        background: #ffffff;
        margin-top: 40px;
        padding: 30px 35px;
        border-radius: 10px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    }
    h1 {
        font-size: 1.6rem;
        color: #2c3e50;
        margin-bottom: 25px;
        border-bottom: 2px solid #007bff;
        padding-bottom: 12px;
    }
    .form-group label {
        font-weight: 600;
        color: #34495e;
        margin-bottom: 6px;
    }
    .form-control {
        border-radius: 6px;
        border: 1px solid #ccd6e0;
        padding: 10px 12px;
        height: auto;
    }
    .form-control:focus {
        border-color: #007bff;
        box-shadow: 0 0 0 0.2rem rgba(0,123,255,.15);
    }
    #amount {
        font-weight: 700;
        color: #1a7d3a;
        background-color: #f0fdf4 !important;
    }
    .btn-primary {
        background: #007bff;
        border: none;
        padding: 10px 28px;
        border-radius: 6px;
        font-weight: 600;
        margin-top: 10px;
        transition: background 0.2s ease-in-out;
    }
    .btn-primary:hover {
        background: #0056b3;
    }
    .invalid-feedback {
        font-size: 0.85rem;
    }
</style>
    <%
	HttpSession session1 = request.getSession();
	SessionUser sessionUser = (SessionUser) session1.getAttribute("SessionUser");
	String user_id = (String) sessionUser.getUserName();

	String firstname = (String) sessionUser.getFirstName();
	String lastname = (String) sessionUser.getLastName();
	Long departmentId = (Long) sessionUser.getDepartmentId();
	String departmentname = "";
if(departmentId == 1){
		departmentname = "Admin Department";
	}else if (departmentId == 2) {
		departmentname = "Health Department";
	} else if (departmentId == 3) {
		departmentname = "Veterinary Department";
	} else if (departmentId == 4) {
		departmentname = "Property Tax Department";
	} else if (departmentId == 5) {
		departmentname = "Town Planning Department";
	} else if (departmentId == 6) {
		departmentname = "Water Department";
	} else if (departmentId == 7) {
		departmentname = "Fire Department";
	} else if (departmentId == 8) {
		departmentname = "Estate Department";
	} else if (departmentId == 9) {
		departmentname = "Market Department";
	}else if (departmentId == 10) {
		departmentname = "Garden Department";
	}else if (departmentId == 11) {
		departmentname = "HOD Department";
	}
%>
		
</head>
<body>
<c:if test="${not empty error}">
        <p style="color: red">${error}</p>
    </c:if>
    <div class="container">
    
        <h1 class="mt-5">Payment Collection Form</h1>
        <form id="paymentForm" class="needs-validation" novalidate>
            <div class="form-group">
                <label for="paymentMode">Payment Mode</label>
                <select class="form-control" id="paymentMode" name="paymentMode" style="background-image: none;" required>
                    <option value="cash">Cash</option>
                    <option value="cheque">Cheque/DD</option>
                </select>
                <div class="invalid-feedback">Please select a payment mode.</div>
            </div>
            
             <div class="form-group">
                    <label for="chequeDDRTGSDate">Collection Date</label>
                    <input type="date" class="form-control" id="receiptDate" name="receiptDate" style="background-image: none;" required>
                    <div class="invalid-feedback">Please provide the cheque/DD/RTGS date.</div>
                </div>
                
            <div id="chequeDDRTGSDetails" class="hidden">
                <div class="form-group">
                    <label for="chequeDDRTGSNumber">Cheque/DD/RTGS Number</label>
                    <input type="text" class="form-control" id="chequeDDRTGSNumber" name="chequeDDRTGSNumber" style="background-image: none;">
                    <div class="invalid-feedback">Please provide the cheque/DD/RTGS number.</div>
                </div>
                
               
                
                
                <div class="form-group">
                    <label for="chequeDDRTGSDate">Cheque/DD/RTGS Date</label>
                    <input type="date" class="form-control" id="chequeDDRTGSDate" name="chequeDDRTGSDate" style="background-image: none;" required>
                    <div class="invalid-feedback">Please provide the cheque/DD/RTGS date.</div>
                </div>
                <div class="form-group">
                    <label for="bankName">Bank Name</label>
                    <input type="text" class="form-control" id="bankName" name="bankName" style="background-image: none;">
                    <div class="invalid-feedback">Please provide the bank name.</div>
                </div>
                <div class="form-group">
                    <label for="branchName">Branch Name</label>
                    <input type="text" class="form-control" id="branchName" name="branchName" style="background-image: none;">
                    <div class="invalid-feedback">Please provide the branch name.</div>
                </div>
            </div>
            
            <div class="form-group">
    <label for="amount">Amount</label>
    <input type="text" class="form-control" id="amount" name="amount" style="background-image: none;" required readonly>
    <input type="hidden" id="amountRaw" name="amountRaw" value="${amount}">
    <div class="invalid-feedback">Please provide the amount.</div>
</div>

           <!--   <div class="form-group">
                <label for="amount">Amount</label>
                <input type="number" class="form-control" id="amount" name="amount" value="${amount}" style="background-image: none;" required disabled>
                <div class="invalid-feedback">Please provide the amount.</div>
            </div>-->
		 			<input type="hidden" name="user_id" id="user_id" value="<%= user_id %>">
		 			<input type="hidden" name="user_name" id="user_name" value="<%= firstname+" "+lastname %>">
		 			<input type="hidden" name="user_dept" id="user_dept" value="<%= departmentname %>">
		 
            
			<input type="hidden" name="rtiApplicationId" id="rtiApplicationId" value="${requestScope.rtiApplicationId}">
            
            <button type="submit" class="btn btn-primary" onclick="saveCollection()">Submit</button>
        </form>
    </div>

   <script>
// Format a number the Indian way: 2,45,000.00 (decimals truncated, not rounded)
   function formatIndianCurrency(value) {
       if (value === null || value === undefined || value === "" || isNaN(value)) {
           return "0.00";
       }
       // Truncate decimals (6000.68 -> 6000, 6000.25 -> 6000)
       var intPart = Math.trunc(Number(value)).toString();
       var isNegative = intPart.startsWith('-');
       if (isNegative) intPart = intPart.substring(1);

       var lastThree = intPart.substring(intPart.length - 3);
       var otherNumbers = intPart.substring(0, intPart.length - 3);
       if (otherNumbers !== '') {
           lastThree = ',' + lastThree;
       }
       var formatted = otherNumbers.replace(/\B(?=(\d{2})+(?!\d))/g, ",") + lastThree;

       return (isNegative ? '-' : '') + formatted + '.00';
   }

   // Apply formatting once the page loads
   document.addEventListener('DOMContentLoaded', function() {
       var rawAmount = document.getElementById('amountRaw').value;
       document.getElementById('amount').value = formatIndianCurrency(rawAmount);
   });
   
    document.getElementById('paymentMode').addEventListener('change', function() {
        const paymentMode = this.value;
        const chequeDDRTGSDetails = document.getElementById('chequeDDRTGSDetails');
        const chequeDDRTGSDate = document.getElementById('chequeDDRTGSDate');
        const bankName = document.getElementById('bankName');
        const branchName = document.getElementById('branchName');
        
        if (paymentMode === 'cash') {
            chequeDDRTGSDetails.classList.add('hidden');
            chequeDDRTGSNumber.required = false;
            chequeDDRTGSDate.required = false;
            bankName.required = false;
            branchName.required = false;
        } else {
            chequeDDRTGSDetails.classList.remove('hidden');
            chequeDDRTGSNumber.required = true;
            chequeDDRTGSDate.required = true;
            bankName.required = true;
            branchName.required = true;
        }
    });

    // Bootstrap custom validation script
    (function() {
        'use strict';
        
        var forms = document.getElementsByClassName('needs-validation');
        var validation = Array.prototype.filter.call(forms, function(form) {
            form.addEventListener('submit', function(event) {
                if (form.checkValidity() === false) {
                    event.preventDefault();
                    event.stopPropagation();
                } /* else {
                    // Form is valid, call saveCollection() here
                    saveCollection();
                    alert("hi");
                } */
                form.classList.add('was-validated');
            }, false);
        });
    })();
    
    function saveCollection() {
       
        onPageSubmit('<c:out value="${contextRoot}"/>/rtsapplication/saveCashCollection.do');
    }
</script>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
