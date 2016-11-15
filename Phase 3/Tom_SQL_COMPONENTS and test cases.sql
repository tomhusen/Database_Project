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
  
 -- RETURNS 1
Select COUNT(*) From GABES_USER Where USERNAME='tehusen' and PASS='p@$$word';
-- RETURNS 0
Select COUNT(*) From GABES_USER Where USERNAME='tehusen' and PASS='NO';

-- Correct Credentials - RETURNS 1
Select GABES_ADMINLOGIN('tehusen', 'p@$$word') from DUAL;
-- Incorret Password - RETURNS 0
Select GABES_ADMINLOGIN('tehusen', 'NO') from DUAL;
-- Not an Admin - but otherwise correct credentials - RETURNS 0
Select GABES_ADMINLOGIN('irahal', 'puppies123') from DUAL;



-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************


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
  
---- RETURNS 1
--Select COUNT(*) From GABES_USER Where USERNAME='irahal' and PASS='puppies123';
---- RETURNS 0
--Select COUNT(*) From GABES_USER Where USERNAME='irahal' and PASS='wrong';
--
---- Correct Credentials - RETURNS 1
--Select GABES_USERLOGIN('irahal', 'puppies123') from DUAL;
---- Incorret Password - RETURNS 0
--Select GABES_USERLOGIN('irahal', 'wrong') from DUAL;
---- Not an Admin - but otherwise correct credentials - RETURNS 0
--Select GABES_USERLOGIN('tehusen', 'p@$$word') from DUAL;


-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************

-- This will get all of the users, their max bids, and what time they bid 
-- for a certain item.  
CREATE OR REPLACE VIEW GABES_BIDDERLIST AS
    Select u.USERNAME as Username, b.ITEM_ID as Item_ID, b.MAX_BID as Max_Bid, b.BIDDING_TIME as Bid_Time
    From GABES_BIDS b, GABES_USER u, GABES_ITEM i
    Where b.ITEM_ID = i.ITEM_ID and u.USER_ID = b.BIDDER_ID;

-- Outputs the entire contents of the view (All Bids)
Select * From GABES_BIDDERLIST;
-- Outputs only the records where the itemID = 5
Select * From GABES_BIDDERLIST Where ITEM_ID = 5;
-- Outputs only the records where the username = tehusen
Select * From GABES_BIDDERLIST Where USERNAME='tehusen';


-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************

-- This is the page for managing users.  You can view the users in the database
-- OR 
-- Add a new user to the database
CREATE OR REPLACE VIEW GABES_VIEWUSERS AS
  Select u.USER_ID, u.USERNAME, u.FIRST_N, u.LAST_N, u.EMAIL
  From GABES_USER u
  ORDER BY u.USER_ID;
  
-- Tests the view
Select * From GABES_VIEWUSERS;
-- Can filter users by userid, name, first, last, or email (not relevant to our site but may be useful later)
Select * From GABES_VIEWUSERS Where USERNAME='lJames';

-- Creates the procedure for adding a new user
-- PROBLEM HERE: Need to auto generate the next user_id to be assigned to this user
-- Currently have to manually put it in which is the '000009'



CREATE OR REPLACE PROCEDURE GABES_ADD_USER(new_username VARCHAR, new_email VARCHAR, new_pass VARCHAR,
                new_phone VARCHAR, new_first VARCHAR, new_last VARCHAR, new_admin CHAR, new_admin_u VARCHAR, new_sell CHAR, new_buy CHAR) AS
  BEGIN
    INSERT INTO GABES_USER VALUES (new_user_seq.NEXTVAL, new_username, new_email, new_pass, new_phone, new_first, new_last,
                        new_admin, new_admin_u, new_sell, new_buy);
  END;
  
-- Tests the addition of a new user
EXEC GABES_ADD_USER('rclawrence', 'rclawrence@csbsju.edu', 'password', '1234567891', 'Bobby', 'Lawrence', 0, 'tehusen', 1, 1);


-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************

-- Procedure for leaving feedback for a seller.
CREATE OR REPLACE PROCEDURE GABES_LEAVE_FEEDBACK(item_id CHAR, quality CHAR, deliver CHAR, overall CHAR, comments VARCHAR) AS
  BEGIN
    INSERT INTO GABES_FEEDBACK VALUES(item_id, quality, deliver, overall, comments);
  END;
  
-- Test leaving feedback
EXEC GABES_LEAVE_FEEDBACK(0000000008, 8, 2, 5, 'Pretty Good');


-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************

-- Creates a new sequence for generating next users number
CREATE SEQUENCE new_user_seq
  MAXVALUE 99999
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

-- Creates a new sequence for generating next item number
CREATE SEQUENCE new_item_seq
  MAXVALUE 9999999999
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
  
  
  
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
  
  -- Search
--
-- Allows a user to search through all of the items in the database based on
-- item ID, name, etc. and will display a table with the results

-- We need to put the Column name into all UPPER CASE so that when querying we ignore casing

-- Creates a View of All Items
CREATE OR REPLACE VIEW GABES_SEARCH AS
  Select ITEM_ID as Item_ID, ITEM_NAME as Name, ITEM_CATEGORY as Category, 
    START_DATE as Auction_Start, END_DATE as Auction_End, 
    CURRENT_BID as Current_Bid, USER_ID as Sellers_ID, START_PRICE as Begin_Price
  From GABES_ITEM
  Order By ITEM_ID;

-- *****************************************************************************
-- *****************************************************************************
-- *****************************************************************************

-- ******************************* TEST CASES **********************************

-- Search by ITEM_ID (Valid) - Returns info about item with ITEM_ID = 1
Select * From GABES_SEARCH Where ITEM_ID = 1;

-- Search by ITEM_ID (Invalid) - Returns empty table
Select * From GABES_SEARCH Where ITEM_ID = 0;

-- *****************************************************************************

-- Search by ITEM_CATEGORY (Valid) - Returns info about item with CATEGORY like Books
Select * From GABES_SEARCH Where upper(CATEGORY) LIKE '%BOOKS%';

-- Search by ITEM_CATEGORY (Invalid) - Returns empty table
Select * From GABES_SEARCH Where upper(CATEGORY) LIKE '%BEER%';

-- *****************************************************************************

-- Search by ITEM_NAME (Valid) - Returns info about item with ITEM_NAME like Jersey
Select * From GABES_SEARCH Where upper(NAME) LIKE '%JERSEY%';

-- Search by ITEM_NAME (Invalid) - Returns empty table
Select * From GABES_SEARCH Where upper(NAME) LIKE '%LEBRON%';

-- *****************************************************************************

-- Search by CURRENT_BID (Valid) - Returns info about item with CURRENT_BID less than $20
Select * From GABES_SEARCH Where CURRENT_BID <= 20 OR (BEGIN_PRICE <= 20.00 and CURRENT_BID IS NULL);

-- Search by CURRENT_BID (Invalid) - Returns empty table since nothing is priced less than $10
Select * From GABES_SEARCH Where CURRENT_BID <= 10 OR (BEGIN_PRICE <= 10.00 and CURRENT_BID IS NULL);

-- *****************************************************************************

-- Search by CATEGORY and NAME (Valid) - Returns info about item with CATEGORY like Books and NAME like Da Vinci
Select * From GABES_SEARCH Where upper(CATEGORY) LIKE '%BOOKS%'
INTERSECT
Select * From GABES_SEARCH Where upper(NAME) LIKE '%VINCI%';

-- Search by CATEGORY and NAME (Invalid) - Returns empty table since no items in the CATEGORY Books are named 'Kennedy'
Select * From GABES_SEARCH Where upper(CATEGORY) LIKE '%BOOKS%'
INTERSECT
Select * From GABES_SEARCH Where upper(NAME) LIKE '%KENNEDY%';

-- *****************************************************************************

-- Search by CATEGORY and NAME (Valid) - Returns info about item with CATEGORY like Books and NAME like Da Vinci
Select * From GABES_SEARCH Where upper(CATEGORY) LIKE '%BOOKS%'
INTERSECT
Select * From GABES_SEARCH Where upper(NAME) LIKE '%VINCI%';

-- Search by CATEGORY and NAME (Invalid) - Returns empty table since no items in the CATEGORY Books are named 'Kennedy'
Select * From GABES_SEARCH Where upper(CATEGORY) LIKE '%BOOKS%'
INTERSECT
Select * From GABES_SEARCH Where upper(NAME) LIKE '%KENNEDY%';

-- *****************************************************************************

-- Search by CATEGORY and PRICE (Valid) - Returns info about item with CATEGORY like Books and Priced below $18
Select * From GABES_SEARCH Where upper(CATEGORY) LIKE '%BOOKS%'
INTERSECT
Select * From GABES_SEARCH Where CURRENT_BID <= 18 OR (BEGIN_PRICE <= 18.00 and CURRENT_BID IS NULL);

-- Search by CATEGORY and PRICE (Invalid) - Returns empty table since no items in the CATEGORY Books are Priced below $10
Select * From GABES_SEARCH Where upper(CATEGORY) LIKE '%BOOKS%'
INTERSECT
Select * From GABES_SEARCH Where CURRENT_BID <= 10 OR (BEGIN_PRICE <= 10.00 and CURRENT_BID IS NULL);

-- *****************************************************************************

-- Search by NAME and PRICE (Valid) - Returns info about item with NAME like Jacket and Priced below $200
Select * From GABES_SEARCH Where upper(NAME) LIKE '%JACKET%'
INTERSECT
Select * From GABES_SEARCH Where CURRENT_BID <= 200 OR (BEGIN_PRICE <= 200.00 and CURRENT_BID IS NULL);

-- Search by NAME and PRICE (Invalid) - Returns empty table since no items with a NAME like JACKET are Priced below $100
Select * From GABES_SEARCH Where upper(NAME) LIKE '%JACKET%'
INTERSECT
Select * From GABES_SEARCH Where CURRENT_BID <= 100 OR (BEGIN_PRICE <= 100.00 and CURRENT_BID IS NULL);3

-- *****************************************************************************

-- Search by NAME, CATEGORY, PRICE (Valid) - Returns info about item with NAME like VINCI, CATEGORY like BOOK, and Priced below $20
Select * From GABES_SEARCH Where upper(NAME) LIKE '%VINCI%'
INTERSECT
Select * From GABES_SEARCH Where upper(CATEGORY) LIKE '%BOOKS%'
INTERSECT
Select * From GABES_SEARCH Where CURRENT_BID <= 20 OR (BEGIN_PRICE <= 20.00 and CURRENT_BID IS NULL);

-- Search by CATEGORY and PRICE (Invalid) - Returns empty table since no items match these requirements
Select * From GABES_SEARCH Where upper(NAME) LIKE '%VINCI%'
INTERSECT
Select * From GABES_SEARCH Where upper(CATEGORY) LIKE '%COOKING%'
INTERSECT
Select * From GABES_SEARCH Where CURRENT_BID <= 20 OR (BEGIN_PRICE <= 20.00 and CURRENT_BID IS NULL);

-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
  
  -- Bids

-- Inserts a new 'bid' into the bids table. The primary key is a combination 
-- of the Item_ID, Bidder_ID, and Timestamp of when the bid was placed
  CREATE OR REPLACE PROCEDURE GABES_NEW_BID(new_itemID CHAR, new_bidderID CHAR, new_maxLimit DECIMAL) AS
  BEGIN
    INSERT INTO GABES_BIDS VALUES (new_itemID, new_bidderID, CURRENT_TIMESTAMP, new_maxLimit);
  END;
  
-- Tests the addition of a new bid
EXEC GABES_NEW_BID(9, 1, 180);

--*****************************************************************************
--*****************************************************************************
--*****************************************************************************

-- If the current time is past the selling time, then flip the status flag

  CREATE OR REPLACE PROCEDURE GABES_CHECK_TIME AS
  BEGIN
    Update GABES_ITEM
    Set STATUS = 1, SELLING_PRICE = CURRENT_BID, COMMISSION_FEE = (.95*CURRENT_BID)
    Where CURRENT_TIMESTAMP > END_DATE;
  END;

EXEC GABES_CHECK_TIME;

EXEC GABES_NEW_BID(9, 1, 180);
-- ************************************************************************

  
-- Trigger to run when the status is flipped to 1 - i.e. Auction ended
CREATE OR REPLACE TRIGGER GABES_AUCTION_ENDED
  BEFORE INSERT ON GABES_BIDS
  FOR EACH ROW
  BEGIN
    GABES_CHECK_TIME;
  END;
    
    
CREATE OR REPLACE TRIGGER GABES_BID_TRIGGER
  AFTER INSERT ON GABES_BIDS
  FOR EACH ROW
  BEGIN
    UPDATE GABES_ITEM
    SET CURRENT_BID = :NEW.MAX_BID
    WHERE GABES_ITEM.ITEM_ID =:NEW.ITEM_ID;
  End;

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
