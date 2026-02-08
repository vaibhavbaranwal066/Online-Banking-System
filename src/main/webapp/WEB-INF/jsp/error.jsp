<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Online Banking</title>
    <link href="<c:url value='/css/bootstrap.min.css'/>" rel="stylesheet"/>
    <style>
        body { background-color: #f8f9fa; }
        .navbar { background-color: #1e3a5f; }
        .navbar a { color: white !important; }
        .error-container {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 80vh;
        }
        .error-card {
            background: white;
            padding: 50px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            text-align: center;
            max-width: 500px;
        }
        .error-icon {
            font-size: 80px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="/">🏦 Online Banking</a>
    </div>
</nav>

<div class="error-container">
    <div class="error-card">
        <div class="error-icon">❌</div>
        <h2>Oops! Something Went Wrong</h2>
        <p class="text-muted">${message != null ? message : 'An unexpected error occurred.'}</p>
        <hr/>
        <p>
            <a href="/" class="btn btn-primary">🏠 Go to Home</a>
            <a href="/login" class="btn btn-secondary">🔓 Go to Login</a>
        </p>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
