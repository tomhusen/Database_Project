<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="user" class="GABES.User" scope="session" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>Update Profile</title>
</head>
<body>
	<div class="form-style-2">
		<!-- Heading at top of the page -->
		<div class="form-style-2-heading">Update Information Below</div>
		
		<% try{
    		ResultSet rs = user.getUserInfo(); 
    		while (rs.next()) {
		%>
		
		<form method="post" action="Update_Action.jsp" name="EditForm">
			USER ID <input readonly="readonly" name="user_id" value="<%=rs.getString("USER_ID")%>"> <br> 
			USERNAME <input readonly="readonly" name="username" value="<%=rs.getString("USERNAME")%>"> <br> 
			EMAIL <input name="email" value="<%=rs.getString("EMAIL")%>"> <br>
			PHONE <input name="phone" value="<%=rs.getString("PHONE")%>"> <br>
			FIRST <input name="first" value="<%=rs.getString("FIRST_N")%>"> <br> 
			LAST <input name="last" value="<%=rs.getString("LAST_N")%>"> <br>
			ADMIN NAME <input readonly="readonly" name="admin_username" value="<%=rs.getString("A_USERNAME")%>"> <br> 

			
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
			<form method="post" action="Welcome.jsp">
				<input name="Submit" value="Return to Menu" type="submit"><br>
			</form>
	</div>

</body>
</html>