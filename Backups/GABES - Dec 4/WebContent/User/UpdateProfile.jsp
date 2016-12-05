<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="user" class="GABES.User" scope="session" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>Update Profile</title>
</head>
<body style="background-color:#a7adba">
	<div class="form-style-2">
		<!-- Heading at top of the page -->
		<div class="form-style-2-heading">Update Information Below</div>
		
		<% try{
    		ResultSet rs = user.getUserInfo(); 
    		while (rs.next()) {
		%>
		
		<form method="post" action="Update_Action.jsp" name="EditForm">
		
<table cellpadding="7">
			<tr>
				<td>User ID</td>
				<td><%=rs.getString("USER_ID")%></td>
			</tr><tr>
				<td>Username</td>
				<td><%=rs.getString("USERNAME")%></td>
			</tr><tr>
				<td>Email Address</td>
				<td><input name="email"  MaxLength="30" value="<%=rs.getString("EMAIL")%>"></td>
			</tr><tr>
				<td>Phone Number</td>
				<td><input name="phone"  MaxLength="10" value="<%=rs.getString("PHONE")%>"></td>
			</tr><tr>
				<td>First Name</td>
				<td><input name="first"  MaxLength="12" value="<%=rs.getString("FIRST_N")%>"></td>
			</tr><tr>
				<td>Last Name</td>
				<td><input name="last" MaxLength="12" value="<%=rs.getString("LAST_N")%>"></td>
			</tr><tr>
				<td>Creation Admin</td>
				<td><%=rs.getString("A_USERNAME")%></td>
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