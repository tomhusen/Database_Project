<html>
<head>
<meta content="text/html; charset=ISO-8859-1" http-equiv="content-type">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>My Feedback</title>
</head>
<body class="form-style-2-body">
	<div class="form-style-2">
		<%@ page language="java" import="java.sql.*"%>
		<jsp:useBean id="user" class="GABES.User" scope="session" />
		<jsp:useBean id="feedback" class="GABES.Feedback" scope="session" />
		<div class="form-style-2-heading">
			Feedback for
			<%=user.getUsername()%></div>
		<table>
			<tbody>
				<!-- Table Headers -->
				<tr>
					<th>Rater Username</th>
					<th>Item Number</th>
					<th>Overall Rating</th>
					<th>Item Quality</th>
					<th>Delivery</th>
					<th>Comments</th>
				</tr>

				<%
					try {
						ResultSet rs = feedback.getFeedbackInfoWithRater(user.getUserID());

						while (rs.next()) {
				%>
				<!-- Populates Table with Data -->
				<tr>
					<td><%=rs.getString("WINNER_ID")%></td>
					<td><%=rs.getString("ITEM_ID")%></td>
					<td><%=rs.getString("ITEM_QUALITY")%></td>
					<td><%=rs.getString("DELIVERY")%></td>
					<td><%=rs.getString("OVERALL_RATING")%></td>
					<td><%=rs.getString("COMMENTS")%></td>
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
		<!-- Return to Homepage -->
		<form method="post" action="../Login_action.jsp">
			<input name="Submit" value="Return to Menu" type="submit"><br>
		</form>
	</div>
</body>
</html>