<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>Item List</title>
</head>

<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="item" class="GABES.Item" scope="page" />
<jsp:useBean id="user" class="GABES.User" scope="session" />
<jsp:useBean id="feedback" class="GABES.Feedback" scope="session" />

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
<br>
	<div class="form-style-2-heading">
		All of the items
		<%=user.getUsername()%>
		has won!
		<table class="resultTable">


			<tbody>


				<tr>
					<td style="vertical-align: top;">Item ID<br></td>
					<td style="vertical-align: top;">Item Name<br></td>
					<td style="vertical-align: top;">Category<br></td>
					<td style="vertical-align: top;">Auction End Time<br></td>
					<td style="vertical-align: top;">Final Price<br></td>
					<td style="vertical-align: top;">Seller Id<br></td>
					<td style="vertical-align: top;"><br></td>
					<td style="vertical-align: top;"><br></td>
				</tr>
				<%
					String userid = user.getUserID();
					try {
						item.updateTime();
						ResultSet rs = item.getAllItemsUserBought(userid);
						boolean flag = false;
						while (rs.next()) {
							String check = rs.getString("ITEM_ID");
							ResultSet rs2 = feedback.checkIfReviewHasBeenLeft();
							while (rs2.next()) {
								String check2 = rs2.getString("ITEM_ID");
								//System.out.println(check2 + "SECOND ITEM ID HERE    : " + check + " second value");
								if (check2.equals(check)) {
									flag = true;
								}
							}
							if (!flag) {
				%>


				<tr>
					<td style="vertical-align: top;"><br> <%=rs.getString("ITEM_ID")%></td>
					<td style="vertical-align: top;"><br> <%=rs.getString("ITEM_NAME")%></td>
					<td style="vertical-align: top;"><br> <%=rs.getString("ITEM_CATEGORY")%></td>
					<td style="vertical-align: top;"><br> <%=rs.getString("END_DATE")%></td>
					<td style="vertical-align: top;"><br> <%=rs.getString("CURRENT_BID")%></td>
					<td style="vertical-align: top;"><br> <%=rs.getString("USER_ID")%></td>
					<td style="vertical-align: top;">
						<!-- passes the item number to the item info page (look at transactions example) -->
						<form method="GET" action="ItemInfoForItemUserBought.jsp">
							<input id="itemID" name="id" value=<%=rs.getString("ITEM_ID")%>
								type="hidden"><br> <input value="Item Info"
								type="submit">
						</form>
					</td>
					<!-- passes the user number to the bidder list -->
					<td style="vertical-align: top;">
						<form method="GET" action="../User/AddFeedback.jsp">
							<input id="itemID" name="id" value=<%=rs.getString("ITEM_ID")%>
								type="hidden"><br> <input value="Rate Seller"
								type="submit">
						</form>
					</td>
				</tr>

				<%
					}
							if (flag) {
				%>

				<tr>
					<td style="vertical-align: top;"><br> <%=rs.getString("ITEM_ID")%></td>
					<td style="vertical-align: top;"><br> <%=rs.getString("ITEM_NAME")%></td>
					<td style="vertical-align: top;"><br> <%=rs.getString("ITEM_CATEGORY")%></td>
					<td style="vertical-align: top;"><br> <%=rs.getString("END_DATE")%></td>
					<td style="vertical-align: top;"><br> <%=rs.getString("CURRENT_BID")%></td>
					<td style="vertical-align: top;"><br> <%=rs.getString("USER_ID")%></td>
					<td style="vertical-align: top;">
						<!-- passes the item number to the item info page (look at transactions example) -->
						<form method="GET" action="ItemInfoForItemUserBought.jsp">
							<input id="itemID" name="id" value=<%=rs.getString("ITEM_ID")%>
								type="hidden"><br> <input value="Item Info"
								type="submit">
						</form>
					</td>
					<!-- passes the user number to the bidder list -->
					<td style="vertical-align: top;">Thanks for rating the seller!</td>
				</tr>


				<%
					}
							flag = false;
						}

						rs.close();
					}

					catch (IllegalStateException ise) {
						out.println(ise.getMessage());
					}
				%>

			</tbody>
		</table>
	</div>
</body>
</html>