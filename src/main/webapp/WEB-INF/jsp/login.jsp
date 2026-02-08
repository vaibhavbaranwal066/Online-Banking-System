<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Online Banking System</title>
    <link href="<c:url value='/css/bootstrap.min.css'/>" rel="stylesheet"/>
    <style>
        body { 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 400px;
        }
        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .login-header h1 {
            color: #1e3a5f;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .login-header p {
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
        .btn-login {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 10px;
            font-size: 16px;
            font-weight: bold;
            color: white;
        }
        .btn-login:hover {
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
            color: white;
        }
        .register-link {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }
        .register-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: bold;
        }
        .register-link a:hover {
            text-decoration: underline;
        }
        .demo-creds {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            border-left: 4px solid #28a745;
        }
        .demo-creds h6 {
            margin-bottom: 10px;
            color: #1e3a5f;
        }
        .demo-creds p {
            margin: 5px 0;
            color: #666;
        }
    </style>
</head>
<body>

<div class="login-container">
    <div class="login-header">
        <h1>🏦 Online Banking</h1>
        <p>Secure Login Portal</p>
    </div>

    <!-- Show error if login fails -->
    <c:if test="${param.error == 'true'}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <strong>❌ Login Failed!</strong> Invalid username or password. Please try again.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Show logout success -->
    <c:if test="${param.logout == 'true'}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <strong>✅ Logged Out!</strong> You have been logged out successfully.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    
    <!-- Show registration success -->
    <c:if test="${param.registered == 'true'}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <strong>✅ Admin Registered!</strong> You can now log in with your account.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Demo Credentials -->
    <div class="demo-creds">
        <h6>📝 Demo Credentials</h6>
        <p><strong>Admin:</strong> admin / Admin@123</p>
        <p><strong>Customer:</strong> customer / Customer@123</p>
    </div>

    <!-- Login Form -->
    <form action="<c:url value='/perform_login'/>" method="post" class="needs-validation" novalidate>
        <div class="mb-3">
            <label class="form-label" for="username">👤 Username</label>
            <input class="form-control" id="username" name="username" placeholder="Enter your username" required autofocus/>
        </div>
        <div class="mb-3">
            <label class="form-label" for="password">🔐 Password</label>
            <input class="form-control" id="password" name="password" type="password" placeholder="Enter your password" required/>
        </div>
        <button class="btn btn-login w-100" type="submit">🔓 Login</button>
    </form>

    <div class="register-link">
        <p>Admin? <a href="<c:url value='/adminregister'/>">Register here</a></p>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
