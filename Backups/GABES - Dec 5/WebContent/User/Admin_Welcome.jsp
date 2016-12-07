
<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="user" class="GABES.User" scope="session" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>Welcome!</title>
</head>
<body style="background-color: #a7adba">
	<div class="form-style-2">
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
		<center>
			<h3>
				Welcome
				<%=user.getUsername()%>
			</h3>
		</center>
		
		 		<br>
				<form method="post" action="../Item/ItemList.jsp">
			<input name="Submit" value="View Current User's Listed Items" type="submit"><br>
		</form>
		<br>
		<form method="post" action="../Item/ItemListUserHasBidOn.jsp">
			<input name="Submit" value="View Items You Have Bid On" type="submit"><br>
		</form>
		<br>
		<form method="post" action="../Item/ListOfItemsToBidOn.jsp">
			<input name="Submit" value="View Items Up for Sale" type="submit"><br>
		</form>
		<br> <br> <br> <br>
	</div>
</body>
</html>


