<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="user" class="GABES.User" scope="session" />
<jsp:useBean id="item" class="GABES.Item" scope="session" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>Add New Item</title>
</head>
<body style="background-color:#a7adba">
	<div class="form-style-2">
		<!-- Heading at top of the page -->
		<div class="form-style-2-heading">Please Enter Information about Item Below</div>
		
		<form method="GET" action="AddNewItem_Action.jsp">
		
		<table>
			<tr>
				<td>Item Name</td>
				<td><input name="n_itemName" MaxLength=30 value=""></td>
			</tr><tr>
				<td>Category</td>
				<td><input name="n_category" MaxLength="15" value=""></td>
			</tr><tr>
				<td>Starting Price</td>
				<td><input name="n_startPrice" MaxLength="10" value=""></td>
			</tr><tr>
				<td>Start Date</td>
				<td><input type="time" name="n_startDate"></td>
			</tr><tr>
				<td>End Date</td>
				<td><input type="time" name="n_endDate"></td>
			</tr><tr>
				<td>Description</td>
				<td><input name="n_description" MaxLength="100" value=""></td>
			</tr> 
		
		
		</table>

			<!-- Add User Button -->
			<form method="post" action="AddNewItem_Action.jsp">
				<input name="Submit" value="Post Item" type="submit"><br>
			</form>
			<!-- Return to previous menu button -->
			<form method="post" action="../Login_action.jsp">
				<input name="Submit" value="Return to Menu" type="submit"><br>
			</form>
	</div>

</body>
</html>