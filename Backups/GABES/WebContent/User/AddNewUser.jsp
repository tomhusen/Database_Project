<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="user" class="GABES.User" scope="session" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>Add New User</title>
</head>
<body style="background-color:#a7adba">
	<div class="form-style-2">
		<!-- Heading at top of the page -->
		<div class="form-style-2-heading">Please Enter Information about User Below</div>
		
		<form method="GET" action="AddUser_Action.jsp">
		
		<table>
			<tr>
				<td>Username</td>
				<td><input name="n_username" MaxLength="15" value=""></td>
			</tr><tr>
				<td>Email Address</td>
				<td><input name="n_email" MaxLength="30" value=""></td>
			</tr><tr>
				<td>Password</td>
				<td><input name="n_password" MaxLength="15" value=""></td>
			</tr><tr>
				<td>Phone Number</td>
				<td><input name="n_phone" MaxLength="10" value=""></td>
			</tr><tr>
				<td>First Name</td>
				<td><input name="n_first" MaxLength="12" value=""></td>
			</tr><tr>
				<td>Last Name</td>
				<td><input name="n_last" MaxLength="12" value=""></td>
			</tr><tr>
				<td>Admin User? (1=yes  0=no)</td>
				<td><input name="n_admin" MaxLength="1" value=""></td>
			</tr><tr>
				<td>Seller? (1=yes  0=no)</td>
				<td><input name="n_seller" MaxLength="1" value=""></td>
			</tr><tr>
				<td>Buyer? (1=yes  0=no)</td>
				<td><input name="n_buyer" MaxLength="1" value=""></td>
			</tr> 
		
		
		</table>

			<!-- Add User Button -->
			<form method="post" action="AddUser_Action.jsp">
				<input name="Submit" value="Add User" type="submit"><br>
			</form>
			<!-- Return to previous menu button -->
			<form method="post" action="../Login_action.jsp">
				<input name="Submit" value="Return to Menu" type="submit"><br>
			</form>
	</div>

</body>
</html>