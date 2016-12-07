<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="feedback" class="GABES.Feedback" scope="session" />
<jsp:useBean id="user" class="GABES.User" scope="session" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>Leave Feedback</title>
</head>
<body style="background-color: #a7adba">
	<div class="form-style-2">

		<ul>
			<li><a class="active" href="../Login_action.jsp">Home</a></li>
			<li class="dropdown"><a href="javascript:void(0)"
				class="dropbtn">My GABeS</a>
				<div class="dropdown-content">
					<a href="UpdateProfile.jsp">Update My Profile</a> <a
						href="ViewMyFeedback.jsp">View My Feedback</a>
				</div></li>
			<!-- Items Menu -->
			<li class="dropdown"><a href="javascript:void(0)"
				class="dropbtn">Shop</a>
				<div class="dropdown-content">
					<a href="../Item/Search.jsp">Search</a> <a
						href="../Item/ListOfItemsToBidOn.jsp">View All Listed Items</a> <a
						href="../Item/ItemListUserHasBidOn.jsp">View Items I Bid On</a> <a
						href="../Item/ItemListForItemsUserBought.jsp">View Items I Won</a>
				</div></li>
			<!-- Manage Sales Menu -->
			<li class="dropdown"><a href="javascript:void(0)"
				class="dropbtn">Sell</a>
				<div class="dropdown-content">
					<a href="../Item/AddNewItem.jsp">List New Item</a> <a
						href="../Item/ItemList.jsp">View My Listed Items</a>
				</div></li>
			<%
				if (user.isThisUserAdmin()) {
			%>
			<!-- Admin Dropdown Menu -->
			<li class="dropdown"><a href="javascript:void(0)"
				class="dropbtn">Admin Options</a>
				<div class="dropdown-content">
					<a href="AddNewUser.jsp">Add New User</a> <a
						href="AdminCommissionReport.jsp">View Commission Report</a> <a
						href="SalesSummary.jsp">View Sales Summary</a>
				</div></li>
			<%
				}
			%>
			<li style="float: right"><a class="active"
				href="../Logout_action.jsp">Logout</a></li>
		</ul>
		<form method="GET" action="AddFeedback_Action.jsp">
			<br>
			<table class="inputTable">
				<tr>
					<td>Item ID</td>
					<td><input name="n_itemId" value=""></td>
				</tr>
				<tr>
					<td>Item Name</td>
					<td><input name="n_itemName" value=""></td>
				</tr>
				<tr>
					<td>Overall Rating</td>
					<td><input name="n_overallRating" value=""></td>
				</tr>
				<tr>
					<td>Item Quality</td>
					<td><input type="radio" name="n_itemQuality" value="1">1</td>
					<td><input type="radio" name="n_itemQuality" value="2">2</td>
					<td><input type="radio" name="n_itemQuality" value="3">3</td>
					<td><input type="radio" name="n_itemQuality" value="4">4</td>
					<td><input type="radio" name="n_itemQuality" value="5">5</td>
				</tr>
				<tr>
					<td>Delivery</td>
					<td><input type="radio" name="n_delivery" value="1">1</td>
					<td><input type="radio" name="n_delivery" value="2">2</td>
					<td><input type="radio" name="n_delivery" value="3">3</td>
					<td><input type="radio" name="n_delivery" value="4">4</td>
					<td><input type="radio" name="n_delivery" value="5">5</td>
				</tr>
				<tr>
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