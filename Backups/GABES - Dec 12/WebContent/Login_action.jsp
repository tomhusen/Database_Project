<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="user" class="GABES.User" scope="session" />
<jsp:setProperty name="user" property="*" />

<%	
	if (user.login()) {
			response.sendRedirect("User/Welcome.jsp");
	} else {
		response.sendRedirect("index.html");
	}
%>