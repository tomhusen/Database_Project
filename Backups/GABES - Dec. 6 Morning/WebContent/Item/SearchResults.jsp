<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>Search Results</title>
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
					<a href="../User/UpdateProfile.jsp">Update My Profile</a> <a
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
		<div class="form-style-2-heading">Search Results</div>

		<table class="resultTable">
			<tbody>
				<tr>
					<th>Item ID</th>
					<th>Item Name</th>
					<th>Category</th>
					<th>Auction Start Time</th>
					<th>Auction End Time</th>
					<th>Start Price</th>
					<th>Current Bid</th>
					<th>Status</th>
					<th></th>
					<th></th>
				</tr>
				<%
					String s_itemID = request.getParameter("s_itemID");
					String s_keyword = request.getParameter("s_keyword");
					String s_category = request.getParameter("s_category");
					String s_lowBid = request.getParameter("s_lowBid");
					String s_highBid = request.getParameter("s_highBid");
					String s_month = request.getParameter("month");
					String s_day = request.getParameter("day");
					String s_year = request.getParameter("year");
					// Concat into 1 date string
					String s_endDate = s_year + "-" + s_month + "-" + s_day;
					try {
						item.updateTime();
						ResultSet rs = item.search(s_itemID, s_keyword, s_category, s_lowBid, s_highBid, s_endDate);
						while (rs.next()) {
				%>

				<tr>
					<td><%=rs.getString("ITEM_ID")%></td>
					<td><%=rs.getString("ITEM_NAME")%></td>
					<td><%=rs.getString("ITEM_CATEGORY")%></td>
					<td><%=rs.getTimestamp("START_DATE")%></td>
					<td><%=rs.getTimestamp("END_DATE")%></td>
					<td><%=rs.getDouble("START_PRICE")%></td>
					<td><%=rs.getDouble("CURRENT_BID")%></td>
					<td><%=rs.getInt("STATUS")%></td>

					<!--  Buttons -->
					<td>
						<form method="GET" action="ItemInfo.jsp">
							<input id="itemID" name="id" value=<%=rs.getString("ITEM_ID")%>
								type="hidden"><input value="Item Info" type="submit">
						</form>
					</td>
					<!-- passes the user number to the bidder list -->
					<td>
						<form method="GET" action="BidderList.jsp">
							<input id="transID" name="transNumber"
								value=<%=rs.getString("ITEM_ID")%> type="hidden"> <input
								value="Bidder List" type="submit">
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