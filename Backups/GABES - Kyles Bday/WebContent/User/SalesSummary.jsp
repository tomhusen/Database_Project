<html>
<head>
<meta content="text/html; charset=ISO-8859-1" http-equiv="content-type">
<link rel="stylesheet" type="text/css" href="../potatoes.css">

<title>Sales Summary</title>
</head>
<body>
	<%@ page language="java" import="java.sql.*"%>
	<jsp:useBean id="item" class="GABES.Item" scope="session" />
	<jsp:useBean id="user" class="GABES.User" scope="session" />
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
		<br>
		<table>
			<tbody>
				<tr>
					<th>Category</th>
					<th>Item ID</th>
					<th>Item Name</th>
					<th>Selling Price</th>
					<th>Commission</th>
				</tr>

				<%
					try {
						item.updateTime();
						ResultSet rs = item.getAllItemsForSalesSummary();
						String currentCategory = "";
						double sellingPriceTotal = 0;
						double commissionsTotal = 0;
						while (rs.next()) {
							String sellingPrice = rs.getString("SELLING_PRICE");
							String commissionFee = rs.getString("COMMISSION_FEE");
							if (!currentCategory.equals(rs.getString("item_category"))) {
				%>
				<tr>
					<th><%=rs.getString("ITEM_CATEGORY")%></th>
					<td></td>
					<td></td>
					<td><br></td>
					<td><br></td>
				</tr>
				<%
					currentCategory = rs.getString("item_category");
							}
				%>
				<tr>
					<td><br></td>
					<td><%=rs.getString("ITEM_ID")%></td>
					<td><%=rs.getString("ITEM_NAME")%></td>
					<td><%=sellingPrice%></td>
					<td><%=commissionFee%></td>

				</tr>
				<%
					if (sellingPrice != null) {
								sellingPriceTotal += Double.parseDouble(sellingPrice);
							}
							if (commissionFee != null) {
								commissionsTotal += Double.parseDouble(commissionFee);
							}

						}
						rs.close();
				%>

				<tr>
					<td></td>
					<th>TOTAL</th>
					<td></td>

					<td><%=sellingPriceTotal%></td>
					<td><%=commissionsTotal%></td>
				</tr>
				<%
					} catch (IllegalStateException ise) {
						out.println(ise.getMessage());
					}
				%>
			</tbody>
		</table>
		<br>
	</div>
</body>
</html>