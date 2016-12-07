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

		<ul>
			<li><a class="active" href="../Login_action.jsp">Home</a></li>
			<li class="dropdown"><a href="javascript:void(0)"
				class="dropbtn">My GABeS</a>
				<div class="dropdown-content">
					<a href="UpdateProfile.jsp">Update My Profile</a> <a
						href="ViewMyFeedback.jsp">View My Feedback</a>
				</div></li>
			<!-- Items Menu -->
			<li class="dropdown"><a href="javascript:void(0)"
				class="dropbtn">Shop</a>
				<div class="dropdown-content">
					<a href="../Item/Search.jsp">Search</a> <a
						href="../Item/ListOfItemsToBidOn.jsp">View All Listed Items</a> <a
						href="../Item/ItemListUserHasBidOn.jsp">View Items I Bid On</a> <a
						href="../Item/ItemListForItemsUserBought.jsp">View Items I Won</a>
				</div></li>
			<!-- Manage Sales Menu -->
			<li class="dropdown"><a href="javascript:void(0)"
				class="dropbtn">Sell</a>
				<div class="dropdown-content">
					<a href="../Item/AddNewItem.jsp">List New Item</a> <a
						href="../Item/ItemList.jsp">View My Listed Items</a>
				</div></li>
			<%
				if (user.isThisUserAdmin()) {
			%>
			<!-- Admin Dropdown Menu -->
			<li class="dropdown"><a href="javascript:void(0)"
				class="dropbtn">Admin Options</a>
				<div class="dropdown-content">
					<a href="AddNewUser.jsp">Add New User</a> <a
						href="AdminCommissionReport.jsp">View Commission Report</a> <a
						href="SalesSummary.jsp">View Sales Summary</a>
				</div></li>
			<%
				}
			%>
			<li style="float: right"><a class="active"
				href="../Logout_action.jsp">Logout</a></li>
		</ul>
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
			</table>

			<!-- Add User Button -->
			<form method="post" action="AddUser_Action.jsp">
				<input name="Submit" value="Add User" type="submit"><br>
			</form>
	</div>

</body>
</html>