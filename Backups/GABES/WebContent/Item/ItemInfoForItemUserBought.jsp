<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="item1" class="GABES.Item" scope="request" />
<jsp:setProperty name="item1" property="*"/> 


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
				item1.updateTime();
	    		ResultSet rs = item1.getItemInfoToEdit(itemID); 
    		while (rs.next()) {
		%>

		
			<table>
				<tr>
					<td>Item ID</td>
					<td><%=rs.getString("ITEM_ID")%></td>
				</tr>
				<tr>
					<td>Item Name</td>
					<td><%=rs.getString("ITEM_NAME")%></td>
				</tr>
				<tr>
					<td>Category</td>
					<td><%=rs.getString("ITEM_CATEGORY")%></td>
				</tr>
				<tr>
					<td>Start Price</td>
					<td><%=rs.getString("START_PRICE")%></td>
				</tr>
				<tr>
					<td>Auction Starts</td>
					<td><%=rs.getString("START_DATE")%></td>
				</tr>
				<tr>
					<td>Auction Ends</td>
					<td><%=rs.getString("END_DATE")%></td>
				</tr>
				<tr>
					<td>Description</td>
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
		<!--ITS NOT UPDATING-->
			<!-- Update Profile Button -->
			<form method="post" action="ItemListForItemsUserBought.jsp">
				<input name="Submit" value="Back to the Items You Have Won" type="submit"><br>
			</form>

			
		
	</div>

</body>
</html>