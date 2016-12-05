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
		
<table cellpadding="7">
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
				<td>End</td>
				<td>Date: 
				<input name="month" MaxLength="2" value="MM" style="width:25px;">-
				<input name="day" MaxLength="2" value="DD" style="width:25px;">-
				<input name="year" MaxLength="4" value="YYYY" style="width:50px;">
				
				Time (24Hr):
				<input name="hour" MaxLength="2" value="hh" style="width:25px;">:
				<input name="min" MaxLength="2" value="mm" style="width:25px;">:
				<input name="sec" MaxLength="2" value="ss" style="width:25px;">
				
				
				</td>
			</tr><tr>
				<td>Description</td>
				<td><textarea name="n_description" cols="50" rows="4" ></textarea></td>
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