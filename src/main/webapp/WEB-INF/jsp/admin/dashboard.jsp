<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html><head><title>Admin Dashboard</title></head><body>
<h1>Admin Dashboard</h1>
<p>Total Customers: ${totalCustomers}</p>
<p>Total Accounts: ${totalAccounts}</p>
<p>Total Transactions: ${totalTransactions}</p>

<h3>Add Branch</h3>
<form action="/admin/branch/add" method="post">
  <input name="name" placeholder="branch name"/>
  <input name="address" placeholder="address"/>
  <button>Add</button>
</form>

<h3>Add Customer</h3>
<form action="/admin/customer/add" method="post">
  <input name="username" placeholder="username"/>
  <input name="password" placeholder="password"/>
  <input name="fullName" placeholder="full name"/>
  <select name="branchId">
    <c:forEach var="b" items="${branches}">
      <option value="${b.id}">${b.name}</option>
    </c:forEach>
  </select>
  <button>Add Customer</button>
</form>

<h3>Create Account</h3>
<form action="/admin/account/add" method="post">
  <select name="customerId">
    <c:forEach var="c" items="${customers}">
      <option value="${c.id}">${c.username}</option>
    </c:forEach>
  </select>
  <select name="accountType">
    <option value="SAVINGS">SAVINGS</option>
    <option value="CURRENT">CURRENT</option>
  </select>
  <input name="initialDeposit" placeholder="initial deposit"/>
  <button>Create</button>
</form>

<h3>Cheque Requests</h3>
<c:forEach var="req" items="${chequeRequests}">
  <div>Request #${req.id} - Account: ${req.account.accountNumber} - Status: ${req.status}
    <form action="/admin/cheque/approve/${req.id}" method="post">
      <button>Approve</button>
    </form>
  </div>
</c:forEach>

</body></html>
