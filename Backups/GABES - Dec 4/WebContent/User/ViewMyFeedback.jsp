
<html>
<head>
<meta content="text/html; charset=ISO-8859-1" http-equiv="content-type">
<link rel="stylesheet" type="text/css" href="../potatoes.css">
<title>My Feedback</title>
</head>
<body style="background-color:#a7adba">
<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="user" class="GABES.User" scope="session" />
<jsp:useBean id="feedback" class="GABES.Feedback" scope="session"/>


<table cellpadding="7" border="1">
  <tbody>
    <tr>
      	<td style="vertical-align: top;">Rater Username<br> 
      	</td>
      	<td style="vertical-align: top;">Item Number<br>
      	</td>
     	 <td style="vertical-align:top;">Overall Rating<br>
      	</td>
      	<td style="vertical-align: top;">Item Quality<br>
      	</td>
      	<td style="vertical-align: top;">Delivery<br>
      	</td>
      	<td style="vertical-align: top;">Comments<br>
      	</td>
      	
   </tr>

    <% 
    System.out.println(user.getUserID());
    try{
        ResultSet rs = feedback.getFeedbackInfoWithRater(user.getUserID());

    while (rs.next()) {
	%>
	<tr>
     	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
     		<%=rs.getString("WINNER_ID")%><br>
     	</td>
     	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
     		<%=rs.getString("ITEM_ID")%><br>
     	</td>
     	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
     		<%=rs.getString("OVERALL_RATING")%><br>
     	</td>
     	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
     		<%=rs.getString("ITEM_QUALITY")%><br>
     	</td>
     	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
     		<%=rs.getString("COMMENTS")%><br>
     	</td>
     	
    </tr>
    <%} rs.close();}

    catch(IllegalStateException ise){
        out.println(ise.getMessage());
    }

	%>

    
    
  </tbody>
</table>
			<!-- Return to previous menu button -->
			<form method="post" action="../Login_action.jsp">
				<input name="Submit" value="Return to Menu" type="submit"><br>
			</form>

</body>
</html>