<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Branch Details - Online Banking Admin</title>
    <link href="<c:url value='/css/bootstrap.min.css'/>" rel="stylesheet"/>
    <style>
        body { background-color: #f8f9fa; }
        .navbar { background-color: #1e3a5f; }
        .navbar a { color: white !important; }
        .card { margin-bottom: 20px; }
        .branch-header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; border-radius: 8px; }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="/">🏦 Online Banking</a>
        <span class="navbar-text text-white ms-auto">
            Branch Details | <a href="/admin/dashboard" class="text-white">Back to Dashboard</a>
        </span>
    </div>
</nav>

<div class="container mt-4">
    <c:if test="${errorMessage != null}">
        <div class="alert alert-danger">${errorMessage}</div>
    </c:if>

    <!-- Branch Details -->
    <div class="branch-header">
        <h2>🏢 ${branch.name}</h2>
        <p class="mb-1"><strong>Address:</strong> ${branch.address}</p>
        <p class="mb-0"><strong>Branch ID:</strong> ${branch.id}</p>
    </div>

    <!-- Branch Information Card -->
    <div class="card">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">📋 Branch Information</h5>
        </div>
        <div class="card-body">
            <table class="table">
                <tr>
                    <th>Branch ID</th>
                    <td>${branch.id}</td>
                </tr>
                <tr>
                    <th>Branch Name</th>
                    <td>${branch.name}</td>
                </tr>
                <tr>
                    <th>Address</th>
                    <td>${branch.address}</td>
                </tr>
            </table>
        </div>
    </div>

    <a href="/admin/dashboard" class="btn btn-secondary">← Back to Dashboard</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
