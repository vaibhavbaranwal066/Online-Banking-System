<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html><head><title>Admin Register</title></head>
<body>
<h2>Register Admin</h2>
<form action="${pageContext.request.contextPath}/adminregister" method="post">
  <label>Username</label><input name="username"/><br/>
  <label>Password</label><input type="password" name="password"/><br/>
  <label>Full Name</label><input name="fullName"/><br/>
  <button>Register</button>
</form>
</body></html>
