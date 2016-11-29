<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title>Edit Team</title>
</head>
<body>
<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="customer" class="productdeals.Customer" scope="session"/>
<% try{
    ResultSet rs = customer.getCustomerInfo(); 
    while (rs.next()) {
%>

<form method="post" action="Edit_action.jsp" name="EditForm">
    CUSTOMER NUMBER <input readonly="readonly" name="customerNumber" value="<%=rs.getString("CUSTOMER_NUMBER")%>"> <br>
    LAST NAME <input name="last" value="<%=rs.getString("LAST")%>"> <br>
    FIRST NAME <input name="first" value="<%=rs.getString("FIRST")%>"> <br>
    STREET <input name="street" value="<%=rs.getString("STREET")%>"> <br>
    CITY <input name="city" value="<%=rs.getString("CITY")%>"> <br>
    STATE <input name="state" value="<%=rs.getString("STATE")%>"> <br>
    ZIP CODE<input name="zipCode" value="<%=rs.getString("ZIP_CODE")%>"> <br>
    
    BALANCE <input readonly="readonly name="balance" value="<%=rs.getDouble("BALANCE")%>"> <br>
    CREDIT LIMIT <input readonly="readonly name="creditLimit" value="<%=rs.getDouble("CREDIT_LIMIT")%>"> <br>
    SALES REP Number <input readonly="readonly name="slsRepNumber" value="<%=rs.getDouble("SLSREP_NUMBER")%>"> <br>    
    
<input name="Submit" value="Edit Profile" type="submit"><br>
</form>
    
<form method="post" action="../Welcome.jsp">  
<input name="Submit" value="Back to menu" type="submit"><br>
</form>    
<%} rs.close();}

    catch(IllegalStateException ise){
        out.println(ise.getMessage());
    }

%>
</body>
</html>

