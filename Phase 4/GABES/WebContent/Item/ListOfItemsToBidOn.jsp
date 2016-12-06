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
		<div class="form-style-2-heading">All of the items currently up
			for sale</div>
		<table class="resultTable">
			<tbody>
				<tr>
					<th>Item ID</th>
					<th>Item Name</th>
					<th>Category</th>
					<th>Auction Start Time</th>
					<th>Auction End Time</th>
					<th>Current Bid</th>
					<th></th>
					<th></th>
				</tr>
				<%
					try {
						item.updateTime();
						ResultSet rs = item.getAllItems();
						while (rs.next()) {
				%>

				<tr>
					<td><%=rs.getString("ITEM_ID")%></td>
					<td><%=rs.getString("ITEM_NAME")%></td>
					<td><%=rs.getString("ITEM_CATEGORY")%></td>
					<td><%=rs.getDate("START_DATE")%></td>
					<td><%=rs.getDate("END_DATE")%></td>

					<td><%=rs.getDouble("CURRENT_BID")%></td>

					<td>
						<!-- passes the item number to the item info page (look at transactions example) -->
						<form method="GET" action="ItemInfoForSaleList.jsp">
							<input id="itemID" name="id" value=<%=rs.getString("ITEM_ID")%>
								type="hidden"><br> <input value="Item Info"
								type="submit">
						</form>
					</td>
					<!-- passes the user number to the bidder list -->
					<td>
						<form method="GET" action="PlaceBid.jsp">
							<input id="transID" name="transNumber"
								value=<%=rs.getString("ITEM_ID")%> type="hidden"><br>
							<input value="Place Bid" type="submit">
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
		<br> <br>
		<form method="post" action="../Login_action.jsp">
			<input name="Submit" value="Back to menu" type="submit"><br>
		</form>
	</div>
</body>
</html>