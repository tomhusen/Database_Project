<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="feedback" class="GABES.Feedback" scope="session" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>Add New User</title>
</head>
<body style="background-color:#a7adba">
	<div class="form-style-2">
		<!-- Heading at top of the page -->
		<div class="form-style-2-heading">Please Enter Information about User Below</div>
		
		<form method="GET" action="AddFeedback_Action.jsp">
		
<table cellpadding="7">
			<tr>
				<td>Item ID</td>
				<td><input name="n_itemId" value=""></td>
			</tr><tr>
				<td>Item Name</td>
				<td><input name="n_itemName" value=""></td>
			</tr><tr>
				<td>Overall Rating</td>
				<td><input name="n_overallRating" value=""></td>
			</tr><tr>
				<td>Item Quality</td>
				<td><input type = "radio" name="n_itemQuality" value="1">1</td>
				<td><input type = "radio" name="n_itemQuality" value="2">2</td>
				<td><input type = "radio" name="n_itemQuality" value="3">3</td>
				<td><input type = "radio" name="n_itemQuality" value="4">4</td>
				<td><input type = "radio" name="n_itemQuality" value="5">5</td>
			</tr><tr>
				<td>Delivery</td>
				<td><input type = "radio" name="n_delivery" value="1">1</td>
				<td><input type = "radio" name="n_delivery" value="2">2</td>
				<td><input type = "radio" name="n_delivery" value="3">3</td>
				<td><input type = "radio" name="n_delivery" value="4">4</td>
				<td><input type = "radio" name="n_delivery" value="5">5</td>
			</tr><tr>
				<td>Comment</td>
				<td><input name="n_comment" value=""></td>
			</tr>
		
		
		</table>

			<!-- Add User Button -->
			<form method="post" action="AddFeedback_Action.jsp">
				<input name="Submit" value="Rate" type="submit"><br>
			</form>
			<!-- Return to previous menu button -->
			<form method="post" action="../Login_action.jsp">
				<input name="Submit" value="Return to Menu" type="submit"><br>
			</form>
	</div>

</body>
</html>