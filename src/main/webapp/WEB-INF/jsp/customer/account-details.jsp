<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Details - Online Banking</title>
    <link href="<c:url value='/css/bootstrap.min.css'/>" rel="stylesheet"/>
    <style>
        body { background-color: #f8f9fa; }
        .navbar { background-color: #1e3a5f; }
        .navbar a { color: white !important; }
        .card { margin-bottom: 20px; }
        .account-header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; border-radius: 8px; }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="/">🏦 Online Banking</a>
        <span class="navbar-text text-white ms-auto">
            Account Details | <a href="/customer/home" class="text-white">Back to Home</a>
        </span>
    </div>
</nav>

<div class="container mt-4">
    <c:if test="${errorMessage != null}">
        <div class="alert alert-danger">${errorMessage}</div>
    </c:if>

    <!-- Account Details -->
    <div class="account-header">
        <h2>💳 ${account.accountType} Account</h2>
        <p class="mb-1"><strong>Account Number:</strong> ${account.accountNumber}</p>
        <h3 class="mt-3">₹ <c:out value="${account.balance}"/></h3>
        <p><strong>Status:</strong> ${account.open ? '🟢 Active' : '🔴 Closed'}</p>
    </div>

    <!-- Transaction History -->
    <div class="card">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">📊 Transaction History</h5>
        </div>
        <div class="card-body">
            <c:if test="${empty transactions}">
                <p class="text-muted">No transactions found for this account.</p>
            </c:if>
            <c:if test="${not empty transactions}">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Type</th>
                            <th>Amount</th>
                            <th>Date & Time</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="txn" items="${transactions}">
                            <tr>
                                <td>
                                    <c:choose>
                                        <c:when test="${txn.type == 'DEPOSIT'}">💰 DEPOSIT</c:when>
                                        <c:when test="${txn.type == 'WITHDRAW'}">💸 WITHDRAW</c:when>
                                        <c:when test="${txn.type == 'TRANSFER'}">🔄 TRANSFER</c:when>
                                        <c:otherwise>${txn.type}</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>₹ ${txn.amount}</td>
                                <td>${txn.timestamp}</td>
                                <td>${txn.description}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
    </div>

    <a href="/customer/home" class="btn btn-secondary">← Back to Home</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
