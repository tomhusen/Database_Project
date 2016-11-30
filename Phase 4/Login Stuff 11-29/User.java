package GABES;

import java.io.Serializable;
//Load JDBC API functions
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@SuppressWarnings("serial")
public class User implements Serializable {
	// The following correspond to columns in the GABES_USER table
	private String user_id;
	private String username;
	private String email;
	private String password;
	private String phone;
	private String first;
	private String last;
	private Integer is_Admin;
	private String admin_username;
	private Integer is_Seller;
	private Integer is_Buyer;

	// Boolean for if the user has successfully logged in or not - Initialized
	// to false
	private boolean loggedIn = false;

	/*
	 * ************************************************************
	 * ************************************************************
	 * ****************** SETTERS AND GETTERS *********************
	 * ************************************************************
	 * ************************************************************
	 */

	// Getter for user_id
	public String getUserID() {
		return user_id;
	}

	// Setter for user_id
	public void setUserID(String user_id) {
		this.user_id = user_id;
	}

	// Getter for username
	public String getUsername() {
		return username;
	}

	// Setter for username
	public void setUsername(String username) {
		this.username = username;
	}

	// Getter for email
	public String getEmail() {
		return email;
	}

	// Setter for email
	public void setEmail(String email) {
		this.email = email;
	}

	// Getter for password
	public String getPassword() {
		return password;
	}

	// Setter for password
	public void setPassword(String password) {
		this.password = password;
	}

	// Getter for phone
	public String getPhone() {
		return phone;
	}

	// Setter for phone
	public void setPhone(String phone) {
		this.phone = phone;
	}

	// Getter for first
	public String getFirst() {
		return first;
	}

	// Setter for first
	public void setFirst(String first) {
		this.first = first;
	}

	// Getter for last
	public String getLast() {
		return last;
	}

	// Setter for last
	public void setLast(String last) {
		this.last = last;
	}

	// Getter for is_Admin
	public Integer getIsAdmin() {
		return is_Admin;
	}

	// Setter for is_Admin
	public void setIsAdmin(Integer is_Admin) {
		this.is_Admin = is_Admin;
	}

	// Getter for admin_username
	public String getAdminUsername() {
		return admin_username;
	}

	// Setter for admin_username
	public void setAdminUsername(String admin_username) {
		this.admin_username = admin_username;
	}

	// Getter for is_Seller
	public Integer getIsSeller() {
		return is_Seller;
	}

	// Setter for is_Seller
	public void setIsSeller(Integer is_Seller) {
		this.is_Seller = is_Seller;
	}

	// Getter for is_Buyer
	public Integer getIsBuyer() {
		return is_Buyer;
	}

	// Setter for is_Seller
	public void setIsBuyer(Integer is_Buyer) {
		this.is_Buyer = is_Buyer;
	}

	/**
	 * Default constructor for the class No need for additional constructors
	 */
	public User() {
	}

	/**
	 * ************************************************************
	 * ************************************************************
	 * ************************ METHODS ***************************
	 * ************************************************************
	 * ************************************************************
	 */

	// Opens a connection to the Potatoes GABES database
	public Connection openDBConnection() {
		try {
			// Load driver and link to driver manager
			Class.forName("oracle.jdbc.OracleDriver");
			// Create a connection to the specified database
			Connection myConnection = DriverManager.getConnection(
					"jdbc:oracle:thin:@//cscioraclesrv.ad.csbsju.edu:1521/" + "csci.cscioraclesrv.ad.csbsju.edu",
					"team1", "Boh3P");
			return myConnection;
		} catch (Exception E) {
			E.printStackTrace();
		}
		return null;
	}

	// Getter for the isLoggedIn boolean
	public Boolean isLoggedIn() {
		return this.loggedIn;
	}

	/**
	 * Method: login()
	 *
	 * The purpose of this method is to use the GABES_USERLOGIN and
	 * GABES_ADMINLOGIN functions from the SQL Database. These functions take
	 * the username and password for a user and will return 1 for a valid login,
	 * and 0 for invalid login.
	 *
	 * @return true for successful login false for unsuccessful login
	 */
	public boolean login() throws SQLException {
		Connection con = openDBConnection();
//		String queryString = "Select team1.GABES_USERLOGIN(?, ?) from DUAL";
//		// If the user is an admin it will user the admin login function
//		if (is_Admin == 1) {
//			queryString = "Select team1.GABES_ADMINLOGIN(?, ?) from DUAL";
//		}
		
		String queryString = "Select * From team1.GABES_USER Where USERNAME=? and PASS=?";
		
		PreparedStatement p_stmt = con.prepareCall(queryString);
		/* Set new attribute values */
		p_stmt.clearParameters();
		p_stmt.setString(1, this.username);
		p_stmt.setString(2, this.password);
		ResultSet result = p_stmt.executeQuery();

		/* Checks output and sets boolean based on if the user is logged in */
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
	 * This method changes the isLoggedIn boolean to false, meaning the user is
	 * no longer logged in
	 *
	 * @throws IllegalStateException
	 *             - if the method is called when the isLoggedIn boolean is
	 *             already false (user is already not logged in)
	 */
	public void logout() throws IllegalStateException {
		if (!isLoggedIn())
			throw new IllegalStateException("Error: Must be logged in before you can logout");

		Connection con = openDBConnection();

		/* Closes DB Connection */
		try {
			con.close();
		} catch (SQLException E) {
		}
		this.loggedIn = false;
	}

	/**
	 * Method: getUserInfo()
	 * 
	 * The purpose of this method is to return all of the information for a
	 * specified user. Using the user_id we query the GABES_USER table to get
	 * all of the info for that user
	 * 
	 * @return ResultSet of all of the information for the user
	 * 
	 * @throws IllegalStateException
	 *             if then method is called when loggedIn = false
	 */
	public ResultSet getUserInfo() throws IllegalStateException, SQLException {
		Connection con = openDBConnection();
		Statement stmt = con.createStatement();
		/* Checks to make sure the user is logged in */
		if (isLoggedIn() == false)
			throw new IllegalStateException();
		/* Proceeds if user is logged in */
		String queryString = "Select * From team1.GABES_USER u Where u.USER_ID='" + this.user_id + "'";
		ResultSet result = stmt.executeQuery(queryString);
		return result;
	}

	/**
	 * Method: editCustomerInfo()
	 * 
	 * The purpose of this method is to update certain information about a user.
	 * You are able to update almost all information (not user_id or username)
	 * by using an update statement and sending through specified information
	 * 
	 * @throws IllegalStateException
	 *             if then method is called when loggedIn = false
	 */
	public void editCustomerInfo() throws IllegalStateException, SQLException {
		/* Checks to make sure user is logged in */
		if (isLoggedIn() == false)
			throw new IllegalStateException();
		/* Proceeds if the user is logged in */
		Connection con = openDBConnection();
		String queryString = "Update team1.GABES_USER Set EMAIL=?, PASS=?, PHONE=?, FIRST_N=?, LAST_N=?,"
				+ "IS_ADMIN=?, A_USERNAME=?, IS_SELLER=?, IS_BUYER=? Where CUSTOMER_NUMBER='" + this.user_id + "'";
		/* Clears old parameters, and passes new ones */
		PreparedStatement p_stmt = con.prepareCall(queryString);
		p_stmt.clearParameters();
		p_stmt.setString(1, this.email);
		p_stmt.setString(2, this.password);
		p_stmt.setString(3, this.phone);
		p_stmt.setString(4, this.first);
		p_stmt.setString(5, this.last);
		p_stmt.setInt(6, this.is_Admin);
		p_stmt.setString(5, this.admin_username);
		p_stmt.setInt(5, this.is_Seller);
		p_stmt.setInt(5, this.is_Buyer);
		/* Executes the Prepared Statement query */
		p_stmt.executeQuery();
		p_stmt.close();
	}

//	/**
//	 *************************************** COMPLETE ME*************************************** This method uses a
//	 * Statement object to query the ProductDeals_TRANS table for all
//	 * transactions made by the customer whose customer number is stored in
//	 * class field customerNumber.
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
