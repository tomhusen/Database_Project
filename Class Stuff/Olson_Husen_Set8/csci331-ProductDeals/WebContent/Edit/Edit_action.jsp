<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="customer" class= "productdeals.Customer" scope="session"/> 
<jsp:setProperty name="customer" property="*"/> 

<%try{
	customer.editCustomerInfo();
	}	
	catch(IllegalStateException ise){
		out.println(ise.getMessage());
	}
	response.sendRedirect("Edit.jsp");

%> 
