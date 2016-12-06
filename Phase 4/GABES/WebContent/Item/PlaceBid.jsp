<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="item" class="GABES.Item" scope="session" />
<jsp:useBean id="bid" class="GABES.Bid" scope="session" />
<jsp:setProperty name="bid" property="*" />
<jsp:setProperty name="item" property="*" />


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>Update Profile</title>
</head>
<body style="background-color: #a7adba">
	<div class="form-style-2">
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

			<table>
				<tr>
					<td>Item ID</td>
					<td><%=rs.getString("ITEM_ID")%></td>
				</tr>

				<tr>
					<td>Item Name</td>
					<td><%=rs.getString("ITEM_NAME")%></td>
				</tr>
				<tr>
					<td>Starting Price</td>
					<td><%=rs.getString("START_PRICE")%></td>
				</tr>
				<tr>
					<td>New Bid</td>
					<td><input name="max_bid" MaxLength="10" value=""></td>
				</tr>

			</table>

			<!-- Update Profile Button -->

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
						<td>Item ID</td>
						<td><%=rs.getString("ITEM_ID")%></td>
					</tr>

					<tr>
						<td>Item Name</td>
						<td><%=rs.getString("ITEM_NAME")%></td>
					</tr>
					<tr>
						<td>Current Winning Bid</td>
						<td><%=rs.getString("CURRENT_BID")%></td>
					</tr>
					<tr>
						<td>New Bid</td>
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



				<br>
				<!-- Return to previous menu button -->
				<form method="post" action="../Login_action.jsp">
					<input name="Submit" value="Return to Menu" type="submit"><br>
				</form>
	</div>

</body>
</html>