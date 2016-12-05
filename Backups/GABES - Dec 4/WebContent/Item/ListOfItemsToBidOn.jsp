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
	<div class="form-style-2-heading">
		All of the items currently up for sale
	</div>
	<table style="text-align: left; width: 100%;" border="1"
		cellpadding="2" cellspacing="2">


		<tbody>


			<tr style="background-color: #fc9749">
				<td style="vertical-align: top;">Item ID<br></td>
				<td style="vertical-align: top;">Item Name<br></td>
				<td style="vertical-align: top;">Category<br></td>
				<td style="vertical-align: top;">Auction Start Time<br></td>
				<td style="vertical-align: top;"><br>Auction End Time</td>
				<td style="vertical-align: top;"><br>Current Bid</td>
				<td style="vertical-align: top;"><br></td>
				<td style="vertical-align: top;"><br></td>
			</tr>
			<%
				try {
					ResultSet rs = item.getAllItems();
					while (rs.next()) {
			%>


			<tr style="background-color: #e9eadd">
				<td style="vertical-align: top;"><br> <%=rs.getString("ITEM_ID")%></td>
				<td style="vertical-align: top;"><br> <%=rs.getString("ITEM_NAME")%></td>
				<td style="vertical-align: top;"><br> <%=rs.getString("ITEM_CATEGORY")%></td>
				<td style="vertical-align: top;"><br> <%=rs.getDate("START_DATE")%></td>
				<td style="vertical-align: top;"><br> <%=rs.getDate("END_DATE")%></td>
				
				<td style="vertical-align: top;"><br> <%=rs.getDouble("CURRENT_BID")%></td>
				
				<td style="vertical-align: top;">
					<!-- passes the item number to the item info page (look at transactions example) -->
					<form method="GET" action="ItemInfoForSaleList.jsp">
						<input id="itemID" name="id"
							value=<%=rs.getString("ITEM_ID")%> type="hidden"><br>
						<input value="Item Info" type="submit">
					</form>
				</td>
				<!-- passes the user number to the bidder list -->
				<td style="vertical-align: top;">
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

	<br>
	<br>



	<form method="post" action="../Login_action.jsp">
		<input name="Submit" value="Back to menu" type="submit"><br>
	</form>
</body>
</html>