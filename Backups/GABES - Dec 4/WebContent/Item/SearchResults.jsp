<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>Search Results</title>
</head>
<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="item" class="GABES.Item" scope="page" />

<body style="background-color: #a7adba">
	<div class="form-style-2-heading">Search Results</div>
	<table style="text-align: left; width: 100%;" border="1"
		cellpadding="2" cellspacing="2">
		<tbody>
			<tr style="background-color: #fc9749">
				<td style="vertical-align: top;">Item ID<br></td>
				<td style="vertical-align: top;">Item Name<br></td>
				<td style="vertical-align: top;">Auction Start Time<br></td>
				<td style="vertical-align: top;"><br>Auction End Time</td>
				<td style="vertical-align: top;"><br>Start Price</td>
				<td style="vertical-align: top;"><br>Current Bid</td>
				<td style="vertical-align: top;"><br>Status</td>
				<td style="vertical-align: top;"><br></td>
				<td style="vertical-align: top;"><br></td>
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

				String s_endDate = s_year + "-" + s_month + "-" + s_day;

				try {
					ResultSet rs = item.search(s_itemID, s_keyword, s_category, s_lowBid, s_highBid, s_endDate);
					while (rs.next()) {
			%>


			<tr style="background-color: #e9eadd">
				<td style="vertical-align: top;"><br> <%=rs.getString("ITEM_ID")%></td>
				<td style="vertical-align: top;"><br> <%=rs.getString("ITEM_NAME")%></td>
				<td style="vertical-align: top;"><br> <%=rs.getString("CATEGORY")%></td>
				<td style="vertical-align: top;"><br> <%=rs.getString("START_DATE")%></td>
				<td style="vertical-align: top;"><br> <%=rs.getString("END_DATE")%></td>
				<td style="vertical-align: top;"><br> <%=rs.getString("START_PRICE")%></td>
				<td style="vertical-align: top;"><br> <%=rs.getString("CURRENT_BID")%></td>
				<td style="vertical-align: top;"><br> <%=rs.getString("STATUS")%></td>
				<td style="vertical-align: top;">
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