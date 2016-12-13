<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="item1" class="GABES.Item" scope="request" />
<jsp:setProperty name="item1" property="*" />

<%
	try {
		//check item beans attributes...
		String itemID = request.getParameter("id");
		System.out.println("Action ID: " + itemID);
		String cat = request.getParameter("item_category");
		System.out.println("Action cat: " + cat);
		String desc = request.getParameter("item_description");
		System.out.println("Action desc: " + desc);
		String name = request.getParameter("item_name");
		System.out.println("Action name: " + name);
		String endDate = request.getParameter("end_date");
		System.out.println("Action endDate: " + endDate);

		item1.editItemInfo(itemID, cat, desc, name, endDate);
	} catch (IllegalStateException ise) {
		out.println(ise.getMessage());
	}
	response.sendRedirect("ItemList.jsp");
%>
