<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="user" class= "GABES.User" scope="session"/> 
<jsp:setProperty name="user" property="*"/> 

<%try{
	user.editUserInfo();
	}	
	catch(IllegalStateException ise){
		out.println(ise.getMessage());
	}
	response.sendRedirect("UpdateProfile.jsp");

%> 
