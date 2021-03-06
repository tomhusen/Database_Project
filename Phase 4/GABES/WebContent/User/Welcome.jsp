
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
				class="dropbtn">My GABeS</a>
				<div class="dropdown-content">
					<a>User: <%=user.getUsername()%></a> <a href="UpdateProfile.jsp">Update
						My Profile</a> <a href="ViewMyFeedback.jsp">View My Feedback</a>
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
			<li class="searchField"> 		
			<form method="GET" action="../Item/QuickSearchResults.jsp">
				<a>
				<input name="s_keyword" placeholder="Search by Keyword"></a> 
				</form>
				</li>
			<li style="float: right"><a class="active"
				href="../Logout_action.jsp">Logout</a></li>
		</ul>
		<br>
		<center>
			<h3>
				Welcome
				<%=user.getUsername()%>
			</h3>
			<br>
			<p>
				<a href="../cats.html"><img src="../images/giphy.gif"
					height="200" width="200"></a>
			</p>

		</center>
	</div>
</body>
</html>


