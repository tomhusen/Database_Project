<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="user" class="GABES.User" scope="session"/>
<jsp:useBean id="item" class="GABES.Item" scope="session" />
<jsp:setProperty name="item" property="*"/> 

<%
	String n_category = request.getParameter("n_category");
	String n_description = request.getParameter("n_description");
	String n_itemName = request.getParameter("n_itemName");
	String n_startPrice = request.getParameter("n_startPrice");
	
	String e_month = request.getParameter("month");
	String e_day = request.getParameter("day");
	String e_year = request.getParameter("year");
	String e_hour = request.getParameter("hour");
	String e_min = request.getParameter("min");
	String e_second = request.getParameter("sec");
	String n_endDate = e_year+"-"+e_month+"-"+e_day+" "+e_hour+":"+e_min+":"+e_second;

	try{
		item.addNewItem(n_category, n_description, n_itemName, n_startPrice, n_endDate, user.getUserID());
		response.sendRedirect("ItemList.jsp");
	}	
	catch(java.lang.IllegalStateException ise){
		//out.println(ise.getMessage());
		response.sendRedirect("ListItemDateErrorPage.jsp");
	}catch(SQLDataException sde){
		response.sendRedirect("ListItemDateErrorPage.jsp");
		
	}catch(java.sql.SQLSyntaxErrorException sqlsee){
		response.sendRedirect("ListItemDateErrorPage.jsp");
	}
%> 
