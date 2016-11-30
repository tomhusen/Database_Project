
<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="user" class="GABES.User" scope="session" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
</head>
<title>Admin Menu</title>
<body>
	<div class="form-style-2">
		<!-- Heading at top of the page -->
		<div class="form-style-2-heading">
			Welcome to the Admin Menu Page!</div>


	<form method="post" action="../Logout_action.jsp">
		<input name="Submit" value="Logout" type="submit"><br>
	</form>
</body>
</html>

