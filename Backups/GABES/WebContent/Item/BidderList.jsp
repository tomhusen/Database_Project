<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="bid" class="GABES.Bid" scope="session" />


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>Update Profile</title>
</head>
<body style="background-color: #a7adba">
	<div class="form-style-2">
		<!-- Heading at top of the page -->
		<div class="form-style-2-heading">List of Bidders</div>

		<%
			String itemID = request.getParameter("id");
			
		%>
		<div class="form-style-4-heading">
			Item ID :
			<%=itemID%></div>

		<table style="text-align: left; width: 100%;" border="1"
			cellpadding="2" cellspacing="2">


			<tbody>
				<tr style="background-color: #fc9749">
					<td style="vertical-align: top;">Bidding Time<br></td>
					<td style="vertical-align: top;">Username<br></td>
					<td style="vertical-align: top;">Bid Placed<br></td>

				</tr>

				<%
					try {
						ResultSet rs = bid.bidderList(itemID);
						while (rs.next()) {
				%>


				<tr style="background-color: #e9eadd">
					<td style="vertical-align: top;"><br> <%=rs.getString("BIDDING_TIME")%></td>
					<td style="vertical-align: top;"><br> <%=rs.getString("USERNAME")%></td>
					<td style="vertical-align: top;"><br> <%=rs.getString("MAX_BID")%></td>

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
		<form method="post" action="ItemList.jsp">
			<input name="Submit" value="Return to Item List" type="submit"><br>
		</form>
		<br> <br> <br> 
		<!-- Return to previous menu button -->
		<form method="post" action="../Login_action.jsp">
			<input name="Submit" value="Return to Menu" type="submit"><br>
		</form>
	</div>

</body>
</html>