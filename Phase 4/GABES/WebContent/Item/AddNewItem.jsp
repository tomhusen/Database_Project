<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="user" class="GABES.User" scope="session" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>List New Item</title>
</head>
<body style="background-color:#a7adba">
	<div class="form-style-2">
		<!-- Heading at top of the page -->
		<div class="form-style-2-heading">Please Fill Out a</div>
		
		<% try{
    		ResultSet rs = user.getUserInfo(); 
    		while (rs.next()) {
		%>
		
		<form method="post" action="Update_Action.jsp" name="EditForm">
		
		<table>
			<tr>
				<td>User ID</td>
				<td><input readonly="readonly" name="user_id" value="<%=rs.getString("USER_ID")%>"></td>
			</tr><tr>
				<td>Username</td>
				<td><input readonly="readonly" name="username" value="<%=rs.getString("USERNAME")%>"></td>
			</tr><tr>
				<td>Email Address</td>
				<td><input name="email" value="<%=rs.getString("EMAIL")%>"></td>
			</tr><tr>
				<td>Phone Number</td>
				<td><input name="phone" value="<%=rs.getString("PHONE")%>"></td>
			</tr><tr>
				<td>First Name</td>
				<td><input name="first" value="<%=rs.getString("FIRST_N")%>"></td>
			</tr><tr>
				<td>Last Name</td>
				<td><input name="last" value="<%=rs.getString("LAST_N")%>"></td>
			</tr><tr>
				<td>Creation Admin</td>
				<td><input readonly="readonly" name="admin_username" value="<%=rs.getString("A_USERNAME")%>"> </td>
			</tr> 

		</table>
		<%} 
    		rs.close();}
    	catch(IllegalStateException ise){
        	out.println(ise.getMessage());
    	}%>

			<!-- Update Profile Button -->
			<form method="post" action="Update_Action.jsp">
				<input name="Submit" value="Update" type="submit"><br>
			</form>
			<!-- Return to previous menu button -->
			<form method="post" action="../Login_action.jsp">
				<input name="Submit" value="Return to Menu" type="submit"><br>
			</form>
	</div>

</body>
</html>