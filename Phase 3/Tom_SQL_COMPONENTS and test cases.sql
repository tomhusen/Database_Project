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
  
-- RETURNS 1
Select COUNT(*) From GABES_USER Where USERNAME='irahal' and PASS='puppies123';
-- RETURNS 0
Select COUNT(*) From GABES_USER Where USERNAME='irahal' and PASS='wrong';

-- Correct Credentials - RETURNS 1
Select GABES_USERLOGIN('irahal', 'puppies123') from DUAL;
-- Incorret Password - RETURNS 0
Select GABES_USERLOGIN('irahal', 'wrong') from DUAL;
-- Not an Admin - but otherwise correct credentials - RETURNS 0
Select GABES_USERLOGIN('tehusen', 'p@$$word') from DUAL;


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
  
  
  
  
  
  
  
  
