<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="user" class="GABES.User" scope="session" />
<jsp:useBean id="item" class="GABES.Item" scope="session" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>Add New Item</title>
</head>
<body style="background-color: #a7adba">
	<div class="form-style-2">
		<ul>
			<li><a class="active" href="../Login_action.jsp">Home</a></li>
			<li class="dropdown"><a href="javascript:void(0)"
				class="dropbtn">My GABeS</a>
				<div class="dropdown-content">
					<a href="../User/UpdateProfile.jsp">Update My Profile</a> <a
						href="../User/ViewMyFeedback.jsp">View My Feedback</a>
				</div></li>
			<!-- Items Menu -->
			<li class="dropdown"><a href="javascript:void(0)"
				class="dropbtn">Shop</a>
				<div class="dropdown-content">
					<a href="Search.jsp">Search</a> <a href="ListOfItemsToBidOn.jsp">View
						All Listed Items</a> <a href="ItemListUserHasBidOn.jsp">View Items
						I Bid On</a> <a href="ItemListForItemsUserBought.jsp">View Items I
						Won</a>
				</div></li>
			<!-- Manage Sales Menu -->
			<li class="dropdown"><a href="javascript:void(0)"
				class="dropbtn">Sell</a>
				<div class="dropdown-content">
					<a href="AddNewItem.jsp">List New Item</a> <a href="ItemList.jsp">View
						My Listed Items</a>
				</div></li>
			<%
				if (user.isThisUserAdmin()) {
			%>
			<!-- Admin Dropdown Menu -->
			<li class="dropdown"><a href="javascript:void(0)"
				class="dropbtn">Admin Options</a>
				<div class="dropdown-content">
					<a href="../User/AddNewUser.jsp">Add New User</a> <a
						href="../User/AdminCommissionReport.jsp">View Commission
						Report</a> <a href="../User/SalesSummary.jsp">View Sales Summary</a>
				</div></li>
			<%
				}
			%>
			<li style="float: right"><a class="active"
				href="../Logout_action.jsp">Logout</a></li>
		</ul>
		<!-- Heading at top of the page -->
		<br>
		<div class="form-style-2-heading">List New Item</div>

		<form method="GET" action="AddNewItem_Action.jsp">

			<table class="inputTable">
				<tr>
					<th>Item Name</th>
					<td><input name="n_itemName" MaxLength=30 value=""></td>
				</tr>
				<tr>
					<th>Category</th>
					<td><input name="n_category" MaxLength="15" value=""></td>
				</tr>
				<tr>
					<th>Starting Price</th>
					<td><input name="n_startPrice" MaxLength="10" value="" min=0
						max=99999.99></td>
				</tr>
				<tr>
					<th>End</th>
					<td>Date: <input name="month" MaxLength="2" value="MM"
						style="width: 25px;">- <input name="day" MaxLength="2"
						value="DD" style="width: 25px;">- <input name="year"
						MaxLength="4" value="YYYY" style="width: 50px;"> Time
						(24Hr): <input name="hour" MaxLength="2" value="hh"
						style="width: 25px;">: <input name="min" MaxLength="2"
						value="mm" style="width: 25px;">: <input name="sec"
						MaxLength="2" value="ss" style="width: 25px;">


					</td>
				</tr>
				<tr>
					<th>Description</th>
					<td><textarea name="n_description" cols="50" rows="4"></textarea></td>
				</tr>


			</table>
			<br>
			<p>
				

			<!-- Add User Button -->
			<form method="post" action="AddNewItem_Action.jsp">
				<input name="Submit" value="Post Item" type="submit"><br>
			</form>
			<Strong>Note:</Strong> Please fill out all fields</p>
	</div>

</body>
</html>