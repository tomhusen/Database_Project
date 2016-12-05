<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="feedback" class= "GABES.Feedback" scope="session"/> 
<jsp:setProperty name="user" property="*"/> 

<%
	String n_itemId = request.getParameter("n_itemId");
	String n_itemQuality = request.getParameter("n_itemQuality");
	String n_delivery = request.getParameter("n_delivery");
	String n_overallRating = request.getParameter("n_overallRating");
	String n_comment = request.getParameter("n_comment");

	try{
		feedback.addNewFeedback(n_itemId,n_itemQuality,n_delivery,n_overallRating,n_comment);
	}	
	catch(IllegalStateException ise){
		out.println(ise.getMessage());
	}
	response.sendRedirect("../Login_action.jsp");
%> 