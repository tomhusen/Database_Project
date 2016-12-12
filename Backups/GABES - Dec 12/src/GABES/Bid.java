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
public class Bid implements Serializable {

	/**
	 * The following variables correspond to fields in the GABES_USER database
	 * table
	 */
	private String item_id;
	private String bidder_id;
	private String bidding_time;
	private String max_bid;
	
	
	

	public String getItem_id() {
		return item_id;
	}

	public void setItem_id(String item_id) {
		this.item_id = item_id;
	}

	public String getBidder_id() {
		return bidder_id;
	}

	public void setBidder_id(String bidder_id) {
		this.bidder_id = bidder_id;
	}

	public String getBidding_time() {
		return bidding_time;
	}

	public void setBidding_time(String bidding_time) {
		this.bidding_time = bidding_time;
	}

	public String getMax_bid() {
		return max_bid;
	}

	public void setMax_bid(String max_bid) {
		this.max_bid = max_bid;
	}

	/**
	 * Default Constructor for User class
	 * 
	 * No need for additional constructors
	 */
	public Bid() {
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
	 * Method: placeNewBid(String n_item_id, String n_bidder_id, String n_max_bid)
	 * 
	 * The purpose of this function is to add a new bid to the bid table. A bid cannot be lower than the current bid for a given item.
	 * if the current bid is 0 or null,it will make sure the bid is greater than the starting bid
	 * 
	 * throws: SQLException
	 */
	
	
	//return a value to let you know if the attempted bid was greater than the value that was already in the system
	public void placeNewBid(String n_item_id, String n_bidder_id, String n_max_bid) throws SQLException {
		//System.out.println("placing bid");
		Connection con = openDBConnection();
		Statement stmt = con.createStatement();
		String currentb ="";
		String startprice = "";
		String queryString = "Select CURRENT_BID,START_PRICE From team1.GABES_ITEM i Where i.ITEM_ID=" + n_item_id + "";
		ResultSet result = stmt.executeQuery(queryString);
		while (result.next()) {
		currentb = result.getString("CURRENT_BID");
		startprice = result.getString("START_PRICE");
		}
		if(currentb == null){
			currentb = startprice;
		}
		if(n_max_bid == null || n_max_bid == "" ){
			n_max_bid = "0";
		}
		
		double currentBidValue = Double.parseDouble(currentb);
		double newBidValue = Double.parseDouble(n_max_bid);
		if(newBidValue < 0){
			newBidValue = 0;
		}
		//System.out.println(currentBidValue + " current bid value");
		//System.out.println(newBidValue + " new bid value");
		if(currentBidValue < newBidValue){
		
		//if the bid is greater than the current bid, then place the bid. There is a trigger that once the bid is placed, it will update the current bid price
		/** Cast Strings to ints */
//		char ni_isAdmin = n_isAdmin.charAt(0);
//		char ni_isSeller = n_isSeller.charAt(0);
//		char ni_isBuyer = n_isBuyer.charAt(0);
		//System.out.println(n_item_id);
		Connection con2 = openDBConnection();
		CallableStatement callStmt = con2.prepareCall(" {call team1.GABES_NEW_BID(?, ?, ?)}");

		callStmt.setString(1, n_item_id);
		callStmt.setString(2, n_bidder_id);
		callStmt.setString(3, n_max_bid);
		
		/* Executes the Prepared Statement query */
		callStmt.execute();
		callStmt.close();
		}
	}
	
	/**
	 * Method: placeNewBid(String n_item_id)
	 * 
	 * The purpose of this function is get all the bidders that have bid on the item id that is passed as a parameter
	 * 
	 * throws: SQLException
	 */
	public ResultSet bidderList(String n_item_id) throws SQLException {
		Connection con = openDBConnection();
		String queryString = "Select b.BIDDING_TIME, u.USERNAME, b.MAX_BID From team1.GABES_USER u, team1.GABES_BIDS b  Where b.ITEM_ID= " + n_item_id +" AND u.USER_ID = b.BIDDER_ID Order by b.BIDDING_TIME asc";
		Statement stmt = con.prepareCall(queryString);
		/** Clears old, then sets new parameter values */
		ResultSet result = stmt.executeQuery(queryString);
		return result;
		}
	
	/**
	 * Method: placeNewBid(String n_item_id)
	 * 
	 * The purpose of this function is get all items that the current user has bid on
	 * 
	 * throws: SQLException
	 */
	public ResultSet itemsUserHasBidOn(String userId) throws SQLException {
		Connection con = openDBConnection();
		String queryString = "Select it.ITEM_ID, it.ITEM_NAME, it.ITEM_CATEGORY, it.START_DATE, it.END_DATE, it.CURRENT_BID, it.WINNER_ID FROM GABES_ITEM it WHERE it.STATUS=0 AND it.ITEM_ID = any(Select distinct b.Item_ID FROM GABES_BIDS b WHERE BIDDER_ID =" + userId +")";
		Statement stmt = con.prepareCall(queryString);
		/** Clears old, then sets new parameter values */
		ResultSet result = stmt.executeQuery(queryString);
		return result;
		}
}
