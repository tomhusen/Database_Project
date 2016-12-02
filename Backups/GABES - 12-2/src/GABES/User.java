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
public class User implements Serializable {

	/**
	 * The following variables correspond to fields in the GABES_USER database
	 * table
	 */
	private String user_id;
	private String username;
	private String email;
	private String password;
	private String phone;
	private String first;
	private String last;
	private int is_Admin;
	private String admin_username;
	private int is_Seller;
	private int is_Buyer;
	/** Boolean for if the user is logged in */
	private boolean loggedIn = false;

	public String getUserID() {
		return user_id;
	}

	public void setUserID(String user_id) {
		this.user_id = user_id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getFirst() {
		return first;
	}

	public void setFirst(String first) {
		this.first = first;
	}

	public String getLast() {
		return last;
	}

	public void setLast(String last) {
		this.last = last;
	}

	public int getIsAdmin() {
		return is_Admin;
	}

	public void setIsAdmin(int is_Admin) {
		this.is_Admin = is_Admin;
	}

	public String getAdminUsername() {
		return admin_username;
	}

	public void setAdminUsername(String admin_username) {
		this.admin_username = admin_username;
	}

	public int getIsSeller() {
		return is_Seller;
	}

	public void setIsSeller(int is_Seller) {
		this.is_Seller = is_Seller;
	}

	public int getIsBuyer() {
		return is_Buyer;
	}

	public void setIsBuyer(int is_Buyer) {
		this.is_Buyer = is_Buyer;
	}

	/**
	 * Default Constructor for User class
	 * 
	 * No need for additional constructors
	 */
	public User() {
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
	 * Method: isLoggedIn()
	 * 
	 * This is a simple 'getter' method to determine whether the
	 * loggedIn variable is true (that is whether the user is 
	 * currently logged in)
	 * 
	 * @return whether the user is currently logged in
	 */
	public Boolean isLoggedIn() {
		return this.loggedIn;
	}

	/**
	 * Method: login()
	 * 
	 * @return 
	 */
	public boolean login() throws SQLException {
		Connection con = openDBConnection();
		String queryString = "Select * From team1.GABES_USER Where USERNAME=? and PASS=?";
		PreparedStatement p_stmt = con.prepareCall(queryString);
		/** Clears old, then sets new parameter values */
		p_stmt.clearParameters();
		p_stmt.setString(1, this.username);
		p_stmt.setString(2, this.password);
		ResultSet result = p_stmt.executeQuery();
		/** Checks the output of the query, sets loggedIn appropriately */
		if (result.next() == true) {
			this.loggedIn = true;
		} else {
			this.loggedIn = false;
		}
		p_stmt.close();		
		return this.loggedIn;
	}

	/**
	 * Method: logout()
	 * 
	 * This method will simply set the loggedIn variable to false 
	 * if the appropriate conditions are met. Also closes connection.
	 * 
	 * @throws IllegalStateException
	 *             if then method is called when loggedIn = false
	 */
	public void logout() throws IllegalStateException {
		if (!isLoggedIn())
			throw new IllegalStateException("Error: Cannot logout without being logged in");
		Connection con = openDBConnection();
		try {
			con.close();
		} catch (SQLException E) {
		}
		this.loggedIn = false;
	}
	
	/**
	 * Method: isThisUserAdmin()
	 * 
	 * @return 
	 */
	public boolean isThisUserAdmin() throws IllegalStateException, SQLException {
		if (isLoggedIn() == false)
			throw new IllegalStateException();
		Connection con = openDBConnection();
		Boolean adminVal = false;
		String queryString = "Select IS_ADMIN From team1.GABES_USER Where USERNAME=?";
		PreparedStatement p_stmt = con.prepareCall(queryString);
		/** Clears old, then sets new parameter values */
		p_stmt.clearParameters();
		p_stmt.setString(1, this.username);
		ResultSet result = p_stmt.executeQuery();
		/** Checks the output of the query, sets loggedIn appropriately */
		if (result.next()) {
			if(result.getInt(1)==1){
				this.is_Admin = 1;
				adminVal = true;
			}
		else {
			this.is_Admin = 0;
			adminVal = false;
		}}
		p_stmt.close();
		return adminVal;
	}

	/**
	 * Method: getUserInfo()
	 * 
	 * The purpose of this method is to use the connection to our Oracle Database
	 * to get all of the information about a user, specified by their user_id
	 * 
	 * @return a ResultSet object containing the record for the matching
	 *         customer from the GABES_USER table
	 * @throws IllegalStateException
	 *             if then method is called when loggedIn = false
	 */
	public ResultSet getUserInfo() throws IllegalStateException, SQLException {
		Connection con = openDBConnection();
		Statement stmt = con.createStatement();
		/** Checks the 'logged in' boolean */
		if (isLoggedIn() == false)
			throw new IllegalStateException();
		/** Proceeds if user is logged in */
		String queryString = "Select * From team1.GABES_USER u Where u.USERNAME='"
				+ this.username + "'";
		ResultSet result = stmt.executeQuery(queryString);
		return result;
	}
	
	/**
	 * Method: editUserInfo()
	 * 
	 * The purpose of this function is to update the information for a specific
	 * user in the database
	 * 
	 * @throws IllegalStateException
	 *             if then method is called when loggedIn = false
	 */
	public void editUserInfo() throws IllegalStateException, SQLException {
		if (isLoggedIn() == false)
			throw new IllegalStateException();
		Connection con = openDBConnection();
		String queryString = "Update team1.GABES_USER Set EMAIL=?, PASS=?, PHONE=?, FIRST_N=?, LAST_N=?";
		queryString += "Where USERNAME='" + this.username + "'";
		/** Clears parameters and then sets new values */
		PreparedStatement p_stmt = con.prepareCall(queryString);
		/** Set new attribute values */
		p_stmt.clearParameters();
		p_stmt.setString(1, this.email);
		p_stmt.setString(2, this.password);
		p_stmt.setString(3, this.phone);
		p_stmt.setString(4, this.first);
		p_stmt.setString(5, this.last);
		/* Executes the Prepared Statement query */
		p_stmt.executeQuery();
		p_stmt.close();
	}

	/**
	 * Method: addNewUser()
	 * 
	 * The purpose of this function is to add a new user to the database
	 * 
	 */
	public void addNewUser(String n_username, String n_email, String n_password, String n_phone, 
			String n_first, String n_last, String n_isAdmin, String n_isSeller, String n_isBuyer) throws SQLException {
		
		/** Cast Strings to ints */
//		char ni_isAdmin = n_isAdmin.charAt(0);
//		char ni_isSeller = n_isSeller.charAt(0);
//		char ni_isBuyer = n_isBuyer.charAt(0);

		Connection con = openDBConnection();
		CallableStatement callStmt = con.prepareCall(" {call team1.GABES_ADD_USER(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");

		callStmt.setString(1, n_username);
		callStmt.setString(2, n_email);
		callStmt.setString(3, n_password);
		callStmt.setString(4, n_phone);
		callStmt.setString(5, n_first);
		callStmt.setString(6, n_last);
		callStmt.setString(7, n_isAdmin);
		callStmt.setString(8, this.username);
		callStmt.setString(9, n_isSeller);
		callStmt.setString(10, n_isBuyer);
		/* Executes the Prepared Statement query */
		callStmt.execute();
		callStmt.close();
	}
	
//	/**
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
