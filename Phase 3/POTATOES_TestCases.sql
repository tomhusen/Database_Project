-- ************************************************************************
-- ************************************************************************
-- This file contains test code to run on our team server that will demonstrate
-- the component (function, view, procedure, trigger, or sequence) working 
-- as intended.
-- 
-- Each test case includes the output that is expected when it is ran 
-- ************************************************************************
-- ************************************************************************

-- Tests: Function GABES_ADMINLOGIN 
-- Return: This function returns a 1 for successful login, or a 0 for an
--         unsuccessful login. Login will fail for incorrect username/pass
--         combination or if the wrong type of user is trying to login

-- Correct Credentials - RETURNS 1
Select GABES_ADMINLOGIN('tehusen', 'p@$$word') from DUAL;
-- Incorret Password - RETURNS 0
Select GABES_ADMINLOGIN('tehusen', 'NO') from DUAL;
-- Not an Admin - but otherwise correct credentials - RETURNS 0
Select GABES_ADMINLOGIN('irahal', 'puppies123') from DUAL;

-- ****************************************************************************

-- Tests: Function GABES_USERLOGIN 
-- Return: This function returns a 1 for successful login, or a 0 for an
--         unsuccessful login. Login will fail for incorrect username/pass
--         combination or if the wrong type of user is trying to login

-- Correct Credentials - RETURNS 1
Select GABES_USERLOGIN('irahal', 'puppies123') from DUAL;
-- Incorret Password - RETURNS 0
Select GABES_USERLOGIN('irahal', 'wrong') from DUAL;
-- Not an Admin - but otherwise correct credentials - RETURNS 0
Select GABES_USERLOGIN('tehusen', 'p@$$word') from DUAL;

-- ****************************************************************************
-- Tests: View GABES_BIDDERLIST
-- Return: This view creates a table of all users who have bid on an item
--         These tests demonstrate either viewing that entire table, or viewing
--         parts of that table based on a param (such as ITEM_ID or USERNAME)

-- Outputs the entire contents of the view (All Bids)
Select * From GABES_BIDDERLIST;
-- Outputs only the records where the itemID = 5
Select * From GABES_BIDDERLIST Where ITEM_ID = 5;
-- Outputs only the records where the username = tehusen
Select * From GABES_BIDDERLIST Where USERNAME='tehusen';

-- ****************************************************************************
-- Tests: View GABES_VIEWUSERS
-- Return: This view creates a table of all users in the database
--         These tests demonstrate either viewing all of the users, or viewing
--         only a selected user based on an attribute (such as USERNAME)

-- Outputs the entire contents of the view (All Users
Select * From GABES_VIEWUSERS;
-- Can filter users by userid, name, first, last, or email
Select * From GABES_VIEWUSERS Where USERNAME='lJames';

-- ****************************************************************************
-- Tests: Procedure GABES_ADD_USER
-- Return: This procedure adds a new user to the database. The username,
--         email, password, phone, first name, last name, whether they are an 
--         admin or not, the admin who created them, and whether they are a 
--         seller and/or a buyer - will all be specified by the test and then
--         a record with these values will be added to the database.

-- Outputs success message if successful, or an error message if trying to 
-- add a duplicate record already existing in the databse
EXEC GABES_ADD_USER('rclawrence', 'rclawrence@csbsju.edu', 'password', '1234567891', 'Bobby', 'Lawrence', 0, 'tehusen', 1, 1);

-- ****************************************************************************
-- Tests: Procedure GABES_LEAVE_FEEDBACK
-- Return: This procedure adds a new feedback to the database. The item ID,
--         quality rating, delivery rating, overall rating, and comments
--         will be specified by the test and then added to the database.
  
-- Outputs success message if successful, or an error message if trying to 
-- add a duplicate record already existing in the databse
EXEC GABES_LEAVE_FEEDBACK(0000000008, 8, 2, 5, 'Pretty Good');

-- ****************************************************************************
-- Tests: View GABES_SEARCH
-- Return: These test cases will query our GABES_SEARCH view for records that 
--         match the various types of search available.  Using some fields, using
--         all fields, etc.  If you search using ITEM_ID it doesn't ask for any
--         other parameters because there will be only 1 result

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

-- ****************************************************************************
-- Tests: Procedure GABES_NEW_BID
-- Return: This procedure adds a new bid to the database. It sends the item ID,
--         the bidder ID, and the Max Bid. The procedure logs the current time
--         and adds this new record to the database
  
-- Outputs success on successful execution
EXEC GABES_NEW_BID(9, 1, 180);

-- ****************************************************************************
-- Tests: Procedure GABES_CHECK_TIME
-- Return: This procedure checks to see if the auction has ended. If it has it
--         sets the final selling price and the commission fee
  
-- In terms of testing, whenever a new bid is submitted, there's a trigger
-- that will execute this procedure and check if that auction has already ended.
-- If it has the newly submitted bid is invalid and the previous high bid wins.
-- These can be checked with the GABES_NEW_BID function

-- ****************************************************************************
-- Tests: Trigger GABES_AUCTION_ENDED
-- Return: This trigger is our compromise once we couldn't get our scheduler to 
--         work as we intended. What will happen is BEFORE an insertion to the 
--         BIDS table, it will execute a procedure that will check if the auction
--         has ended yet. Based on the results it will act accordingly. 
-- NOTE: The contents of the procedure that it calls are located above - named
--          GABES_CHECK_TIME
  
-- In terms of testing, again, it will be tested upon a new insertion to the 
-- BIDS table

-- ****************************************************************************
-- ****************************************************************************
-- ****************************************************************************
-- ****************************************************************************
--KYLES TEST CASES
-- ****************************************************************************
-- ****************************************************************************
-- ****************************************************************************
-- ****************************************************************************
-- ****************************************************************************


-- ****************************************************************************
-- Tests: Procedure Edit_Item_Category
-- Return: This procedure edits the category for an item that already exists in
-- 	   the database
  
-- Outputs success message if successful, or an error message if trying to 
-- add a duplicate record already existing in the databse
-- Editing it to a null value does nothing to the value and returns a success messgae.
  EXECUTE Edit_Item_Category(1,1,null);
  EXECUTE Edit_Item_Category(1,1,'Clothes');
  
  -- ****************************************************************************
-- Tests: Procedure Edit_Item_Description
-- Return: This procedure edits the description for an item that already exists in
--         the database.
  
-- Outputs success message if successful, or an error message if trying to 
-- add a duplicate record already existing in the databse
-- Editing it to a null value does nothing to the value and returns a success messgae.
  EXECUTE Edit_Item_Description(1,1,null);
  EXECUTE Edit_Item_Description(1,1,'This is the new test description');
  
  -- ****************************************************************************
-- Tests: Procedure Edit_Item_Name
-- Return: This procedure edits the item name for an item that already exists in
--         the database.
  
-- Outputs success message if successful, or an error message if trying to 
-- add a duplicate record already existing in the databse
-- Editing it to a null value does nothing to the value and returns a success messgae.
  EXECUTE Edit_Item_Name(1,1,null);
  EXECUTE Edit_Item_Name(1,1,'Test Item');


  
  -- ****************************************************************************
-- Tests: Procedure POST_ITEM
-- Return: This procedure creates a new item to be auctioned off. The procedure will
-- 	   automatically assign a item id to the new item using a sequence to make
-- 	   sure that it increments correctly.
  
-- Outputs success message if successful, or an error message if trying to 
-- add a duplicate record already existing in the databse
EXECUTE POST_ITEM('Books',0,null,'Big Brother is Watching', null, '1984', null, 18.99, '14-NOV-16 02.21.19.245760000', '29-DEC-18 04.00.00.245760000 AM', 3, null);
  

  -- ****************************************************************************
-- Tests: View LIST_OF_ITEMS_BOUGHT
-- Return: This view returns a view of items that the currents user has bought. It
-- 	   gets the seller name and email by matching the user id key from GABES-USER
-- 	   with the user_id key in LIST_OF_ITEMS_BOUGHT. THE JSP file in phase 4 will
-- 	   pass the current users id as a parameter so for now we just test it by 
--         manually passing a user id.
  
-- Outputs a list of items that a user has bought displaying only the item id, item name
-- item category, start date, end date, start price, selling price, username of the seller
-- as well as the sellers email.
Select l.ITEM_ID, l.ITEM_NAME, l.ITEM_CATEGORY, l.START_DATE, l.END_DATE, l.START_PRICE, l.SELLING_PRICE, g.USERNAME as Seller_Username, g.EMAIL as Seller_Email
from LIST_OF_ITEMS_BOUGHT l, GABES_USER g
WHERE l.Winner_ID = 1 AND l.USER_ID = g.USER_ID;
  


  -- ****************************************************************************
-- Tests: View ITEM_LIST
-- Return: This view returns a view of items that the currents user has put up for 
--         auction. The view gets the seller name and email by matching the user id key 
--         from GABES-USER  with the user_id key in GABES_Items. THE JSP file in phase 4 
--         will pass the current users id as a parameter so for now we just test 
--         it by manually passing a user id.
  
-- Outputs a list of items that a the currents user has put up for 
-- auction displaying only the item id, item name, start date, end date, current bid and sold status.

Select ITEM_ID, ITEM_NAME, START_DATE, END_DATE, START_PRICE, CURRENT_BID, STATUS
from ITEM_LIST
WHERE USER_ID = 6;




  -- ****************************************************************************
-- Tests: Procedure UPDATE_USER_PROFILE_EMAIL
-- Return: This procedure updates the users email for a user that already exists in
--         the database. One piece of the Update profile fuctionallity.
--    	   Passes a user id in from a parameter in the jsp file made in phase 4.
  
-- Outputs success message if successful, or an error message if trying to 
-- add a duplicate record already existing in the databse
-- updating it to a null value does nothing to the value and returns a success messgae.
EXECUTE UPDATE_USER_PROFILE_EMAIL(1,'test1@CSBSJU.EDU');


  -- ****************************************************************************
-- Tests: Procedure Update_User_Profile_FirstName
-- Return: This procedure updates the current user's first name.
--         One piece of the Update profile fuctionallity.
--    	   Passes a user id in from a parameter in the jsp file made in phase 4.
  
-- Outputs success message if successful, or an error message if trying to 
-- add a duplicate record already existing in the databse
-- updating it to a null value does nothing to the value and returns a success messgae.
  EXECUTE Update_User_Profile_FirstName(1,'tester1');


  -- ****************************************************************************
-- Tests: Procedure Update_User_Profile_LastName
-- Return: This procedure updates the current user's last name.
--         One piece of the Update profile fuctionallity.
--    	   Passes a user id in from a parameter in the jsp file made in phase 4.
  
-- Outputs success message if successful, or an error message if trying to 
-- add a duplicate record already existing in the databse
-- updating it to a null value does nothing to the value and returns a success messgae.
  EXECUTE Update_User_Profile_LastName(1,'lasttest1');

  -- ****************************************************************************
-- Tests: Procedure UPDATE_USER_PROFILE_PASSWORD
-- Return: This procedure updates the current user's password.
--         One piece of the Update profile fuctionallity.
--    	   Passes a user id in from a parameter in the jsp file made in phase 4.
  
-- Outputs success message if successful, or an error message if trying to 
-- add a duplicate record already existing in the databse
-- updating it to a null value does nothing to the value and returns a success messgae.
  EXECUTE UPDATE_USER_PROFILE_PASSWORD(1,'tester','newtest','newtest');


  -- ****************************************************************************
-- Tests: Procedure UPDATE_USER_PROFILE_PHONE
-- Return: This procedure updates the current users phone number.
--         One piece of the Update profile fuctionallity.
--    	   Passes a user id in from a parameter in the jsp file made in phase 4.
  
-- Outputs success message if successful, or an error message if trying to 
-- add a duplicate record already existing in the databse
-- updating it to a null value does nothing to the value and returns a success messgae.
  EXECUTE UPDATE_USER_PROFILE_PHONE(1,null);


  -- ****************************************************************************
-- Tests: Procedure UPDATE_USER_PROFILE_USERNAME
-- Return: This procedure updates the current user's username. 
--         One piece of the Update profile fuctionallity.
--    	   Passes a user id in from a parameter in the jsp file made in phase 4.
  
-- Outputs success message if successful, or an error message if trying to 
-- add a duplicate record already existing in the databse
-- updating it to a null value does nothing to the value and returns a success messgae.
  EXECUTE UPDATE_USER_PROFILE_USERNAME(1,'tomRoxs');
  
  
-- ****************************************************************************
-- ****************************************************************************
-- ****************************************************************************
-- ****************************************************************************
-- GRANTS TEST CASES
-- ****************************************************************************
-- ****************************************************************************
-- ****************************************************************************
-- ****************************************************************************
-- ****************************************************************************
  

-- Tests: View ADMIN_COMMISSION_REPORT
-- Return: This view creates a table that keeps track of the commissions for 
--         every sale made on the site. You can specify one user and look at 
--         only their commissions or look at all commissions.
  
-- Gets all commission reports for all users
Select * From ADMIN_COMMISSION_REPORT;
-- Gets commission reports for user with USERNAME = 'gkboyer'
Select * From ADMIN_COMMISSION_REPORT Where USERNAME = 'gkboyer';

-- ****************************************************************************
-- Tests: View SALE_SUMMARY_REPORT
-- Return: This view creates a table that keeps track of the sales made on the 
--         site. You could specify a Category to filter by and get records for
--         sales made of items with that category

-- Gets Summary of all sales that occur on the site
Select * FROM Sale_Summary_Report;
-- Gets Summary of all sales for items with a 'Books' category
Select * FROM Sale_Summary_Report Where ITEM_CATEGORY LIKE '%Books';
  
-- ****************************************************************************
-- Tests: View BID_STATUS
-- Return: This view creates a table that will give item info about any items 
--         that have been won.  It allows you to search by user so you could
--         see the purchase history for a specific user

-- Get all items that have been bid on
Select * FROM Bid_Status;
-- Gets the status of items bid on by the user with USERNAME=lJames
Select * FROM Bid_Status Where USERNAME = 'lJames';

-- ****************************************************************************
-- Tests: View USERS_RATINGS
-- Return: This view creates a table that keeps track of the ratings made on
--         the site. You can specify a USER_ID and only get records that match 
--         that user ID.

-- Gets the info for any feedback for the user with USER_ID = 4
Select * From USERS_RATING Where USER_ID = 4;

-- ****************************************************************************
-- Tests: Trigger GABES_BID_TRIGGER
-- Return: This trigger will execute on a new addition to the bids table. Updating
--         the current bid in the ITEMS table accordingly with the new info

-- In terms of testing, it will be checked upon a new additon to the BIDS table
-- Below is a function that could be ran to test this functionality
EXEC GABES_NEW_BID(9, 1, 180);

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
