<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="item" class="GABES.Item" scope="session" />
<jsp:useBean id="bid" class="GABES.Bid" scope="session" />
<jsp:useBean id="user" class="GABES.User" scope="session" />
<jsp:setProperty name="bid" property="*" />
<jsp:setProperty name="item" property="*" />


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>Place Bid</title>
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
		<br>
		<!-- Heading at top of the page -->
		<div class="form-style-2-heading">Place a Bid</div>


		<%
			String itemID = request.getParameter("id");

			try {
				item.updateTime();
				ResultSet rs = item.getItemName(itemID);
				while (rs.next()) {
					try {
						//method getItemName above will get the item id, name, and either current price or starting price.
						//if the current price for an item is 0, it will instead run a query that will get the start price to display.
						//in this try catch, it will try to see if there is a start price in the result set. If there isnt one,
						//it will go to the catch and diplay the current price because the getItemName method determined that 
						//the current bid wasn't zero.
						String check = rs.getString("START_PRICE");
		%>
		<div class="form-style-4-heading">No bid had been placed yet.
			Place the first bid to become the winner of this item!</div>
		<div class="form-style-3-heading">**** Bid must be greater than
			the starting price ****</div>
		<form method="GET" action="PlaceBid_Action.jsp">

			<table class="inputTable">
				<tr>
					<th>Item ID</th>
					<td><%=rs.getString("ITEM_ID")%></td>
				</tr>

				<tr>
					<th>Item Name</th>
					<td><%=rs.getString("ITEM_NAME")%></td>
				</tr>
				<tr>
					<th>Starting Price</th>
					<td><%=rs.getString("START_PRICE")%></td>
				</tr>
				<tr>
					<th>New Bid</th>
					<td><input name="max_bid" MaxLength="10" value=""></td>
				</tr>
			</table>

			<!-- Submit New Bid -->
			<form method="GET" action="PlaceBid_Action.jsp">
				<input id="transID" name="itemID" value=<%=rs.getString("ITEM_ID")%>
					type="hidden"><br> <input name="Submit"
					value="Submit Bid" type="submit"><br>
			</form>

			<%
				} catch (java.sql.SQLException sql) {
			%>

			<form method="GET" action="PlaceBid_Action.jsp">
				<div class="form-style-4-heading">Place a bid greater than the
					current bid to become the winner of this item!</div>
				<div class="form-style-3-heading">**** Bids equal to or less
					than the current bid don't count ****</div>
				<table>
					<tr>
						<th>Item ID</th>
						<td><%=rs.getString("ITEM_ID")%></td>
					</tr>

					<tr>
						<th>Item Name</th>
						<td><%=rs.getString("ITEM_NAME")%></td>
					</tr>
					<tr>
						<th>Current Winning Bid</th>
						<td><%=rs.getString("CURRENT_BID")%></td>
					</tr>
					<tr>
						<th>New Bid</th>
						<td><input name="max_bid" MaxLength="10" value=""></td>
					</tr>

				</table>

				<!-- Update Profile Button -->

				<form method="GET" action="PlaceBid_Action.jsp">
					<input id="transID" name="itemID"
						value=<%=rs.getString("ITEM_ID")%> type="hidden"><br>

					<input name="Submit" value="Submit Bid" type="submit"><br>
				</form>

				<%
					}
						}
						rs.close();

					} catch (IllegalStateException ise) {
						out.println(ise.getMessage());
					}
				%>
			
	</div>

</body>
</html>