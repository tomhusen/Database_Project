<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="item1" class= "GABES.Item" scope="request"/> 
<jsp:setProperty name="item1" property="*"/> 

<%try{
	//check item beans attributes...
	item1.editItemInfo();
	}	
	catch(IllegalStateException ise){
		out.println(ise.getMessage());
	}
	response.sendRedirect("../Login_action.jsp");

%> 