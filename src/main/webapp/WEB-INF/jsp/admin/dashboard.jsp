<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Online Banking</title>
    <link href="<c:url value='/css/bootstrap.min.css'/>" rel="stylesheet"/>
    <style>
        body { background-color: #f8f9fa; }
        .navbar { background-color: #1e3a5f; }
        .navbar a { color: white !important; }
        .card { margin-bottom: 20px; }
        .stat-card { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 20px; border-radius: 8px; }
        .sidebar { position: fixed; left: 0; top: 50px; width: 250px; height: calc(100vh - 50px); background: #f8f9fa; }
        .main-content { margin-left: 250px; padding: 20px; }
        .form-section { background: white; padding: 20px; border-radius: 8px; margin-bottom: 20px; }
        .badge-pending { background-color: #ffc107; }
        .badge-approved { background-color: #28a745; }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="/">🏦 Online Banking</a>
        <span class="navbar-text text-white ms-auto">
            Admin Dashboard | <a href="/logout" class="text-white">Logout</a>
        </span>
    </div>
</nav>

<div class="container-fluid">
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

    <!-- Dashboard Stats -->
    <div class="row mt-4">
        <div class="col-md-3">
            <div class="stat-card">
                <h5>👥 Total Customers</h5>
                <h2>${totalCustomers}</h2>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);">
                <h5>💳 Total Accounts</h5>
                <h2>${totalAccounts}</h2>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);">
                <h5>💰 Total Transactions</h5>
                <h2>${totalTransactions}</h2>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card" style="background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);">
                <h5>📄 Pending Cheques</h5>
                <h2><c:out value="${chequeRequests.size()}"/></h2>
            </div>
        </div>
    </div>

    <!-- Tab Navigation -->
    <ul class="nav nav-tabs mt-4" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" data-bs-toggle="tab" href="#branches">🏢 Branches</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" href="#customers">👥 Customers</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" href="#accounts">💳 Accounts</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" href="#cheques">📄 Cheque Requests</a>
        </li>
    </ul>

    <div class="tab-content mt-3">
        <!-- Branches Tab -->
        <div id="branches" class="tab-pane fade show active">
            <div class="form-section">
                <h4>➕ Add New Branch</h4>
                <form action="/admin/branch/add" method="post" class="needs-validation">
                    <div class="row">
                        <div class="col-md-4">
                            <label class="form-label">Branch Name</label>
                            <input class="form-control" name="name" placeholder="e.g., North Branch" required/>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Address</label>
                            <input class="form-control" name="address" placeholder="Full address" required/>
                        </div>
                        <div class="col-md-2 d-flex align-items-end">
                            <button class="btn btn-primary w-100" type="submit">Add Branch</button>
                        </div>
                    </div>
                </form>
            </div>

            <div class="form-section">
                <h4>📋 All Branches</h4>
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Branch Name</th>
                            <th>Address</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="b" items="${branches}">
                            <tr>
                                <td>${b.id}</td>
                                <td>${b.name}</td>
                                <td>${b.address}</td>
                                <td><a href="/admin/branch/${b.id}" class="btn btn-sm btn-info">View</a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <c:if test="${branches.isEmpty()}">
                    <p class="text-muted">No branches found.</p>
                </c:if>
            </div>
        </div>

        <!-- Customers Tab -->
        <div id="customers" class="tab-pane fade">
            <div class="form-section">
                <h4>➕ Add New Customer</h4>
                <form action="/admin/customer/add" method="post" class="needs-validation">
                    <div class="row">
                        <div class="col-md-2">
                            <label class="form-label">Username</label>
                            <input class="form-control" name="username" placeholder="username" required/>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label">Password</label>
                            <input class="form-control" type="password" name="password" placeholder="password"/>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label">Full Name</label>
                            <input class="form-control" name="fullName" placeholder="full name" required/>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Branch</label>
                            <select class="form-control" name="branchId" required>
                                <option value="">-- Select Branch --</option>
                                <c:forEach var="b" items="${branches}">
                                    <option value="${b.id}">${b.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-3 d-flex align-items-end">
                            <button class="btn btn-primary w-100" type="submit">Add Customer</button>
                        </div>
                    </div>
                </form>
            </div>

            <div class="form-section">
                <h4>📋 All Customers</h4>
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Full Name</th>
                            <th>Branch</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="c" items="${customers}">
                            <tr>
                                <td>${c.id}</td>
                                <td>${c.username}</td>
                                <td>${c.fullName}</td>
                                <td><c:if test="${c.branch != null}">${c.branch.name}</c:if></td>
                                <td><a href="/admin/customer/${c.id}" class="btn btn-sm btn-info">View Details</a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <c:if test="${customers.isEmpty()}">
                    <p class="text-muted">No customers found.</p>
                </c:if>
            </div>
        </div>

        <!-- Accounts Tab -->
        <div id="accounts" class="tab-pane fade">
            <div class="form-section">
                <h4>➕ Create New Account</h4>
                <form action="/admin/account/add" method="post" class="needs-validation">
                    <div class="row">
                        <div class="col-md-3">
                            <label class="form-label">Customer</label>
                            <select class="form-control" name="customerId" required>
                                <option value="">-- Select Customer --</option>
                                <c:forEach var="c" items="${customers}">
                                    <option value="${c.id}">${c.username} (${c.fullName})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label">Account Type</label>
                            <select class="form-control" name="accountType" required>
                                <option value="SAVINGS">💰 SAVINGS</option>
                                <option value="CURRENT">💳 CURRENT</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label">Initial Deposit</label>
                            <input class="form-control" type="number" name="initialDeposit" placeholder="0.00" step="0.01"/>
                        </div>
                        <div class="col-md-5 d-flex align-items-end">
                            <button class="btn btn-primary w-100" type="submit">Create Account</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Cheque Requests Tab -->
        <div id="cheques" class="tab-pane fade">
            <div class="form-section">
                <h4>📄 Pending Cheque Requests</h4>
                <c:if test="${empty chequeRequests}">
                    <p class="text-muted">No cheque requests found.</p>
                </c:if>
                <c:forEach var="req" items="${chequeRequests}">
                    <div class="card mb-3">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-8">
                                    <h6 class="card-title">Request #${req.id}</h6>
                                    <p class="card-text">
                                        <strong>Account:</strong> ${req.account.accountNumber}<br/>
                                        <strong>Type:</strong> ${req.account.accountType}<br/>
                                        <strong>Created:</strong> ${req.createdAt}
                                    </p>
                                </div>
                                <div class="col-md-4 text-end">
                                    <span class="badge ${req.status == 'APPROVED' ? 'badge-approved' : 'badge-pending'}">
                                        ${req.status}
                                    </span>
                                    <c:if test="${req.status == 'PENDING'}">
                                        <form action="/admin/cheque/approve/${req.id}" method="post" class="d-inline">
                                            <button class="btn btn-success btn-sm" type="submit">✅ Approve</button>
                                        </form>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
