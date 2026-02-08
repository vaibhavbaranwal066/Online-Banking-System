<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Details - Online Banking Admin</title>
    <link href="<c:url value='/css/bootstrap.min.css'/>" rel="stylesheet"/>
    <style>
        body { background-color: #f8f9fa; }
        .navbar { background-color: #1e3a5f; }
        .navbar a { color: white !important; }
        .card { margin-bottom: 20px; }
        .customer-header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; border-radius: 8px; }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="/">🏦 Online Banking</a>
        <span class="navbar-text text-white ms-auto">
            Customer Details | <a href="/admin/dashboard" class="text-white">Back to Dashboard</a>
        </span>
    </div>
</nav>

<div class="container mt-4">
    <c:if test="${errorMessage != null}">
        <div class="alert alert-danger">${errorMessage}</div>
    </c:if>

    <!-- Customer Details -->
    <div class="customer-header">
        <h2>👤 ${customer.fullName}</h2>
        <p class="mb-1"><strong>Username:</strong> ${customer.username}</p>
        <p class="mb-1"><strong>Branch:</strong> <c:if test="${customer.branch != null}">${customer.branch.name}</c:if></p>
        <p class="mb-0"><strong>ID:</strong> ${customer.id}</p>
    </div>

    <!-- Accounts Section -->
    <div class="card">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">💳 Customer Accounts</h5>
        </div>
        <div class="card-body">
            <c:if test="${empty accounts}">
                <p class="text-muted">This customer has no accounts yet.</p>
            </c:if>
            <c:if test="${not empty accounts}">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Account Number</th>
                            <th>Type</th>
                            <th>Balance</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="acc" items="${accounts}">
                            <tr>
                                <td>${acc.accountNumber}</td>
                                <td>${acc.accountType}</td>
                                <td>₹ ${acc.balance}</td>
                                <td>${acc.open ? '🟢 Active' : '🔴 Closed'}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
    </div>

    <a href="/admin/dashboard" class="btn btn-secondary">← Back to Dashboard</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
