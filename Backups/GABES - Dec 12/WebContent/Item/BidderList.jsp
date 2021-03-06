<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="bid" class="GABES.Bid" scope="session" />
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
					<a>User: <%=user.getUsername()%></a> <a
						href="../User/UpdateProfile.jsp">Update My Profile</a> <a
						href="../User/ViewMyFeedback.jsp">View My Feedback</a>
				</div></li>
			<!-- Items Menu -->
			<li class="dropdown"><a href="javascript:void(0)"
				class="dropbtn">Shop</a>
				<div class="dropdown-content">
					<a href="Search.jsp">Search</a> <a href="ListOfItemsToBidOn.jsp">View
						All Listed Items</a> <a href="ItemListUserHasBidOn.jsp">View Items
						I Bid On</a> <a href="ItemListForItemsUserBought.jsp">View Items I
						Won</a>
				</div></li>
			<!-- Manage Sales Menu -->
			<li class="dropdown"><a href="javascript:void(0)"
				class="dropbtn">Sell</a>
				<div class="dropdown-content">
					<a href="AddNewItem.jsp">List New Item</a> <a href="ItemList.jsp">View
						My Listed Items</a>
				</div></li>
			<%
				if (user.isThisUserAdmin()) {
			%>
			<!-- Admin Dropdown Menu -->
			<li class="dropdown"><a href="javascript:void(0)"
				class="dropbtn">Admin Options</a>
				<div class="dropdown-content">
					<a href="../User/AddNewUser.jsp">Add New User</a> <a
						href="../User/AdminCommissionReport.jsp">View Commission
						Report</a> <a href="../User/SalesSummary.jsp">View Sales Summary</a>
				</div></li>
			<%
				}
			%>
			<li style="float: right"><a class="active"
				href="../Logout_action.jsp">Logout</a></li>
		</ul>
		<!-- Heading at top of the page -->
		<br>
		<div class="form-style-2-heading">List of Bidders</div>

		<%
			String itemID = request.getParameter("id");
		%>
		<div class="form-style-4-heading">
			Item ID :
			<%=itemID%></div>

		<table class="resultTable">
			<tbody>
				<tr>
					<th>Bidding Time</th>
					<th>Username</th>
					<th>Bid Placed</th>
				</tr>
				<%
					try {
						ResultSet rs = bid.bidderList(itemID);
						while (rs.next()) {
				%>
				<tr>
					<td><%=rs.getString("BIDDING_TIME")%></td>
					<td><%=rs.getString("USERNAME")%></td>
					<td><%=rs.getString("MAX_BID")%></td>
				</tr>
				<%
					}
						rs.close();
					}

					catch (IllegalStateException ise) {
						out.println(ise.getMessage());
					}
				%>
			</tbody>
		</table>
		<br>
		<!-- Return to Item List -->
		<form method="post" action="ItemList.jsp">
			<input name="Submit" value="Return to Item List" type="submit"><br>
		</form>
	</div>
</body>
</html>