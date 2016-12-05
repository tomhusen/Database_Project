<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="item" class="GABES.Item" scope="page" />

<%
	String s_itemID = request.getParameter("s_itemID");
	String s_keyword = request.getParameter("s_keyword");
	String s_category = request.getParameter("s_category");
	String s_lowBid = request.getParameter("s_lowBid");
	String s_highBid = request.getParameter("s_highBid");
	
	String s_month = request.getParameter("month");
	String s_day = request.getParameter("day");
	String s_year = request.getParameter("year");

	String s_endDate = s_year+"-"+s_month+"-"+s_day;
			
	try {
		item.search(s_itemID, s_keyword, s_category, s_lowBid, s_highBid, s_endDate);
	} catch (IllegalStateException ise) {
		out.println(ise.getMessage());
	}
	response.sendRedirect("../Login_action.jsp");
%>
