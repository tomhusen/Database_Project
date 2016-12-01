
<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="user" class="GABES.User" scope="session" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>Welcome!</title>
</head>
<body>

	<div class="form-style-2">
		<!-- Heading at top of the page -->
		<div class="form-style-2-heading">
			Welcome <%=user.getUsername()%></div>

		<form method="post" action="UpdateProfile.jsp">
			<input name="Submit" value="Update My Profile" type="submit"><br>
		</form>
		<br>

		<form method="post" action=SellingManagement.html>
			<input name="Submit" value="Manage My Sales" type="submit"><br>
		</form>
		<br>
	
		
		<form method="post" action="Admin_Welcome.jsp">
			<input name="Submit" value="Click Here to Access Admin Menu"
				type="submit"><br>
		</form>
		<br>
		<br>
		<br>
		<form method="post" action="../Logout_action.jsp">
			<input name="Submit" value="Logout" type="submit"><br>
		</form>
	</div>
</body>
</html>


