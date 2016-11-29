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
				<td style="vertical-align: top;">TRANS DATE<br>
				</td>
				<td style="vertical-align: top;">TRANS NUMBER<br>
				</td>
				<td style="vertical-align: top;">TOTAL<br>
				</td>
				<td style="vertical-align: top;"><br></td>
			</tr>
			<%
				try {
					ResultSet rs = customer.getAllTransactions();
					while (rs.next()) {
			%>


			<tr>
				<td style="vertical-align: top;"><br> <%=rs.getDate("TRANS_DATE")%>
				</td>
				<td style="vertical-align: top;"><br> <%=rs.getString("TRANS_NUMBER")%>
				</td>
				<td style="vertical-align: top;"><br> <%=customer.getTransactionTotalValue(rs.getString("TRANS_NUMBER"))%>
				</td>
				<td style="vertical-align: top;">

					
					<form method="GET" action="ViewTransParts.jsp">
						<input id="transID" name="transNumber"
							value=<%=rs.getString("TRANS_NUMBER")%> type="hidden"><br>
							<input value="View" type="submit">
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



	<form method="post" action="../Welcome.jsp">
		<input name="Submit" value="Back to menu" type="submit"><br>
	</form>
</body>
</html>