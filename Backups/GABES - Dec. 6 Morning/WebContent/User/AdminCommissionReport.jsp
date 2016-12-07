
<html>
<head>
<meta content="text/html; charset=ISO-8859-1" http-equiv="content-type">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>Commission Report</title>
</head>
<body style="background-color: #a7adba">
	<div class="form-style-2">
		<%@ page language="java" import="java.sql.*"%>
		<jsp:useBean id="user" class="GABES.User" scope="session" />
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

		<table class="resultTable">
			<tbody>
				<tr>
					<th>User Id</th>
					<th>Username</th>
					<th>First Name</th>
					<th>Last Name</th>
					<th>Email Address</th>
					<th>Seller Rating</th>
					<th>Commissions</th>
				</tr>

				<%
					try {
						ResultSet rs = user.getAllUserInfo();
						while (rs.next()) {
				%>
				<tr>
					<td><%=rs.getString("USER_ID")%></td>
					<td><%=rs.getString("USERNAME")%></td>
					<td><%=rs.getString("FIRST_N")%></td>
					<td><%=rs.getString("LAST_N")%></td>
					<td><%=rs.getString("EMAIL")%></td>
				</tr>
				<%
					}
						rs.close();
					}

					catch (IllegalStateException ise) {
						out.println(ise.getMessage());
					}
				%>

				<tr>
					<td>-</td>
					<th>Total Commissions</th>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td></td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>