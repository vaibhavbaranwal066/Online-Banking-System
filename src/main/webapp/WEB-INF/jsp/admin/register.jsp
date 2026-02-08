<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Registration - Online Banking</title>
    <link href="<c:url value='/css/bootstrap.min.css'/>" rel="stylesheet"/>
    <style>
        body { 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .register-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 450px;
        }
        .register-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .register-header h1 {
            color: #1e3a5f;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .register-header p {
            color: #666;
            margin: 0;
        }
        .form-control {
            border: 1px solid #ddd;
            padding: 10px 15px;
            font-size: 16px;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .btn-register {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 10px;
            font-size: 16px;
            font-weight: bold;
        }
        .btn-register:hover {
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
            color: white;
        }
        .back-link {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }
        .back-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: bold;
        }
        .back-link a:hover {
            text-decoration: underline;
        }
        .password-hint {
            background: #f8f9fa;
            padding: 10px;
            border-radius: 5px;
            margin-top: 10px;
            font-size: 14px;
            color: #666;
            border-left: 4px solid #667eea;
        }
    </style>
</head>
<body>

<div class="register-container">
    <div class="register-header">
        <h1>👨‍💼 Admin Registration</h1>
        <p>Create a new admin account</p>
    </div>

    <!-- Registration Form -->
    <form action="${pageContext.request.contextPath}/adminregister" method="post" class="needs-validation">
        <div class="mb-3">
            <label class="form-label" for="username">👤 Username</label>
            <input class="form-control" id="username" name="username" placeholder="Choose a unique username" required/>
            <small class="text-muted">Username must be unique and alphanumeric</small>
        </div>

        <div class="mb-3">
            <label class="form-label" for="fullName">👨‍💼 Full Name</label>
            <input class="form-control" id="fullName" name="fullName" placeholder="Enter your full name" required/>
        </div>

        <div class="mb-3">
            <label class="form-label" for="password">🔐 Password</label>
            <input class="form-control" id="password" name="password" type="password" placeholder="Enter a strong password" required/>
            <div class="password-hint">
                <strong>Password Requirements:</strong>
                <ul style="margin: 5px 0; padding-left: 20px;">
                    <li>At least 8 characters</li>
                    <li>Mix of uppercase and lowercase</li>
                    <li>At least one number</li>
                    <li>At least one special character (@#$%)</li>
                </ul>
            </div>
        </div>

        <button class="btn btn-register w-100" type="submit">📝 Register Admin Account</button>
    </form>

    <div class="back-link">
        <p>Already have an account? <a href="<c:url value='/login'/>">Login here</a></p>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
