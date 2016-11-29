
<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="customer" class="productdeals.Customer" scope="session"/> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<a href="Transactions/MyTransactions.jsp">
Click here to view your transaction history </a><br>
<br>
<a href="Edit/Edit.jsp">
Click here to edit your profile </a><br>
<br>
<br><br><br>
<form method="post" action="Logout_action.jsp">  
<input name="Submit" value="Logout" type="submit"><br>
</form>
</body>
</html>

