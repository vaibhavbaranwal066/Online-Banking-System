<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html><head><title>Customer Home</title></head><body>
<h1>Customer Home</h1>
<p>Accounts:</p>
<ul>
  <c:forEach var="a" items="${accounts}">
    <li>${a.accountNumber} - Balance: ${a.balance}</li>
  </c:forEach>
</ul>

<h3>Withdraw</h3>
<form action="/customer/account/withdraw" method="post">
  <input name="accountNumber" placeholder="accountNumber"/>
  <input name="amount" placeholder="amount"/>
  <input name="pin" placeholder="PIN"/>
  <button>Withdraw</button>
</form>

<h3>Deposit</h3>
<form action="/customer/account/deposit" method="post">
  <input name="accountNumber" placeholder="accountNumber"/>
  <input name="amount" placeholder="amount"/>
  <button>Deposit</button>
</form>

<h3>Transfer</h3>
<form action="/customer/account/transfer" method="post">
  <input name="fromAcc" placeholder="from account"/>
  <input name="toAcc" placeholder="to account"/>
  <input name="amount" placeholder="amount"/>
  <input name="pin" placeholder="PIN"/>
  <button>Transfer</button>
</form>

<h3>Request Cheque</h3>
<form action="/customer/account/requestCheque" method="post">
  <input name="accountNumber" placeholder="accountNumber"/>
  <button>Request</button>
</form>

</body></html>
