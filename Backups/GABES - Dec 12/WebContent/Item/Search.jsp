<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="user" class="GABES.User" scope="session" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>Search for Items</title>
</head>
<body style="background-color: #a7adba">
	<div class="form-style-2">
		<ul>
			<li><a class="active" href="../Login_action.jsp">Home</a></li>
			<li class="dropdown"><a href="javascript:void(0)"
				class="dropbtn">My GABeS</a>
				<div class="dropdown-content">
					<a>User: <%=user.getUsername()%></a> <a
						href="../User/UpdateProfile.jsp">Update My Profile</a> <a
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

		<form method="GET" action="SearchResults.jsp">
			<br>
			<table cellpadding="7">
				<tr>
					<th>Item ID</th>
					<td><input name="s_itemID" MaxLength="10" value="ID"></td>
				</tr>
				<tr>
					<th>Keyword</th>
					<td><input name="s_keyword" MaxLength="30" value="Keyword"></td>
				</tr>
				<tr>
					<th>Category</th>
					<td><input name="s_category" MaxLength="15" value="Category"></td>
				</tr>
				<tr>
					<th>Bid Range</th>
					<td><input name="s_lowBid" MaxLength="10" value="Min"></td>
					<td><input name="s_highBid" MaxLength="10" value="Max"></td>
				</tr>
				<tr>
					<th>End Date</th>
					<td><input name="month" MaxLength="2" value="MM"
						style="width: 25px;">- <input name="day" MaxLength="2"
						value="DD" style="width: 25px;">- <input name="year"
						MaxLength="4" value="YYYY" style="width: 50px;"></td>
				</tr>
			</table>
			<br>
			<form method="post" action="SearchResults.jsp">
				<input name="Submit" value="Search" type="submit">
			</form>
		</form>
	</div>
</body>
</html>