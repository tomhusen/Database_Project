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
				class="dropbtn">My Profile</a>
				<div class="dropdown-content">
					<a href="UpdateProfile.jsp">Update My Profile</a> <a
						href="ViewMyFeedback.jsp">View My Feedback</a>
				</div></li>
			<!-- Items Menu -->
			<li class="dropdown"><a href="javascript:void(0)"
				class="dropbtn">Search</a>
				<div class="dropdown-content">
					<a href="../Item/Search.html">Search</a> <a
						href="../Item/ListOfItemsToBidOn.jsp">View All Listed Items</a>
				</div></li>
			<!-- Manage Sales Menu -->
			<li class="dropdown"><a href="javascript:void(0)"
				class="dropbtn">Manage My Sales</a>
				<div class="dropdown-content">
					<a href="../Item/ItemList.jsp">View My Listed Items</a> <a
						href="../Item/AddNewItem.jsp">List New Item</a>
				</div></li>
				<%
				if(user.isThisUserAdmin()){
				%>
			<!-- Admin Dropdown Menu -->
			<li class="dropdown"><a href="javascript:void(0)"
				class="dropbtn">Admin Options</a>
				<div class="dropdown-content">
					<a href="AddNewUser.jsp">Add New User</a> <a
						href="AdminCommissionReport.jsp">View Commission Report</a> <a
						href="../User/SalesSummary.jsp">View Sales Summary</a>
				</div></li>
				<%} %>
				
			<li style="float: right"><a class="active"
				href="../Logout_action.jsp">Logout</a></li>
		</ul>
	<div class="form-style-2-heading">
		<%=user.getUsername()%>'s Listed Items</div>
	<table class="resultTable">


		<tbody>


			<tr>
				<th>Item ID<br></th>
				<th>Item Name<br></th>
				<th>Auction Start Time<br></th>
				<th>Auction End Time<br></th>
				<th>Start Price<br></th>
				<th>Current Bid<br></th>
				<th>Status<br></th>
				<th><br></th>
				<th><br></th>
			</tr>
			<%

				try {
					item.updateTime();
					ResultSet rs = item.getAllItems(user.getUserID());
					while (rs.next()) {
			%>


			<tr>
				<td><%=rs.getString("ITEM_ID")%></td>
				<td><%=rs.getString("ITEM_NAME")%></td>
				<td><%=rs.getTimestamp("START_DATE")%></td>
				<td><%=rs.getTimestamp("END_DATE")%></td>
				<td><%=rs.getDouble("START_PRICE")%></td>
				<td><%=rs.getDouble("CURRENT_BID")%></td>
				<td><%=rs.getInt("STATUS")%></td>
				<td>
					<!-- passes the item number to the item info page (look at transactions example) -->
					<form method="GET" action="ItemInfo.jsp">
						<input id="itemID" name="id"
							value=<%=rs.getString("ITEM_ID")%> type="hidden"><br>
						<input value="Item Info" type="submit">
					</form>
				</td>
				<!-- passes the user number to the bidder list -->
				<td style="vertical-align: top;">
					<form method="GET" action="BidderList.jsp">
						<input id="transID" name="transNumber"
							value=<%=rs.getString("ITEM_ID")%> type="hidden"><br>
						<input value="Bidder List" type="submit">
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

	<br>
	<br>



	<form method="post" action="../Login_action.jsp">
		<input name="Submit" value="Back to menu" type="submit"><br>
	</form>
	</div>
</body>
</html>