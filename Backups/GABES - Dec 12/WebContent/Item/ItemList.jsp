<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>Item List</title>
</head>

<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="item" class="GABES.Item" scope="page" />
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
		<div class="form-style-2-heading">
			All of the items sold or currently up for auction by
			<%=user.getUsername()%>
			<table class="resultTable">



				<tbody>


					<tr>
						<th>Item ID<br></th>
						<th>Item Name<br></th>
						<th>Auction Start Time<br></th>
						<th>Auction End Time</th>
						<th>Start Price</th>
						<th>Current Bid</th>
						<th>Status</th>
						<th></th>
						<th></th>
					</tr>
					<%
						String userid = user.getUserID();
						try {
							item.updateTime();
							ResultSet rs = item.getAllItems(userid);
							while (rs.next()) {
								try {

									String check = rs.getString("START_DATE");
					%>

					<tr>
						<td><%=rs.getString("ITEM_ID")%></td>
						<td><%=rs.getString("ITEM_NAME")%></td>
						<td><%=rs.getDate("START_DATE")%></td>
						<td><%=rs.getDate("END_DATE")%></td>
						<td><%=rs.getDouble("START_PRICE")%></td>
						<td><%=rs.getDouble("CURRENT_BID")%></td>
						<td><%=rs.getInt("STATUS")%></td>
						<td>
							<!-- passes the item number to the item info page (look at transactions example) -->
							<form method="GET" action="ItemInfo.jsp">
								<input id="itemID" name="id" value=<%=rs.getString("ITEM_ID")%>
									type="hidden"><br> <input value="Item Info"
									type="submit">
							</form>
						</td>
						<!-- passes the user number to the bidder list -->
						<td style="vertical-align: top;">
							<form method="GET" action="BidderList.jsp">
								<input id="itemID" name="id" value=<%=rs.getString("ITEM_ID")%>
									type="hidden"><br> <input value="Bidder List"
									type="submit">
							</form>
						</td>
					</tr>

					<%
						} catch (java.sql.SQLException sql) {
					%>
					<div class="form-style-2-heading">
						There are currently no items that have been sold or are currently
						for sale by the current user.
						<%
						}
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