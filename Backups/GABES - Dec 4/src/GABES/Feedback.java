package GABES;

import java.io.Serializable;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * This is a class that is going to be used for our web interface
 * for our GABES project
 * 
 * @author Team Potatoes (Grant Boyer, Kyle Olson, Thomas Husen)
 */
@SuppressWarnings("serial")
public class Feedback {

	/**
	 * The following variables correspond to fields in the GABES_FEEDBACK database
	 * table
	 */
	private int item_id;
	private int item_quality;
	private int delivery;
	private int overall_rating;
	private String comments;
	
	public int getItem_id() {
		return item_id;
	}
	public void setItem_id(int item_id) {
		this.item_id = item_id;
	}
	public int getItem_quality() {
		return item_quality;
	}
	public void setItem_quality(int item_quality) {
		this.item_quality = item_quality;
	}
	public int getDelivery() {
		return delivery;
	}
	public void setDelivery(int delivery) {
		this.delivery = delivery;
	}
	public int getOverall_rating() {
		return overall_rating;
	}
	public void setOverall_rating(int overall_rating) {
		this.overall_rating = overall_rating;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	
	/**
	 * *****************************************************
	 * *****************************************************
	 * ********************** METHODS **********************
	 * *****************************************************
	 * *****************************************************
	 */

	/**
	 * Method: openDBConnection()
	 * 
	 * The purpose of this function is to open a connection to an oracle
	 * database, in this case our database with connection team1. Many of the
	 * other functions within this class use this method to establish a
	 * connection with our GABES database.
	 * 
	 * @return a Connection object to Oracle Database
	 */
	public Connection openDBConnection() {
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			Connection myConnection = DriverManager.getConnection(
					"jdbc:oracle:thin:@//cscioraclesrv.ad.csbsju.edu:1521/" + "csci.cscioraclesrv.ad.csbsju.edu",
					"team1", "Boh3P");
			return myConnection;
		} catch (Exception E) {
			E.printStackTrace();
		}
		return null;
	}
	
	/**
	 * Method: getFeedbackInfo()
	 * 
	 * The purpose of this method is to use the connection to our Oracle Database
	 * to get all of the information about a feedback, specified by their user_id
	 * 
	 * @return a ResultSet object containing the record for the matching
	 *         feedback from the GABES_FEEDBACK table
	 */
	public ResultSet getFeedbackInfo() throws IllegalStateException, SQLException {
		Connection con = openDBConnection();
		Statement stmt = con.createStatement();
		/** Proceeds if user is logged in */
		String queryString = "Select * From team1.GABES_FEEDBACK i Where i.ITEM_ID='"
				+ this.item_id + "'";
		ResultSet result = stmt.executeQuery(queryString);
		return result;
	}
	
	/**
	 * Method: getFeedbackInfoWithRater()
	 * 
	 * The purpose of this method is to use the connection to our Oracle Database
	 * to get all of the information about a feedback, specified by their user_id
	 * and also include who bought it
	 * 
	 * @return a ResultSet object containing the record for the matching
	 *         feedback from the GABES_FEEDBACK table
	 */
	public ResultSet getFeedbackInfoWithRater(String userID) throws IllegalStateException, SQLException {
		//this.item_id = 0;
		System.out.println(this.item_id);
		Connection con = openDBConnection();
		Statement stmt = con.createStatement();
		/** Proceeds if user is logged in */
		String queryString = "SELECT b.WINNER_ID, a.ITEM_ID, a.OVERALL_RATING, a.ITEM_QUALITY, a.DELIVERY, a.COMMENTS "
				+ "FROM team1.GABES_FEEDBACK a, team1.GABES_ITEM b "
				+ "WHERE  a.ITEM_ID = b.ITEM_ID AND b.USER_ID ='"+userID+"'";
		ResultSet result = stmt.executeQuery(queryString);
		return result;
	}
	
	/**
	 * Method: editFeedbackInfo()
	 * 
	 * The purpose of this function is to update the information for a feedback
	 * in the database
	 * 
	 */
	public void editFeedbackInfo() throws IllegalStateException, SQLException {
		Connection con = openDBConnection();
		String queryString = "Update team1.GABES_FEEDBACK Set ITEM_ID=?, ITEM_QUALITY=?, DELIVERY=?, OVERALL_RATING=?, COMMENTS=?";
		queryString += "Where ITEM_ID='" + this.item_id + "'";
		/** Clears parameters and then sets new values */
		PreparedStatement p_stmt = con.prepareCall(queryString);
		/** Set new attribute values */
		p_stmt.clearParameters();
		p_stmt.setInt(1, this.item_id);
		p_stmt.setInt(2, this.item_quality);
		p_stmt.setInt(3, this.delivery);
		p_stmt.setInt(4, this.overall_rating);
		p_stmt.setString(5, this.comments);
		/* Executes the Prepared Statement query */
		p_stmt.executeQuery();
		p_stmt.close();
	}
	
	/**
	 * Method: addNewFeedback()
	 * 
	 * The purpose of this function is to add a new feedback to the database
	 * 
	 */
	public void addNewFeedback(String n_itemId, String n_itemQuality, String n_delivery, String n_overallRating, 
			String n_comments) throws SQLException {
		
		Connection con = openDBConnection();
		CallableStatement callStmt = con.prepareCall(" {call team1.GABES_LEAVE_FEEDBACK(?, ?, ?, ?, ?)}");

		callStmt.setString(1, n_itemId);
		callStmt.setString(2, n_itemQuality);
		callStmt.setString(3, n_delivery);
		callStmt.setString(4, n_overallRating);
		callStmt.setString(5, n_comments);
		/* Executes the Prepared Statement query */
		callStmt.execute();
		callStmt.close();
	}
	
}
