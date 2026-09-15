<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:directive.include file="/pages/common/include.jsp" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Application ID Entry</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --ai-primary: #2f6fed;
            --ai-primary-dark: #1f4fc4;
            --ai-bg-start: #eef3fb;
            --ai-bg-end: #f7f9fd;
            --ai-border: #e3e8f0;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: linear-gradient(160deg, var(--ai-bg-start) 0%, var(--ai-bg-end) 60%);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }

        .ai-page-wrap {
            max-width: 520px;
            margin: 0 auto;
            padding: 24px 16px;
            width: 100%;
        }

        .ai-header {
            display: flex;
            align-items: center;
            gap: 14px;
            margin-bottom: 24px;
        }

        .ai-header .ai-icon-badge {
            width: 52px;
            height: 52px;
            border-radius: 14px;
            background: linear-gradient(135deg, var(--ai-primary), #6aa1ff);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-size: 24px;
            box-shadow: 0 8px 20px rgba(47, 111, 237, 0.28);
            flex-shrink: 0;
        }

        .ai-header h1 {
            margin: 0;
            font-size: 1.5rem;
            font-weight: 700;
            color: #1c2733;
        }

        .ai-header p {
            margin: 2px 0 0;
            color: #6b7788;
            font-size: 0.9rem;
        }

        .ai-card {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid var(--ai-border);
            box-shadow: 0 12px 32px rgba(30, 45, 80, 0.07);
            padding: 32px;
        }

        .ai-card .form-group label {
            font-weight: 600;
            font-size: 0.88rem;
            color: #334055;
            margin-bottom: 6px;
        }

        .ai-card .form-control {
            border-radius: 10px;
            border: 1.5px solid var(--ai-border);
            padding: 11px 14px;
            height: auto;
            font-size: 1rem;
            transition: border-color 0.15s ease, box-shadow 0.15s ease;
        }

        .ai-card .form-control:focus {
            border-color: var(--ai-primary);
            box-shadow: 0 0 0 3px rgba(47, 111, 237, 0.15);
        }

        .ai-go-btn {
            width: 100%;
            padding: 12px;
            font-weight: 600;
            font-size: 1rem;
            border-radius: 10px;
            background: linear-gradient(135deg, var(--ai-primary), var(--ai-primary-dark));
            border: none;
            box-shadow: 0 10px 22px rgba(47, 111, 237, 0.25);
            transition: transform 0.1s ease, box-shadow 0.1s ease;
        }

        .ai-go-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 14px 26px rgba(47, 111, 237, 0.32);
        }

        .invalid-feedback {
            font-size: 0.8rem;
        }
    </style>
</head>
<body>
    <div class="ai-page-wrap">

        <div class="ai-header">
            <div class="ai-icon-badge"><i class="bi bi-search"></i></div>
            <div>
                <h1>Enter Application Number</h1>
                <p>Find an RTS application to proceed with collection</p>
            </div>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">${error}</div>
        </c:if>

        <div class="ai-card">
            <form id="applicationForm" class="needs-validation" novalidate>
                <div class="form-group">
                    <label for="applicationId"><i class="bi bi-hash mr-1"></i> Application Number</label>
                    <input type="text" class="form-control" id="applicationId" name="applicationId" placeholder="Enter application number" required>
                    <div class="invalid-feedback">Please enter an application Number.</div>
                </div>
                <button type="submit" onclick="search()" class="btn btn-primary ai-go-btn">
                    <i class="bi bi-arrow-right-circle mr-1"></i> Go
                </button>
            </form>
        </div>
    </div>

   <script>

   (function() {
       'use strict';

           var forms = document.getElementsByClassName('needs-validation');
           var validation = Array.prototype.filter.call(forms, function(form) {
               form.addEventListener('submit', function(event) {
                   if (form.checkValidity() === false) {
                       event.preventDefault();
                       event.stopPropagation();
                   } else {
                       event.preventDefault(); // Prevent default form submission
                   }
                   form.classList.add('was-validated');
               }, false);
           });

   })();
   function search()
   {
       onPageSubmit('<c:out value="${contextRoot}"/>/rtsapplication/goForSaveCollection.do');

   }
    </script>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
