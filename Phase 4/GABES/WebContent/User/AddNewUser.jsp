<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="user" class="GABES.User" scope="session" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>Add New User</title>
</head>
<body style="background-color: #a7adba">
	<div class="form-style-2">
		<!-- Heading at top of the page -->
		<div class="form-style-2-heading">Please Enter Information about
			User Below</div>

		<form method="GET" action="AddUser_Action.jsp">

<table class="inputTable">
				<tr>
					<th>Username</th>
					<td><input name="n_username" MaxLength="15" value=""></td>
				</tr>
				<tr>
					<th>Email Address</th>
					<td><input name="n_email" MaxLength="30" value=""></td>
				</tr>
				<tr>
					<th>Password</th>
					<td><input name="n_password" MaxLength="15" value=""></td>
				</tr>
				<tr>
					<th>Phone Number</th>
					<td><input name="n_phone" MaxLength="10" value=""></td>
				</tr>
				<tr>
					<th>First Name</th>
					<td><input name="n_first" MaxLength="12" value=""></td>
				</tr>
				<tr>
					<th>Last Name</th>
					<td><input name="n_last" MaxLength="12" value=""></td>
				</tr>
				<tr>
					<th>User Type</th>
					<td><select name="n_admin">
							<option value="1">Admin</option>
							<option value="0">Regular</option>
					</select></td>
				</tr>
				<tr>
					<th>Is Seller?</th>
					<td><select name="n_seller">
							<option value="1">Yes</option>
							<option value="0">No</option>
					</select></td>
				</tr>
				<tr>
					<th>Is Buyer?</th>
					<td><select name="n_buyer">
							<option value="1">Yes</option>
							<option value="0">No</option>
					</select></td>
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