<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="user" class="GABES.User" scope="session" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>Update Profile</title>
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

		<br>
		<!-- Heading at top of the page -->
		<div class="form-style-2-heading">Update Information Below</div>

		<%
			try {
				ResultSet rs = user.getUserInfo();
				while (rs.next()) {
		%>

		<form method="post" action="Update_Action.jsp" name="EditForm">

			<table class="inputTable">
				<tr>
					<th>User ID</th>
					<th><%=rs.getString("USER_ID")%></th>
				</tr>
				<tr>
					<th>Username</th>
					<td><%=rs.getString("USERNAME")%></td>
				</tr>
				<tr>
					<th>New Password</th>
					<td><input name="password" MaxLength="30"
						value="<%=rs.getString("PASS")%>"></td>
				</tr>
				<tr>
					<th>Email Address</th>
					<td><input name="email" MaxLength="30"
						value="<%=rs.getString("EMAIL")%>"></td>
				</tr>
				<tr>
					<th>Phone Number</th>
					<td><input name="phone" MaxLength="10"
						value="<%=rs.getString("PHONE")%>"></td>
				</tr>
				<tr>
					<th>First Name</th>
					<td><input name="first" MaxLength="12"
						value="<%=rs.getString("FIRST_N")%>"></td>
				</tr>
				<tr>
					<th>Last Name</th>
					<td><input name="last" MaxLength="12"
						value="<%=rs.getString("LAST_N")%>"></td>
				</tr>
				<tr>
					<th>Creation Admin</th>
					<td><%=rs.getString("A_USERNAME")%></td>
				</tr>
			</table>
			<%
				}
					rs.close();
				} catch (IllegalStateException ise) {
					out.println(ise.getMessage());
				}
			%>
			<br>
			<!-- Update Profile Button -->
			<form method="post" action="Update_Action.jsp">
				<input name="Submit" value="Update" type="submit"><br>
	</div>

</body>
</html>