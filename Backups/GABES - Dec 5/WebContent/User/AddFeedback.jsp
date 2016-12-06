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
				<ul>
			<li><a class="active" href="../Login_action.jsp">Home</a></li>
			<li class="dropdown"><a href="javascript:void(0)"
				class="dropbtn">My Profile</a>
				<div class="dropdown-content">
					<a href="UpdateProfile.jsp">Update My Profile</a> <a
						href="ViewMyFeedback.jsp">View My Feedback</a>
				</div></li>
			<!-- Items Menu -->
			<li class="dropdown"><a href="javascript:void(0)"
				class="dropbtn">Search</a>
				<div class="dropdown-content">
					<a href="../Item/Search.html">Search</a> <a
						href="../Item/ListOfItemsToBidOn.jsp">View All Listed Items</a>
				</div></li>
			<!-- Manage Sales Menu -->
			<li class="dropdown"><a href="javascript:void(0)"
				class="dropbtn">Manage My Sales</a>
				<div class="dropdown-content">
					<a href="../Item/ItemList.jsp">View My Listed Items</a> <a
						href="../Item/AddNewItem.jsp">List New Item</a>
				</div></li>
			<!-- Admin Dropdown Menu -->
			<li class="dropdown"><a href="javascript:void(0)"
				class="dropbtn">Admin Options</a>
				<div class="dropdown-content">
					<a href="AddNewUser.jsp">Add New User</a> <a
						href="AdminCommissionReport.jsp">View Commission Report</a> <a
						href="SalesSummary.jsp">View Sales Summary</a>
				</div></li>
			<li style="float: right"><a class="active"
				href="../Logout_action.jsp">Logout</a></li>
		</ul>
		<br>
		<div class="form-style-2-heading">Please Enter Information about User Below</div>
		
		<form method="GET" action="AddFeedback_Action.jsp">
		
<table class="inputTable">
			<tr>
				<th>Item ID</th>
				<td><input name="n_itemId" value=""></td>
			</tr><tr>
				<th>Item Name</th>
				<td><input name="n_itemName" value=""></td>
			</tr><tr>
				<th>Overall Rating</th>
				<td><input name="n_overallRating" value=""></td>
			</tr><tr>
				<th>Item Quality</th>
				<td><input type = "radio" name="n_itemQuality" value="1">1
				<input type = "radio" name="n_itemQuality" value="2">2
				<input type = "radio" name="n_itemQuality" value="3">3
				<input type = "radio" name="n_itemQuality" value="4">4
				<input type = "radio" name="n_itemQuality" value="5">5</td>
			</tr><tr>
				<th>Delivery</th>
				<td><input type = "radio" name="n_delivery" value="1">1
				<input type = "radio" name="n_delivery" value="2">2
				<input type = "radio" name="n_delivery" value="3">3
				<input type = "radio" name="n_delivery" value="4">4
				<input type = "radio" name="n_delivery" value="5">5</td>
			</tr><tr>
				<th>Comment</th>
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