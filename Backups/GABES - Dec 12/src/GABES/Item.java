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
 * This is a class that is going to be used for our web interface for our GABES
 * project
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
	 * The purpose of this method is to use the connection to our Oracle
	 * Database to get all of the information about an item, specified by their
	 * item_id
	 * 
	 * @return a ResultSet object containing the record for the matching item
	 *         from the GABES_ITEM table
	 */
	public ResultSet getItemInfo(String itemID) throws SQLException {
		Connection con = openDBConnection();
		Statement stmt = con.createStatement();
		/** Proceeds if user is logged in */
		String queryString = "Select * From team1.GABES_ITEM i Where i.ITEM_ID='" + itemID + "'";
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
	public void editItemInfo(String itemID, String category, String description, String name, String endDate)
			throws SQLException {
		Connection con = openDBConnection();
		String queryString = "Update team1.GABES_ITEM Set ITEM_CATEGORY=?, DESCRIPTION=?, ITEM_NAME=?, END_DATE=TO_TIMESTAMP('"
				+ endDate + " 23:59:59', 'YYYY-MM-DD HH24:MI:SS')";
		queryString += "Where ITEM_ID='" + itemID + "'";
		/** Clears parameters and then sets new values */
		PreparedStatement p_stmt = con.prepareCall(queryString);
		/** Set new attribute values */
		p_stmt.clearParameters();
		p_stmt.setString(1, category);
		System.out.println("New Category: " + category);
		p_stmt.setString(2, description);
		System.out.println("New Description: " + description);
		p_stmt.setString(3, name);
		System.out.println("New Name: " + name);
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

	/**
	 * Method: getAllItems(String userId)
	 * 
	 * The purpose of this function is to get all items a specific user has up
	 * for auction or auctioned off in the past
	 * 
	 * @throws IllegalStateException
	 *             if then method is called when loggedIn = false
	 */
	public ResultSet getAllItems(String userId) throws IllegalStateException, SQLException {

		/* Opens Connection and creates a new Statement */
		Connection con = openDBConnection();
		Statement stmt = con.createStatement();
		String queryString = "Select ITEM_ID,ITEM_NAME,START_DATE,END_DATE,START_PRICE,CURRENT_BID,STATUS From team1.GABES_ITEM ";
		queryString += "Where USER_ID='" + userId + "'";
		ResultSet result = stmt.executeQuery(queryString);

		return result;
	}

	/**
	 * Method: getAllItems(String userId)
	 * 
	 * The purpose of this function is to get all items a user can bid on
	 * 
	 * @throws IllegalStateException
	 *             if then method is called when loggedIn = false
	 */
	public ResultSet getAllItems() throws IllegalStateException, SQLException {
		// CHECK THE END DATE SO YOU DONT HAVE ITEMS LISTED THAT HAVE PAST THEIR
		// END DATE
		/* Opens Connection and creates a new Statement */
		Connection con = openDBConnection();
		Statement stmt = con.createStatement();
		String queryString = "Select ITEM_ID,ITEM_NAME,ITEM_CATEGORY,START_DATE,END_DATE,CURRENT_BID From team1.GABES_ITEM ";
		// queryString += "Where GETDATE() < END_DATE";
		ResultSet result = stmt.executeQuery(queryString);

		return result;
	}

	/**
	 * Method: getAllItems(String userId)
	 * 
	 * The purpose of this function is to get all items a user can bid on
	 * 
	 * @throws IllegalStateException
	 *             if then method is called when loggedIn = false
	 */
	public ResultSet getAllItemsForSale() throws IllegalStateException, SQLException {
		// CHECK THE END DATE SO YOU DONT HAVE ITEMS LISTED THAT HAVE PAST THEIR
		// END DATE
		/* Opens Connection and creates a new Statement */
		Connection con = openDBConnection();
		Statement stmt = con.createStatement();
		String queryString = "Select ITEM_ID,ITEM_NAME,ITEM_CATEGORY,START_DATE,END_DATE,START_PRICE,CURRENT_BID From team1.GABES_ITEM WHERE STATUS != 1 ";
		// queryString += "Where GETDATE() < END_DATE";
		ResultSet result = stmt.executeQuery(queryString);

		return result;
	}

	/**
	 * Method: getAllItemsForSalesSummary()
	 * 
	 * The purpose of this function is to get all items a user can bid on
	 * 
	 * @throws IllegalStateException
	 *             if then method is called when loggedIn = false
	 */
	public ResultSet getAllItemsForSalesSummary() throws IllegalStateException, SQLException {
		Connection con = openDBConnection();
		Statement stmt = con.createStatement();
		String queryString = "Select ITEM_ID,ITEM_NAME,ITEM_CATEGORY,SELLING_PRICE,COMMISSION_FEE From team1.GABES_ITEM Where STATUS=1 ORDER BY ITEM_CATEGORY, ITEM_ID";
		ResultSet result = stmt.executeQuery(queryString);
		return result;
	}

	/**
	 * Method: getItemInfo(String itemId)
	 * 
	 * The purpose of this method is to use the connection to our Oracle
	 * Database to get the information about an item that will be presented for
	 * the item info page
	 * 
	 * @return a ResultSet object containing the record for the matching item
	 *         from the GABES_ITEM table
	 */
	public ResultSet getItemInfoToEdit(String itemID) throws SQLException {
		Connection con = openDBConnection();
		Statement stmt = con.createStatement();
		String queryString = "Select * From team1.GABES_ITEM i Where i.ITEM_ID=" + itemID + "";
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
	 * Method: getItemName(String itemId)
	 * 
	 * The purpose of this function is to get the name of an item to display
	 * along with the item id when a user places a bid
	 * 
	 */
	public ResultSet getItemName(String itemId) throws SQLException {
		Connection con = openDBConnection();
		Statement stmt = con.createStatement();
		String check = "";
		String queryString = "Select CURRENT_BID From team1.GABES_ITEM i Where i.ITEM_ID=" + itemId + "";
		ResultSet result = stmt.executeQuery(queryString);
		while (result.next()) {
			check = result.getString("CURRENT_BID");
		}
		if (check == "0" || check == null) {
			String queryString2 = "Select ITEM_ID, ITEM_NAME, START_PRICE From team1.GABES_ITEM i Where i.ITEM_ID="
					+ itemId + "";
			ResultSet result2 = stmt.executeQuery(queryString2);
			return result2;
		} else {
			String queryString3 = "Select ITEM_ID, ITEM_NAME, CURRENT_BID From team1.GABES_ITEM i Where i.ITEM_ID="
					+ itemId + "";
			ResultSet result3 = stmt.executeQuery(queryString3);
			return result3;
		}
	}

	public ResultSet search(String s_itemID, String keyword, String category, String minBid, String maxBid,
			String endDate) throws SQLException {

		/**
		 * Maybe manually add the '% %' for the LIKE to the different strings
		 * ex. String new_itemID = "'%"+s_itemID+"%'";
		 */

		Connection con = openDBConnection();
		ResultSet result;
		/**
		 * If the ITEM ID is known and searched for, there's no need to search
		 * other attributes
		 */
		if (!s_itemID.equals("ID")) {
			String queryString = "Select i.ITEM_ID, i.ITEM_NAME, i.ITEM_CATEGORY, i.START_DATE, i.END_DATE, i.START_PRICE, i.CURRENT_BID, i.STATUS ";
			queryString += "From team1.GABES_ITEM i ";
			queryString += "Where i.ITEM_ID='" + s_itemID + "' AND i.STATUS=0";
			PreparedStatement p_stmt = con.prepareStatement(queryString);
			result = p_stmt.executeQuery();
		} else {
			if (keyword.equals("Keyword")) {
				keyword = "";
			}
			if (category.equals("Category")) {
				category = "";
			}
			if (minBid.equals("Min")) {
				minBid = "0.0";
			}
			if (maxBid.equals("Max")) {
				maxBid = "999999999999.99";
			}
			if (endDate.equals("YYYY-MM-DD")) {
				endDate = "9999-12-31";
			}

			String queryString = "Select i.ITEM_ID, i.ITEM_NAME, i.ITEM_CATEGORY, i.START_DATE, i.END_DATE, i.START_PRICE, i.CURRENT_BID, i.STATUS ";
			queryString += "From team1.GABES_ITEM i ";
			queryString += "Where i.ITEM_NAME LIKE ? AND i.ITEM_CATEGORY LIKE ? AND i.STATUS=0";
			// Below here is done - End Date and Bid Range
			queryString += "AND ((i.CURRENT_BID>? AND i.CURRENT_BID<?) OR (i.CURRENT_BID IS NULL AND i.START_PRICE>? AND i.START_PRICE<?))";
			queryString += "AND i.END_DATE < TO_TIMESTAMP('" + endDate + " 23:59:59', 'YYYY-MM-DD HH24:MI:SS')";

			PreparedStatement p_stmt = con.prepareStatement(queryString);
			p_stmt.clearParameters();
			p_stmt.setString(1, "%" + keyword + "%");
			p_stmt.setString(2, "%" + category + "%");
			p_stmt.setString(3, minBid);
			p_stmt.setString(4, maxBid);
			p_stmt.setString(5, minBid);
			p_stmt.setString(6, maxBid);
			System.out.println("Item Keyword Searched: " + keyword);
			System.out.println("Item Category Searched: " + category);
			System.out.println("Min Bid Searched: " + minBid);
			System.out.println("Max Bid Searched: " + maxBid);
			System.out.println("End Date Searched: " + endDate);
			result = p_stmt.executeQuery();
		}
		return result;
	}

	/**
	 * Searches for an item based on similar-sounding words to the input string
	 * 
	 * @param name
	 * @return
	 * @throws SQLException
	 */
	public ResultSet quickSearch(String item_name) throws SQLException {
		Connection con = openDBConnection();
		PreparedStatement p_stmt = con.prepareStatement(
				"Select i.ITEM_ID, i.ITEM_NAME, i.ITEM_CATEGORY, i.START_DATE, i.END_DATE, i.START_PRICE, i.CURRENT_BID, i.STATUS "
						+ "FROM team1.GABES_ITEM i " + "WHERE SOUNDEX(i.ITEM_NAME) = SOUNDEX() "
						+ "GROUP BY i.ITEM_ID, i.ITEM_NAME, i.ITEM_CATEGORY, i.START_DATE, i.END_DATE");
		p_stmt.clearParameters();
		p_stmt.setString(1, item_name);
		ResultSet result = p_stmt.executeQuery();
		return result;
	}

	/**
	 * Method: updateTime()
	 * 
	 * This method calls the prepared statement in our Database that is
	 * responsible for updating items based on if they're sold, past sell date,
	 * etc.
	 */
	public void updateTime() throws SQLException {
		Connection con = openDBConnection();
		CallableStatement callStmt = con.prepareCall(" {call team1.GABES_CHECK_TIME()}");
		callStmt.execute();
		callStmt.close();
	}

	/**
	 * Method: getAllItemsUserBought(String userId)
	 * 
	 * The purpose of this function is to get all items a user has purchased
	 * 
	 * @throws IllegalStateException
	 *             if then method is called when loggedIn = false
	 */
	public ResultSet getAllItemsUserBought(String userID) throws IllegalStateException, SQLException {
		// CHECK THE END DATE SO YOU DONT HAVE ITEMS LISTED THAT HAVE PAST THEIR
		// END DATE
		/* Opens Connection and creates a new Statement */
		Connection con = openDBConnection();
		Statement stmt = con.createStatement();
		String queryString = "Select ITEM_ID,ITEM_NAME,ITEM_CATEGORY,END_DATE,CURRENT_BID, USER_ID From team1.GABES_ITEM WHERE STATUS = 1 AND WINNER_ID ="
				+ userID + " ORDER BY ITEM_ID, ITEM_CATEGORY";
		ResultSet result = stmt.executeQuery(queryString);
		return result;
	}

	/**
	 * Method: getItemInfo(String itemId)
	 * 
	 * The purpose of this method is to use the connection to our Oracle
	 * Database to get the information about an item that will be presented for
	 * the item info page
	 * 
	 * @return a ResultSet object containing the record for the matching item
	 *         from the GABES_ITEM table
	 */
	public ResultSet getNameForFeedBack(String itemID) throws SQLException {
		Connection con = openDBConnection();
		Statement stmt = con.createStatement();
		String queryString = "Select ITEM_ID,ITEM_NAME From team1.GABES_ITEM i Where i.ITEM_ID=" + itemID + "";
		ResultSet result = stmt.executeQuery(queryString);
		return result;
	}
}
