<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Banking - Secure Digital Banking Solution</title>
    <link href="<c:url value='/css/bootstrap.min.css'/>" rel="stylesheet"/>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .navbar { background: linear-gradient(135deg, #1e3a5f 0%, #2d5a8f 100%); }
        .navbar a { color: white !important; }
        .hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 100px 20px;
            text-align: center;
            margin-bottom: 50px;
        }
        .hero h1 { font-size: 48px; font-weight: bold; margin-bottom: 20px; }
        .hero p { font-size: 20px; margin-bottom: 30px; }
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            margin: 50px 0;
        }
        .feature-card {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.3s;
        }
        .feature-card:hover { transform: translateY(-5px); }
        .feature-icon { font-size: 40px; margin-bottom: 15px; }
        .cta-buttons { text-align: center; margin: 50px 0; }
        .cta-buttons a {
            margin: 0 10px;
            padding: 15px 40px;
            font-size: 18px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s;
        }
        .login-btn {
            background: #667eea;
            color: white;
        }
        .login-btn:hover { background: #764ba2; }
        .signup-btn {
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
        }
        .signup-btn:hover { background: #667eea; color: white; }
        footer {
            background: #1e3a5f;
            color: white;
            padding: 30px;
            text-align: center;
            margin-top: 50px;
        }
    </style>
</head>
<body>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#"><strong>🏦 Online Banking System</strong></a>
        <div class="ms-auto">
            <a href="/login" class="btn btn-light btn-sm">Login</a>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<div class="hero">
    <h1>🏦 Welcome to Secure Online Banking</h1>
    <p>Your trusted digital banking solution for secure transactions and account management</p>
</div>

<!-- Main Content -->
<div class="container">
    <!-- Key Features -->
    <h2 class="text-center mb-5">✨ Our Features</h2>
    <div class="features">
        <div class="feature-card">
            <div class="feature-icon">🔐</div>
            <h5>Secure Authentication</h5>
            <p>BCrypt encrypted passwords and role-based access control ensure your account is safe.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">💳</div>
            <h5>Multiple Accounts</h5>
            <p>Manage SAVINGS and CURRENT accounts with real-time balance tracking.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">💰</div>
            <h5>Quick Transactions</h5>
            <p>Deposit, withdraw, and transfer money instantly with PIN authentication.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">📊</div>
            <h5>Transaction History</h5>
            <p>View detailed transaction history for audit and record purposes.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">📋</div>
            <h5>Cheque Requests</h5>
            <p>Request cheque books online with instant admin approval notifications.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">👥</div>
            <h5>Admin Dashboard</h5>
            <p>Complete customer and account management with branch operations.</p>
        </div>
    </div>

    <!-- Account Types -->
    <h2 class="text-center mt-5 mb-4">💳 Account Types</h2>
    <div class="row">
        <div class="col-md-6">
            <div class="card border-primary">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">💰 Savings Account</h5>
                </div>
                <div class="card-body">
                    <ul>
                        <li>Perfect for regular saving</li>
                        <li>Secure money management</li>
                        <li>Easy transaction tracking</li>
                        <li>Withdraw with PIN security</li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card border-success">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0">💳 Current Account</h5>
                </div>
                <div class="card-body">
                    <ul>
                        <li>Ideal for business transactions</li>
                        <li>High transaction limits</li>
                        <li>Unlimited deposits/withdrawals</li>
                        <li>Advanced banking features</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <!-- Call to Action -->
    <div class="cta-buttons">
        <a href="/login" class="login-btn">🔓 Login to Your Account</a>
        <a href="/adminregister" class="signup-btn">👨‍💼 Register as Admin</a>
    </div>

    <!-- Security Info -->
    <div class="alert alert-info mt-5">
        <h5>🔒 Security Information</h5>
        <p><strong>Demo Credentials (For Testing):</strong></p>
        <p>
            <u>Admin Login:</u> admin / Admin@123<br/>
            <u>Customer Login:</u> customer / Customer@123
        </p>
        <p class="mb-0"><small>⚠️ These are demo credentials for testing only. Change them immediately in production.</small></p>
    </div>
</div>

<!-- Footer -->
<footer>
    <p>&copy; 2025 Online Banking System. All rights reserved. | Secure Banking Solution</p>
    <p>🔐 Your security is our priority | 🏦 Trust and transparency</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
