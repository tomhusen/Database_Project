<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="user" class="GABES.User" scope="session" />
<jsp:setProperty name="user" property="*" />

<%	
	if (user.login()) {
		if(user.isThisUserAdmin()){
			response.sendRedirect("User/Admin_Welcome.jsp");
		} else {
			response.sendRedirect("User/Welcome.jsp");
		}
	} else {
		response.sendRedirect("index.html");
	}
%>