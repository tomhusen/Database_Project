<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="item" class= "GABES.Item" scope="session"/> 
<jsp:setProperty name="item" property="*"/> 

<%try{
	//check item beans attributes...
	item.editItemInfo();
	}	
	catch(IllegalStateException ise){
		out.println(ise.getMessage());
	}
	response.sendRedirect("../Login_action.jsp");

%> 