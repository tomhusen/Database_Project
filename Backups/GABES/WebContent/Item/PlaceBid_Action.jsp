<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="user" class= "GABES.User" scope="session"/> 
<jsp:useBean id="item" class= "GABES.Item" scope="session"/> 
<jsp:useBean id="bid" class="GABES.Bid" scope="session" />
<jsp:setProperty name="bid" property="*" />
 

<%try{	
	String maxBid = request.getParameter("max_bid");
	String itemID = request.getParameter("itemID");
	//item.updateCurrentBid("35", currentBid);
	//check to see if the bid_trigger will let you add an item less then the current bid
	bid.placeNewBid(itemID, user.getUserID(), maxBid);
	
	}	
	catch(IllegalStateException ise){
		out.println(ise.getMessage());
	}
	response.sendRedirect("../Login_action.jsp");

%> 