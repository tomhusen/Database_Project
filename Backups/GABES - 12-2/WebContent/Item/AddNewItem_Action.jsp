<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="user" class="GABES.User" scope="session"/>
<jsp:useBean id="item" class="GABES.Item" scope="session" />
<jsp:setProperty name="item" property="*"/> 

<%
	String n_category = request.getParameter("n_category");
	String n_description = request.getParameter("n_description");
	String n_itemName = request.getParameter("n_itemName");
	String n_startPrice = request.getParameter("n_startPrice");
	Timestamp n_startDate = request.getParameter("n_startDate");
	Timestamp n_endDate = request.getParameter("n_endDate");

	try{
		item.addNewItem(n_category, n_description, n_itemName, n_startPrice, n_startDate, n_endDate, user.getUserID());
	}	
	catch(IllegalStateException ise){
		out.println(ise.getMessage());
	}
	response.sendRedirect("../Login_action.jsp");
%> 
