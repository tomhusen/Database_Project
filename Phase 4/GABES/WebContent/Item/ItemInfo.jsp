<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="item" class="GABES.Item" scope="session" />


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>Update Profile</title>
</head>
<body style="background-color: #a7adba">
	<div class="form-style-2">
		<!-- Heading at top of the page -->
		<div class="form-style-2-heading">Item Info -- Change info and
			click update to to save new values</div>

		<% String itemID = request.getParameter("id");
		
			try{
    		ResultSet rs = item.getItemInfoToEdit(itemID); 
    		while (rs.next()) {
		%>

		
			<table>
				<tr>
					<td>Item ID</td>
					<td><input readonly="readonly" name="itemId"
						value="<%=rs.getString("ITEM_ID")%>"></td>
				</tr>
				<tr>
					<td>Item Name</td>
					<td><input name="itemName"
						value="<%=rs.getString("ITEM_NAME")%>"></td>
				</tr>
				<tr>
					<td>Category</td>
					<td><input name="categroy"
						value="<%=rs.getString("ITEM_CATEGORY")%>"></td>
				</tr>
				<tr>
					<td>Start Price</td>
					<td><input readonly="startPrice" name="phone" MaxLength="10"
						value="<%=rs.getString("START_PRICE")%>"></td>
				</tr>
				<tr>
					<td>Auction Starts</td>
					<td><input readonly="readonly" name="startDate" MaxLength="12"
						value="<%=rs.getString("START_DATE")%>"></td>
				</tr>
				<tr>
					<td>Auction Ends</td>
					<td><input name="endDate"
						value="<%=rs.getString("END_DATE")%>"></td>
				</tr>
				<tr>
					<td>Description</td>
					<td><input name="description" MaxLength="50"
						value="<%=rs.getString("DESCRIPTION")%>"></td>
				</tr>

			</table>


		<%
			}
				rs.close();
			} catch (IllegalStateException ise) {
				out.println(ise.getMessage());
			}
		%>
		<!--ITS NOT UPDATING-->
			<!-- Update Profile Button -->
			<form method="post" action="UpdateItem_Action.jsp">
				<input name="Submit" value="Update" type="submit"><br>
			</form>

			
			<!-- Return to previous menu button -->
			<form method="post" action="ItemList.jsp">
				<input name="Submit" value="Return to Item List" type="submit"><br>
			</form>
			<br>
			<br>
			<!-- Return to previous menu button -->
			<form method="post" action="../Login_action.jsp">
				<input name="Submit" value="Return to Menu" type="submit"><br>
			</form>
			
		
	</div>

</body>
</html>