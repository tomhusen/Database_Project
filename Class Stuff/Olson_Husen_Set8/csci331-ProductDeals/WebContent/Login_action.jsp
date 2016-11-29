<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="customer" class= "productdeals.Customer" scope="session"/> 
<jsp:setProperty name="customer" property="*"/> 

<%if (customer.login())
    response.sendRedirect("Welcome.jsp");
   else
    response.sendRedirect("index.jsp");
%> 


