<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Login</title>
    <link href="<c:url value='/css/bootstrap.min.css'/>" rel="stylesheet"/>
</head>
<body>
<div class="container">
    <h2>Login</h2>

    <!-- Show error if login fails -->
    <c:if test="${param.error != null}">
        <div class="alert alert-danger">
            Invalid username or password.
        </div>
    </c:if>

    <!-- Show logout success -->
    <c:if test="${param.logout != null}">
        <div class="alert alert-success">
            You have been logged out successfully.
        </div>
    </c:if>

    <form action="<c:url value='/perform_login'/>" method="post">
        <div class="mb-3">
            <label>Username</label>
            <input class="form-control" name="username" required/>
        </div>
        <div class="mb-3">
            <label>Password</label>
            <input class="form-control" name="password" type="password" required/>
        </div>
        <button class="btn btn-primary" type="submit">Login</button>
    </form>

    <p><a href="<c:url value='/adminregister'/>">Register Admin</a></p>
</div>
</body>
</html>
