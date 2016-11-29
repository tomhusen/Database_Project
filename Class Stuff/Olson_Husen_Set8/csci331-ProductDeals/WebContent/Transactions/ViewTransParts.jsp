<html>
<head>
<meta content="text/html; charset=ISO-8859-1" http-equiv="content-type">
<title></title>
</head>
<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="customer" class="productdeals.Customer" scope="session" />

<body>

	<table style="text-align: left; width: 100%;" border="1"
		cellpadding="2" cellspacing="2">


		<tbody>


			<tr>
				<td style="vertical-align: top;">PART NUMBER<br>
				</td>
				<td style="vertical-align: top;">PART DESCRIPTION<br>
				</td>
				<td style="vertical-align: top;">QUOTED PRICE<br>
				</td>
				<td style="vertical-align: top;"><br>NUBMER ORDERED</td>
			</tr>

			<%
				String hidden = request.getParameter("transNumber");
				try {
					ResultSet rs = customer.getTransactionParts(hidden);
					while (rs.next()) {
			%>

			<tr>
				<td style="vertical-align: top;"><br> <%=rs.getString("PART_NUMBER")%>
				</td>
				<td style="vertical-align: top;"><br> <%=customer.getPartDescription(rs.getString("PART_NUMBER"))%>
				</td>
				<td style="vertical-align: top;"><br> <%=rs.getString("QUOTED_PRICE")%>
				</td>
				<td style="vertical-align: top;"><br> <%=rs.getString("NUMBER_ORDERED")%>
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



	<form method="post" action="MyTransactions.jsp">
		<input name="Submit" value="Back to my transactions" type="submit"><br>
	</form>
</body>
</html>