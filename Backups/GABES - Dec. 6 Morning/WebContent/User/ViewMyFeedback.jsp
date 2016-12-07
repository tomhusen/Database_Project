<html>
<head>
<meta content="text/html; charset=ISO-8859-1" http-equiv="content-type">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>My Feedback</title>
</head>
<body class="form-style-2-body">
	<div class="form-style-2">
		<%@ page language="java" import="java.sql.*"%>
		<jsp:useBean id="user" class="GABES.User" scope="session" />
		<jsp:useBean id="feedback" class="GABES.Feedback" scope="session" />

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
		<div class="form-style-2-heading">
			Feedback for
			<%=user.getUsername()%></div>
		<br>
		<table class="resultTable">
			<tbody>
				<!-- Table Headers -->
				<tr>
					<th>Rater Username</th>
					<th>Item Number</th>
					<th>Overall Rating</th>
					<th>Item Quality</th>
					<th>Delivery</th>
					<th>Comments</th>
				</tr>

				<%
					try {
						ResultSet rs = feedback.getFeedbackInfoWithRater(user.getUserID());

						while (rs.next()) {
				%>
				<!-- Populates Table with Data -->
				<tr>
					<td><%=rs.getString("WINNER_ID")%></td>
					<td><%=rs.getString("ITEM_ID")%></td>
					<td><%=rs.getString("ITEM_QUALITY")%></td>
					<td><%=rs.getString("DELIVERY")%></td>
					<td><%=rs.getString("OVERALL_RATING")%></td>
					<td><%=rs.getString("COMMENTS")%></td>
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
	</div>
</body>
</html>