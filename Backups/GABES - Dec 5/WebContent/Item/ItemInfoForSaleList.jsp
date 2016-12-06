<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="item" class="GABES.Item" scope="request" />


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>Item Information</title>
</head>
<body style="background-color: #a7adba">
	<div class="form-style-2">
		<!-- Heading at top of the page -->
		<div class="form-style-2-heading">Item Information</div>

		<% String itemID = request.getParameter("id");
		
			try{
			item.updateTime();
    		ResultSet rs = item.getItemInfoToEdit(itemID); 
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
			<!-- Return to previous menu button -->
			<form method="post" action="ListOfItemsToBidOn.jsp">
				<input name="Submit" value="Return to Item List" type="submit"><br>
			</form>
			<!-- Return to previous menu button -->
			<form method="post" action="../Login_action.jsp">
				<input name="Submit" value="Return to Menu" type="submit"><br>
			</form>
			
		
	</div>

</body>
</html>