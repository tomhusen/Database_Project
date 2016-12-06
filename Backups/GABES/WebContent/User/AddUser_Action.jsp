<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="user" class= "GABES.User" scope="session"/> 
<jsp:setProperty name="user" property="*"/> 

<%
	String n_username = request.getParameter("n_username");
	String n_email = request.getParameter("n_email");
	String n_password = request.getParameter("n_password");
	String n_phone = request.getParameter("n_phone");
	String n_first = request.getParameter("n_first");
	String n_last = request.getParameter("n_last");
	String n_admin = request.getParameter("n_admin");
	String n_seller = request.getParameter("n_seller");
	String n_buyer = request.getParameter("n_buyer");

	try{
		user.addNewUser(n_username, n_email, n_password, n_phone, n_first, n_last, n_admin, n_seller, n_buyer);
	}	
	catch(IllegalStateException ise){
		out.println(ise.getMessage());
	}
	response.sendRedirect("../Login_action.jsp");
%> 
