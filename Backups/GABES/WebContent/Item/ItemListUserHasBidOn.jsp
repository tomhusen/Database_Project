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
		<!-- Heading at top of the page -->
		

		<%
			String itemID = request.getParameter("id");
		%>
		<div class="form-style-2-heading">List of Items <%=user.getUsername()%> Had Bid On</div>
		

		<table style="text-align: left; width: 100%;" border="1"
			cellpadding="2" cellspacing="2">


			<tbody>
				<tr style="background-color: #fc9749">
					<td style="vertical-align: top;">Item ID<br></td>
					<td style="vertical-align: top;">Item Name<br></td>
					<td style="vertical-align: top;">Item Category<br></td>
					<td style="vertical-align: top;">Start Date<br></td>
					<td style="vertical-align: top;">End Date<br></td>
					<td style="vertical-align: top;">Current Bid<br></td>
					<td style="vertical-align: top;"><br></td>
					<td style="vertical-align: top;">Winner Id<br></td>

				</tr>

				<%
					try {
						ResultSet rs = bid.itemsUserHasBidOn(user.getUserID());
						while (rs.next()) {
							String winner = rs.getString("WINNER_ID");
							if(winner == null){
								winner = "-";
							}
				%>

				<tr style="background-color: #e9eadd">
					<td style="vertical-align: top;"><br> <%=rs.getString("ITEM_ID")%></td>
					<td style="vertical-align: top;"><br> <%=rs.getString("ITEM_NAME")%></td>
					<td style="vertical-align: top;"><br> <%=rs.getString("ITEM_CATEGORY")%></td>
					<td style="vertical-align: top;"><br> <%=rs.getString("START_DATE")%></td>
					<td style="vertical-align: top;"><br> <%=rs.getString("END_DATE")%></td>
					<td style="vertical-align: top;"><br> <%=rs.getString("CURRENT_BID")%></td>
					<td style="vertical-align: top;"><br>
						<form method="post" action="ItemInfoForItemsUserBidOn.jsp">
							<input id="itemId" name="id"
								value=<%=rs.getString("ITEM_ID")%> type="hidden"><br>
							<input name="Submit" value="ItemInfo" type="submit"><br>
						</form></td>
					<td style="vertical-align: top;"><br> <%=winner%></td>

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
		<!-- Return to previous menu button -->

		<br> <br> <br>
		<!-- Return to previous menu button -->
		<form method="post" action="../Login_action.jsp">
			<input name="Submit" value="Return to Menu" type="submit"><br>
		</form>
	</div>

</body>
</html>