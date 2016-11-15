
--Sequences
-- *********************************************************
---------------------------------------------------------------------
---------------------------------------------------------------------

-- DROP THEN CREATE SEQUENCES FOR USER IDS AND ITEM IDS
DROP SEQUENCE new_user_seq;
CREATE SEQUENCE new_user_seq
  MAXVALUE 99999
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
/
-- *********************************************************
  
DROP SEQUENCE new_item_seq;
CREATE SEQUENCE new_item_seq
  MAXVALUE 9999999999
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
/  


--Functions
-- *********************************************************
---------------------------------------------------------------------
---------------------------------------------------------------------

-- This is a function for an admin to login to the system
-- it passes a String for the username and a String for the password
-- When called it returns a 1 if it's a valid user, and a 0 if it's invalid
-- It will not allow normal users to login as they should login under regular login

CREATE OR REPLACE FUNCTION GABES_AdminLogin(param_user String, param_pass String) RETURN int AS
  temp int := 0;
  BEGIN
    Select COUNT(*) into temp
    From GABES_USER
    Where USERNAME = param_user and PASS = param_pass and IS_ADMIN = 1;
    Return temp;
  END;
/
-- *********************************************************

-- This is a function for a regular user to login to the system
-- it passes a String for the username and a String for the password
-- When called it returns a 1 if it's a valid user, and a 0 if it's invalid
-- It will not allow admins to login as they should login with admin login
CREATE OR REPLACE FUNCTION GABES_USERLOGIN(param_user String, param_pass String) RETURN int AS
  temp int := 0;
  BEGIN
    Select COUNT(*) into temp
    From GABES_USER
    Where USERNAME = param_user and PASS = param_pass and IS_ADMIN = 0;
    Return temp;
  END;
/  

--Procedures
-- *********************************************************
---------------------------------------------------------------------
---------------------------------------------------------------------

-- Creates the procedure for adding a new user
-- PROBLEM HERE: Need to auto generate the next user_id to be assigned to this user
-- Currently have to manually put it in which is the '000009'
CREATE OR REPLACE PROCEDURE GABES_ADD_USER(new_username VARCHAR, new_email VARCHAR, new_pass VARCHAR,
                new_phone VARCHAR, new_first VARCHAR, new_last VARCHAR, new_admin CHAR, new_admin_u VARCHAR, new_sell CHAR, new_buy CHAR) AS
  BEGIN
    INSERT INTO GABES_USER VALUES (new_user_seq.NEXTVAL, new_username, new_email, new_pass, new_phone, new_first, new_last,
                        new_admin, new_admin_u, new_sell, new_buy);
  END;
/
-- *********************************************************

CREATE OR REPLACE PROCEDURE GABES_LEAVE_FEEDBACK(item_id CHAR, quality CHAR, deliver CHAR, overall CHAR, comments VARCHAR) AS
  BEGIN
    INSERT INTO GABES_FEEDBACK VALUES(item_id, quality, deliver, overall, comments);
  END;
/
-- *********************************************************

-- Procedure for updateing the current user's email.
create or replace Procedure Update_User_Profile_Email(p_userId IN int,p_email IN String)
  IS
	begin
  
  UPDATE GABES_USER
  
  SET GABES_USER.EMAIL = p_email WHERE p_email IS NOT null AND USER_ID = p_userID; 
  END;
/
-- *********************************************************

-- Procedure for updateing the current user's first name.
create or replace Procedure Update_User_Profile_FirstName(p_userId IN int, p_firstName IN String)
  IS
	begin
  
  UPDATE GABES_USER
  
  SET GABES_USER.FIRST_N = p_firstName WHERE p_firstName IS NOT null AND USER_ID = p_userID; 
  END;
/
-- *********************************************************

-- Procedure for updateing the current user's last name.
create or replace Procedure Update_User_Profile_LastName(p_userId IN int,p_lastName IN String)
  IS
	begin
  
  UPDATE GABES_USER
  
  SET GABES_USER.LAST_N = p_lastName WHERE p_lastName IS NOT null AND USER_ID = p_userID; 
  END;
/
-- *********************************************************

-- Procedure for updateing the current user's password.
create or replace Procedure Update_User_Profile_Password(p_userId IN int,p_oldPassword IN String, p_newPassword IN String, p_checkPassword IN STRING)
  IS
	begin
  
  UPDATE GABES_USER
  
  SET GABES_USER.PASS = p_newPassword WHERE p_oldPassword IS NOT null AND p_newPassword IS NOT NULL AND p_checkPassword IS NOT NULL AND p_checkPassword = p_newPassword AND p_newPassword != PASS AND USER_ID = p_userID; 
  END;
/
-- *********************************************************

-- Procedure for updateing the current user's phone number.
create or replace Procedure Update_User_Profile_Phone(p_userId IN int,p_phoneNumber IN int)
  IS
	begin
  
  UPDATE GABES_USER
  
  SET GABES_USER.PHONE = p_phoneNumber WHERE p_phoneNumber IS NOT null AND USER_ID = p_userID; 
  END;
/
-- *********************************************************

create or replace Procedure Update_User_Profile_UserName(p_userId IN int, p_userName IN String)
  IS
	begin
  
  UPDATE GABES_USER
  
  SET GABES_USER.USERNAME = p_userName WHERE p_userName IS NOT null AND USER_ID = p_userID; 
  END;
/
-- *********************************************************

--Procedure that is used to post new items to the Gabes_Item table
create or replace Procedure Post_Item(p_itemCategory IN VARCHAR2, p_status IN CHAR, p_sellingPrice IN Number, p_description IN VARCHAR2, p_comissionFee IN Number, p_itemName IN VARCHAR2, p_currentBid IN number, p_startPrice IN number, p_startDate IN TIMESTAMP, p_endDate IN TIMESTAMP, p_userID IN CHAR, p_winnerID IN char)
  IS
	begin 
  
  INSERT INTO GABES_ITEM (ITEM_ID, ITEM_CATEGORY, STATUS, SELLING_PRICE, DESCRIPTION, COMMISSION_FEE, ITEM_NAME, CURRENT_BID, START_PRICE, START_DATE, END_DATE, USER_ID, WINNER_ID) VALUES (NEW_ITEM_SEQ.nextVal, p_itemCategory , p_status, p_sellingPrice, p_description, p_comissionFee, p_itemName , p_currentBid, p_startPrice, p_startDate, p_endDate, p_userID, p_winnerID );
  
  END;
/
-- *********************************************************

--Procedure that edits an already existing item's category
create or replace Procedure Edit_Item_Category(p_userId IN int, p_itemId IN int, p_newCategory IN String)
  IS
	begin
  
  UPDATE GABES_ITEM
  
  SET GABES_ITEM.ITEM_CATEGORY = p_newCategory WHERE p_newCategory IS NOT null AND p_itemId IS NOT null AND p_itemId = ITEM_ID AND USER_ID = p_userID; 
  END;
/
-- *********************************************************

--Procedure that edits an already existing item's description
create or replace Procedure Edit_Item_Description(p_userId IN int, p_itemID IN INT, p_newDescription IN String)
  IS
	begin
  
  UPDATE GABES_ITEM
  
  SET GABES_ITEM.DESCRIPTION = p_newDescription WHERE p_newDescription IS NOT null AND p_itemId IS NOT null AND p_itemId = ITEM_ID AND USER_ID = p_userID; 
  END;
/

-- *********************************************************

--Procedure that edits an already existing item's name
create or replace Procedure Edit_Item_Name(p_userId IN int, p_itemID IN int, p_newName IN String)
  IS
	begin
  
  UPDATE GABES_ITEM
  
  SET GABES_ITEM.ITEM_NAME = p_newName WHERE p_newName IS NOT null AND p_itemId IS NOT null AND p_itemId = ITEM_ID AND USER_ID = p_userID; 
  END;

/
-- *********************************************************

-- If the current time is past the selling time, then flip the status flag, changes selling price and commission

  CREATE OR REPLACE PROCEDURE GABES_CHECK_TIME AS
  BEGIN
    Update GABES_ITEM
    Set STATUS = 1, SELLING_PRICE = CURRENT_BID, COMMISSION_FEE = (.05*CURRENT_BID)
    Where CURRENT_TIMESTAMP > END_DATE;
  END;
/
-- *********************************************************
-- Inserts a new 'bid' into the bids table. The primary key is a combination 
-- of the Item_ID, Bidder_ID, and Timestamp of when the bid was placed
  CREATE OR REPLACE PROCEDURE GABES_NEW_BID(new_itemID CHAR, new_bidderID CHAR, new_maxLimit DECIMAL) AS
  BEGIN
    INSERT INTO GABES_BIDS VALUES (new_itemID, new_bidderID, CURRENT_TIMESTAMP, new_maxLimit);
  END;
/
--Views
-- *********************************************************
---------------------------------------------------------------------
---------------------------------------------------------------------

--This view returns a result set that is limited by the input search criteria.
  CREATE OR REPLACE VIEW GABES_SEARCH("ITEM_ID", "NAME", "CATEGORY", "AUCTION_START", "AUCTION_END", "CURRENT_BID", "SELLERS_ID", "BEGIN_PRICE") AS 
  Select ITEM_ID as Item_ID, ITEM_NAME as Name, ITEM_CATEGORY as Category, 
    START_DATE as Auction_Start, END_DATE as Auction_End, 
    CURRENT_BID as Current_Bid, USER_ID as Sellers_ID, START_PRICE as Begin_Price
  From GABES_ITEM
  Order By ITEM_ID;
/
-- *********************************************************

-- This will get all of the users, their max bids, and what time they bid 
-- for a certain item.  
CREATE OR REPLACE VIEW GABES_BIDDERLIST AS
    Select u.USERNAME as Username, b.ITEM_ID as Item_ID, b.MAX_BID as Max_Bid, b.BIDDING_TIME as Bid_Time
    From GABES_BIDS b, GABES_USER u, GABES_ITEM i
    Where b.ITEM_ID = i.ITEM_ID and u.USER_ID = b.BIDDER_ID;
/
-- *********************************************************

-- This is the page for managing users.  You can view the users in the database
-- OR 
-- Add a new user to the database
CREATE OR REPLACE VIEW GABES_VIEWUSERS AS
  Select u.USER_ID, u.USERNAME, u.FIRST_N, u.LAST_N, u.EMAIL
  From GABES_USER u
  ORDER BY u.USER_ID;
/
-- *********************************************************

-- View to display the current user's items that they put up for auction.
CREATE OR REPLACE VIEW ITEM_LIST AS
SELECT ITEM_ID, ITEM_NAME, START_DATE, END_DATE, START_PRICE, CURRENT_BID, STATUS, USER_ID
FROM GABES_ITEM;
/
-- *********************************************************

--View that returns the items that the current user has bought.
CREATE OR REPLACE VIEW LIST_OF_ITEMS_BOUGHT AS
SELECT ITEM_ID, ITEM_NAME, ITEM_CATEGORY, START_DATE, END_DATE, START_PRICE, SELLING_PRICE, USER_ID, WINNER_ID
FROM GABES_ITEM;
/
-- *********************************************************
  
--Admin Commission Report View
CREATE OR REPLACE VIEW Admin_Commission_Report AS
SELECT x.USER_ID, u.USERNAME, u.FIRST_N, u.LAST_N, u.EMAIL, AVG(f.OVERALL_RATING) AS Seller_Rating, SUM(x.STATUS) AS Commissions
FROM GABES_USER u, GABES_ITEM x 
FULL OUTER JOIN GABES_FEEDBACK f
ON f.ITEM_ID = x.ITEM_ID
WHERE u.USER_ID = x.USER_ID
GROUP BY x.USER_ID, u.USERNAME, u.FIRST_N, u.LAST_N, u.EMAIL
ORDER BY x.USER_ID;
/
-- *********************************************************

--Sales Summary Report View
CREATE OR REPLACE VIEW Sale_Summary_Report AS
SELECT ITEM_CATEGORY, ITEM_ID, ITEM_NAME, SELLING_PRICE, COMMISSION_FEE
FROM GABES_ITEM
WHERE STATUS = 1;  
/
-- *********************************************************
  
--Bid Status View
CREATE OR REPLACE VIEW Bid_Status AS
SELECT i.ITEM_ID, i.STATUS, i.ITEM_NAME, i.ITEM_CATEGORY, i.START_DATE, i.END_DATE, i.CURRENT_BID, x.USERNAME
FROM GABES_BIDS b, GABES_USER x, GABES_ITEM i
WHERE i.ITEM_ID = b.ITEM_ID AND b.BIDDER_ID = x.USER_ID AND i.WINNER_ID = x.USER_ID;
/
-- *********************************************************

--User's Rating View
CREATE OR REPLACE VIEW Users_Rating AS
SELECT DISTINCT z.USERNAME, y.ITEM_ID, y.OVERALL_RATING, y.ITEM_QUALITY, y.DELIVERY, y.COMMENTS, z.User_ID
FROM  GABES_FEEDBACK y, GABES_USER z JOIN 
GABES_ITEM x
ON z.USER_ID = x.USER_ID
WHERE y.ITEM_ID = x.ITEM_ID;
/

--Triggers
-- *********************************************************
---------------------------------------------------------------------
---------------------------------------------------------------------

-- Trigger to run when the status is flipped to 1 - i.e. Auction ended
CREATE OR REPLACE TRIGGER GABES_AUCTION_ENDED
  BEFORE INSERT ON GABES_BIDS
  FOR EACH ROW
  BEGIN
    GABES_CHECK_TIME;
  END;
/
-- *********************************************************


-- Trigger that updates that current bid to the new max bit when a bid is placed
CREATE OR REPLACE TRIGGER GABES_BID_TRIGGER
  AFTER INSERT ON GABES_BIDS
  FOR EACH ROW
  BEGIN
    UPDATE GABES_ITEM
    SET CURRENT_BID = :NEW.MAX_BID
    WHERE GABES_ITEM.ITEM_ID =:NEW.ITEM_ID;
  End;

