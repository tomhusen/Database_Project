<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="feedback" class="GABES.Feedback" scope="session" />
<jsp:useBean id="item" class="GABES.Item" scope="session" />
<jsp:useBean id="user" class="GABES.User" scope="session" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>Add Feedback</title>
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

		<!-- Heading at top of the page -->
		<div class="form-style-2-heading">Please Enter Information about
			User Below</div>

		<form method="GET" action="AddFeedback_Action.jsp">
			<%
				String itemID = request.getParameter("id");

				try {
					item.updateTime();
					ResultSet rs = item.getNameForFeedBack(itemID);
					while (rs.next()) {
			%>
			<table>
				<tr>
					<th>Item ID</th>
					<td><input name="n_itemId"
						value="<%=rs.getString("ITEM_ID")%>" type="hidden"><%=rs.getString("ITEM_ID")%></td>
				</tr>
				<tr>
					<th>Item Name</th>
					<td><%=rs.getString("ITEM_NAME")%></td>
				</tr>
				<tr>
					<th>Overall Rating</th>
					<td><input type="radio" name="n_overallRating" value="1"
						checked="checked" />1 <input type="radio" name="n_overallRating"
						value="2">2 <input type="radio" name="n_overallRating"
						value="3">3 <input type="radio" name="n_overallRating"
						value="4">4 <input type="radio" name="n_overallRating"
						value="5">5 <input type="radio" name="n_overallRating"
						value="6">6 <input type="radio" name="n_overallRating"
						value="7">7 <input type="radio" name="n_overallRating"
						value="8">8 <input type="radio" name="n_overallRating"
						value="9">9 <input type="radio" name="n_overallRating"
						value="10">10</td>
				</tr>
				<tr>
					<th>Item Quality</th>
					<td><input type="radio" name="n_itemQuality" value="1"
						checked="checked" />1 <input type="radio" name="n_itemQuality"
						value="2">2 <input type="radio" name="n_itemQuality"
						value="3">3 <input type="radio" name="n_itemQuality"
						value="4">4 <input type="radio" name="n_itemQuality"
						value="5">5 <input type="radio" name="n_itemQuality"
						value="6">6 <input type="radio" name="n_itemQuality"
						value="7">7 <input type="radio" name="n_itemQuality"
						value="8">8 <input type="radio" name="n_itemQuality"
						value="9">9 <input type="radio" name="n_itemQuality"
						value="10">10</td>
				</tr>
				<tr>
					<th>Delivery</th>
					<td><input type="radio" name="n_delivery" value="1"
						checked="checked" />1 <input type="radio" name="n_delivery"
						value="2">2 <input type="radio" name="n_delivery"
						value="3">3 <input type="radio" name="n_delivery"
						value="4">4 <input type="radio" name="n_delivery"
						value="5">5 <input type="radio" name="n_delivery"
						value="6">6 <input type="radio" name="n_delivery"
						value="7">7 <input type="radio" name="n_delivery"
						value="8">8 <input type="radio" name="n_delivery"
						value="9">9 <input type="radio" name="n_delivery"
						value="10">10</td>
				</tr>
				<tr>
					<td>Comment</td>
					<td><input name="n_comment" value=""></td>
				</tr>


			</table>

			<%
				}
				}

				catch (IllegalStateException ise) {
					out.println(ise.getMessage());
				}
			%>
			<!-- Add User Button -->
			<form method="post" action="AddFeedback_Action.jsp">
				<input name="Submit" value="Rate" type="submit"><br>
			</form>
	</div>

</body>
</html>