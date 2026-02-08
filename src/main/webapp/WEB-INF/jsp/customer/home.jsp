<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Portal - Online Banking</title>
    <link href="<c:url value='/css/bootstrap.min.css'/>" rel="stylesheet"/>
    <style>
        body { background-color: #f8f9fa; }
        .navbar { background-color: #1e3a5f; }
        .navbar a { color: white !important; }
        .card { margin-bottom: 20px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        .account-card { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 15px; border-radius: 8px; }
        .form-section { background: white; padding: 20px; border-radius: 8px; margin-bottom: 20px; }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="/">🏦 Online Banking</a>
        <span class="navbar-text text-white ms-auto">
            Welcome, ${customer.fullName}! | <a href="/logout" class="text-white">Logout</a>
        </span>
    </div>
</nav>

<div class="container mt-4">
    <!-- Messages -->
    <c:if test="${param.success != null}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <strong>✅ Success!</strong> ${param.success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${param.error != null}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <strong>❌ Error!</strong> ${param.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- My Accounts Section -->
    <h2 class="mt-4">💳 My Accounts</h2>
    <div class="row">
        <c:forEach var="a" items="${accounts}">
            <div class="col-md-4">
                <div class="account-card">
                    <h5>${a.accountType} Account</h5>
                    <p class="mb-1"><strong>Account Number:</strong><br/>${a.accountNumber}</p>
                    <h3>₹ <c:out value="${a.balance}"/></h3>
                    <p class="mb-0"><small>Account Status: ${a.open ? '🟢 Active' : '🔴 Closed'}</small></p>
                    <div class="mt-3">
                        <a href="/customer/account/${a.accountNumber}" class="btn btn-light btn-sm">View Details</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <c:if test="${accounts.isEmpty()}">
        <p class="text-muted">You don't have any accounts yet. Contact your admin to create one.</p>
    </c:if>

    <!-- Transactions Section -->
    <h2 class="mt-5">💰 Quick Transactions</h2>

    <!-- Tabs for different operations -->
    <ul class="nav nav-tabs" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" data-bs-toggle="tab" href="#deposit">💸 Deposit</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" href="#withdraw">💸 Withdraw</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" href="#transfer">🔄 Transfer</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" href="#cheque">📄 Cheque Book</a>
        </li>
    </ul>

    <div class="tab-content mt-3">
        <!-- Deposit Tab -->
        <div id="deposit" class="tab-pane fade show active">
            <div class="form-section">
                <h4>💸 Deposit Money</h4>
                <form action="/customer/account/deposit" method="post" class="needs-validation">
                    <div class="row">
                        <div class="col-md-4">
                            <label class="form-label">Account Number</label>
                            <select class="form-control" name="accountNumber" required>
                                <option value="">-- Select Account --</option>
                                <c:forEach var="a" items="${accounts}">
                                    <option value="${a.accountNumber}">${a.accountNumber} (${a.accountType})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Amount (₹)</label>
                            <input class="form-control" type="number" name="amount" placeholder="0.00" step="0.01" required/>
                        </div>
                        <div class="col-md-5 d-flex align-items-end">
                            <button class="btn btn-success w-100" type="submit">💰 Deposit Money</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Withdraw Tab -->
        <div id="withdraw" class="tab-pane fade">
            <div class="form-section">
                <h4>💸 Withdraw Money</h4>
                <form action="/customer/account/withdraw" method="post" class="needs-validation">
                    <div class="row">
                        <div class="col-md-3">
                            <label class="form-label">Account Number</label>
                            <select class="form-control" name="accountNumber" required>
                                <option value="">-- Select Account --</option>
                                <c:forEach var="a" items="${accounts}">
                                    <option value="${a.accountNumber}">${a.accountNumber} (${a.accountType})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label">Amount (₹)</label>
                            <input class="form-control" type="number" name="amount" placeholder="0.00" step="0.01" required/>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label">PNG</label>
                            <input class="form-control" type="password" name="pin" placeholder="4-digit PIN" required/>
                        </div>
                        <div class="col-md-5 d-flex align-items-end">
                            <button class="btn btn-warning w-100" type="submit">🏧 Withdraw</button>
                        </div>
                    </div>
                </form>
                <small class="text-muted">PIN is required for security. You received it when your account was created.</small>
            </div>
        </div>

        <!-- Transfer Tab -->
        <div id="transfer" class="tab-pane fade">
            <div class="form-section">
                <h4>🔄 Transfer Money</h4>
                <form action="/customer/account/transfer" method="post" class="needs-validation">
                    <div class="row">
                        <div class="col-md-2">
                            <label class="form-label">From Account</label>
                            <select class="form-control" name="fromAcc" required>
                                <option value="">-- Select --</option>
                                <c:forEach var="a" items="${accounts}">
                                    <option value="${a.accountNumber}">${a.accountNumber}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label">To Account</label>
                            <input class="form-control" type="text" name="toAcc" placeholder="Account Number" required/>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label">Amount (₹)</label>
                            <input class="form-control" type="number" name="amount" placeholder="0.00" step="0.01" required/>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label">PIN</label>
                            <input class="form-control" type="password" name="pin" placeholder="PIN" required/>
                        </div>
                        <div class="col-md-4 d-flex align-items-end">
                            <button class="btn btn-primary w-100" type="submit">💸 Transfer Now</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Cheque Book Tab -->
        <div id="cheque" class="tab-pane fade">
            <div class="form-section">
                <h4>📄 Request Cheque Book</h4>
                <form action="/customer/account/requestCheque" method="post" class="needs-validation">
                    <div class="row">
                        <div class="col-md-6">
                            <label class="form-label">Select Account</label>
                            <select class="form-control" name="accountNumber" required>
                                <option value="">-- Select Account --</option>
                                <c:forEach var="a" items="${accounts}">
                                    <option value="${a.accountNumber}">${a.accountNumber} (${a.accountType})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6 d-flex align-items-end">
                            <button class="btn btn-info w-100" type="submit">📋 Request Cheque Book</button>
                        </div>
                    </div>
                </form>
                <hr/>
                <p class="text-muted"><small>Your cheque book request will be sent to the admin for approval. You'll be notified once it's approved.</small></p>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
