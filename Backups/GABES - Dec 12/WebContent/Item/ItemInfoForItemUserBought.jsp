<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="item1" class="GABES.Item" scope="request" />
<jsp:useBean id="user" class="GABES.User" scope="session" />
<jsp:setProperty name="item1" property="*" />


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>Update Profile</title>
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
		<br>
		<div class="form-style-2">
			<!-- Heading at top of the page -->
			<div class="form-style-2-heading">Item Info -- Change info and
				click update to to save new values</div>

			<%
				String itemID = request.getParameter("id");

				try {
					item1.updateTime();
					ResultSet rs = item1.getItemInfoToEdit(itemID);
					while (rs.next()) {
			%>


			<table class="resultTable">
				<tr>
					<th>Item ID</th>
					<td><%=rs.getString("ITEM_ID")%></td>
				</tr>
				<tr>
					<th>Item Name</th>
					<td><%=rs.getString("ITEM_NAME")%></td>
				</tr>
				<tr>
					<th>Category</th>
					<td><%=rs.getString("ITEM_CATEGORY")%></td>
				</tr>
				<tr>
					<th>Start Price</th>
					<td><%=rs.getString("START_PRICE")%></td>
				</tr>
				<tr>
					<th>Auction Starts</th>
					<td><%=rs.getString("START_DATE")%></td>
				</tr>
				<tr>
					<th>Auction Ends</th>
					<td><%=rs.getString("END_DATE")%></td>
				</tr>
				<tr>
					<th>Description</th>
					<td><%=rs.getString("DESCRIPTION")%></td>
				</tr>

			</table>


			<%
				}
					rs.close();
				} catch (IllegalStateException ise) {
					out.println(ise.getMessage());
				}
			%>
			<br>
			<form method="post" action="ItemListForItemsUserBought.jsp">
				<input name="Submit" value="Back to the Items You Have Won"
					type="submit"><br>
			</form>



		</div>
</body>
</html>