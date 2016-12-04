package GABES;

import java.io.Serializable;
import java.sql.CallableStatement;
//Load JDBC API functions
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


// import oracle.jdbc.*;

/**
 * This is a class that is going to be used for our web interface
 * for our GABES project
 * 
 * @author Team Potatoes (Grant Boyer, Kyle Olson, Thomas Husen)
 */
@SuppressWarnings("serial")
public class Item implements Serializable {

	/**
	 * The following variables correspond to fields in the GABES_USER database
	 * table
	 */
	private String item_id;
	private String item_category;
	private String status;
	private String selling_price;
	private String description;
	private String commission_fee;
	private String item_name;
	private String current_bid;
	private String start_price;
	private String start_date;
	private String end_date;
	private String user_id;
	private String winner_id;

	public String getItemID() {
		return item_id;
	}

	public void setItemID(String item_id) {
		this.item_id = item_id;
	}

	public String item_category() {
		return item_category;
	}

	public void setItemCategory(String item_category) {
		this.item_category = item_category;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getSellingPrice() {
		return selling_price;
	}

	public void setSellingPrice(String selling_price) {
		this.selling_price = selling_price;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getCommissionFee() {
		return commission_fee;
	}

	public void setCommissionFee(String commission_fee) {
		this.commission_fee = commission_fee;
	}

	public String getItemName() {
		return item_name;
	}

	public void setItemName(String item_name) {
		this.item_name = item_name;
	}

	public String getCurrentBid() {
		return current_bid;
	}

	public void setCurrentBid(String current_bid) {
		this.current_bid = current_bid;
	}

	public String getStartPrice() {
		return start_price;
	}

	public void setStartPrice(String start_price) {
		this.start_price = start_price;
	}

	public String getStartDate() {
		return start_date;
	}

	public void setStartDate(String start_date) {
		this.start_date = start_date;
	}

	public String getEndDate() {
		return end_date;
	}

	public void setIsBuyer(String end_date) {
		this.end_date = end_date;
	}
	
	public String getUserID() {
		return user_id;
	}

	public void setUserID(String user_id) {
		this.user_id = user_id;
	}
	
	public String getWinnerID() {
		return winner_id;
	}

	public void setWinnerID(String winner_id) {
		this.winner_id = winner_id;
	}

	/**
	 * Default Constructor for User class
	 * 
	 * No need for additional constructors
	 */
	public Item() {
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
	 * Method: getItemInfo()
	 * 
	 * The purpose of this method is to use the connection to our Oracle Database
	 * to get all of the information about an item, specified by their item_id
	 * 
	 * @return a ResultSet object containing the record for the matching
	 *         item from the GABES_ITEM table
	 */
	public ResultSet getItemInfo() throws SQLException {
		Connection con = openDBConnection();
		Statement stmt = con.createStatement();
		/** Proceeds if user is logged in */
		String queryString = "Select * From team1.GABES_ITEM i Where i.ITEM_ID='"
				+ this.item_id + "'";
		ResultSet result = stmt.executeQuery(queryString);
		return result;
	}
	
	/**
	 * Method: editItemInfo()
	 * 
	 * The purpose of this function is to update the information for a specific
	 * item in the database
	 * 
	 */
	public void editItemInfo() throws SQLException {
		Connection con = openDBConnection();
		String queryString = "Update team1.GABES_ITEM Set ITEM_CATEGORY=?, DESCRIPTION=?, ITEM_NAME=?";
		queryString += "Where ITEM_ID='" + this.item_id + "'";
		/** Clears parameters and then sets new values */
		PreparedStatement p_stmt = con.prepareCall(queryString);
		/** Set new attribute values */
		p_stmt.clearParameters();
		p_stmt.setString(1, this.item_category);
		p_stmt.setString(2, this.description);
		p_stmt.setString(3, this.item_name);
		/* Executes the Prepared Statement query */
		p_stmt.executeQuery();
		p_stmt.close();
	}

	/**
	 * Method: addNewItem()
	 * 
	 * The purpose of this function is to add a new user to the database
	 * 
	 */
	public void addNewItem(String n_itemCategory, String n_description, String n_itemName, String n_startPrice, 
			String n_endDate, String n_userID) throws SQLException {

		Connection con = openDBConnection();
		CallableStatement callStmt = con.prepareCall(" {call team1.POST_ITEM(?, ?, ?, ?, ?, ?)}");
		
		/** Defines attributes to pass to the SQL Procedure - as well as some default values */
		callStmt.setString(1, n_itemCategory);
		callStmt.setString(2, n_description);
		callStmt.setString(3, n_itemName);
		callStmt.setString(4, n_startPrice);
		callStmt.setString(5, n_endDate);
		callStmt.setString(6, n_userID);
		
		/* Executes the Prepared Statement query */
		callStmt.execute();
		callStmt.close();
	}
//	
////	/**
//	 * Method: getItemInfo()
//	 * 
//	 * @return a ResultSet containing all transactions made by the customer
//	 *         whose customer number is stored in class field customerNumber.
//	 * @throws IllegalStateException
//	 *             if then method is called when loggedIn = false
//	 */
//	public ResultSet getAllTransactions() throws IllegalStateException, SQLException {
//		/* Checks whether the user is logged in */
//		if (isLoggedIn() == false)
//			throw new IllegalStateException();
//		/* Opens Connection and creates a new Statement */
//		Connection con = openDBConnection();
//		Statement stmt = con.createStatement();
//		String queryString = "Select * From PRODUCTDEALS_TRANS ";
//		queryString += "Where CUSTOMER_NUMBER='" + this.customerNumber + "'";
//		ResultSet result = stmt.executeQuery(queryString);
//
//		return result;
//	}
//
//	/**
//	 *************************************** COMPLETE ME*************************************** This method uses a
//	 * Statement object to query the ProductDeals_TRANSPART table for all
//	 * transaction parts that belong to the transaction whose number is
//	 * specified as a parameter.
//	 * 
//	 * @param transNumber
//	 *            the transaction number for which we need all the transaction
//	 *            parts from table ProductDeals_TRANSPART
//	 * @return a ResultSet containing all transaction parts that belong to the
//	 *         transaction whose number is specified as a parameter.
//	 * @throws IllegalStateException
//	 *             if then method is called when loggedIn = false
//	 */
//	public ResultSet getTransactionParts(String transNumber) throws IllegalStateException, SQLException {
//		// Checks if user is currently logged in
//		if (isLoggedIn() == false)
//			throw new IllegalStateException();
//		// Open Connection, create Statment and Query
//		Connection con = openDBConnection();
//		Statement stmt = con.createStatement();
//		String queryString = "Select * From PRODUCTDEALS_TRANSPART Where TRANS_NUMBER='" + transNumber + "'";
//		// Executes the query, then returns the ResultSet
//		ResultSet result = stmt.executeQuery(queryString);
//		return result;
//	}
//
//	/**
//	 *************************************** COMPLETE ME*************************************** This method uses a
//	 * PreparedStatement object to call an SQL stored function Function
//	 * ProductDeals_getTransVal(transNum varchar) to get the total $ value for a
//	 * given transaction whose number is specified as a parameter.
//	 * 
//	 * @param transNumber
//	 *            the transaction number for which we need the total $ value
//	 * @return the total $ value for the transaction whose number is specified
//	 *         as a parameter.
//	 * @throws IllegalStateException
//	 *             if then method is called when loggedIn = false
//	 */
//	public double getTransactionTotalValue(String transNumber) throws IllegalStateException, SQLException {
//
//		if (isLoggedIn() == false)
//			throw new IllegalStateException();
//		double finalReturn = 0;
//
//		Connection con = openDBConnection();
//		String queryString = "Select ProductDeals_getTransVal(?) from dual";
//		/*
//		 * Declares PreparedStatement, clears the old values, and then passes
//		 * the new ones
//		 */
//		PreparedStatement p_stmt = con.prepareCall(queryString);
//		/* Set new attribute values */
//		p_stmt.clearParameters();
//		p_stmt.setString(1, transNumber);
//
//		/* Executes the Prepared Statement query */
//		ResultSet result = p_stmt.executeQuery();
//		if (result.next()) {
//			finalReturn = result.getDouble(1);
//			System.out.println(finalReturn);
//		}
//		return finalReturn;
//
//	}
//
//	public String getPartDescription(String partNumber) throws IllegalStateException, SQLException {
//
//		if (isLoggedIn() == false)
//			throw new IllegalStateException();
//		String finalReturn = "";
//
//		Connection con = openDBConnection();
//		String queryString = "Select PART_DESCRIPTION from PRODUCTDEALS_PART WHERE PART_NUMBER =?";
//		/*
//		 * Declares PreparedStatement, clears the old values, and then passes
//		 * the new ones
//		 */
//		PreparedStatement p_stmt = con.prepareCall(queryString);
//		/* Set new attribute values */
//		p_stmt.clearParameters();
//		p_stmt.setString(1, partNumber);
//
//		/* Executes the Prepared Statement query */
//		ResultSet result = p_stmt.executeQuery();
//		if (result.next()) {
//			finalReturn = result.getString(1);
//			System.out.println(finalReturn);
//		}
//		return finalReturn;
//
//	}
}
