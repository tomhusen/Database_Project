<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>Item List</title>
</head>

<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="item" class="GABES.Item" scope="session" />
<jsp:useBean id="user" class="GABES.User" scope="session" />
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
		<br>

		<div class="form-style-2-heading">All of the items currently up
			for sale.</div>
		<div class="form-style-3-heading">If no one has placed a bid on
			an item, the current bid is 0. This first bid must be higher than the
			starting price.</div>
		<div class="form-style-3-heading">Once a bid greater than the
			starting price has been made, your bid must be greater than
			the current bid.</div>
		<div class="form-style-3-heading">The
			user with the highest bid at the end time will win the item!</div>
		<br>
		<div class="form-style-2-heading">Let the bidding begin!</div>


		<table class="resultTable">


			<tbody>


				<tr>
					<th>Item ID<br></th>
					<th>Item Name<br></th>
					<th>Category<br></th>
					<th>Auction Start Time<br></th>
					<th>Auction End Time</th>
					<th>Start Price</th>
					<th>Current Bid</th>
					<th></th>
					<th></th>
				</tr>
				<%
					try {
						item.updateTime();
						ResultSet rs = item.getAllItemsForSale();
						while (rs.next()) {
				%>


				<tr>
					<td><%=rs.getString("ITEM_ID")%></td>
					<td><%=rs.getString("ITEM_NAME")%></td>
					<td><%=rs.getString("ITEM_CATEGORY")%></td>
					<td><%=rs.getDate("START_DATE")%></td>
					<td><%=rs.getDate("END_DATE")%></td>
					<td><%=rs.getDouble("START_PRICE")%></td>
					<td><%=rs.getDouble("CURRENT_BID")%></td>

					<td style="vertical-align: top;">
						<!-- passes the item number to the item info page (look at transactions example) -->
						<form method="GET" action="ItemInfoForSaleList.jsp">
							<input id="itemID" name="id" value=<%=rs.getString("ITEM_ID")%>
								type="hidden"><br> <input value="Item Info"
								type="submit">
						</form>
					</td>
					<!-- passes the user number to the bidder list -->
					<td style="vertical-align: top;">
						<form method="GET" action="PlaceBid.jsp">
							<input id="itemID" name="id" value=<%=rs.getString("ITEM_ID")%>
								type="hidden"><br> <input value="Place Bid"
								type="submit">
						</form>
					</td>
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