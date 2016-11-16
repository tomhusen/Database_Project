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
--         auction. The view gets the seller name and email by matching the user id key --         from GABES-USER  with the user_id key in GABES_Items. THE JSP file in phase 4 --         will pass the current users id as a parameter so for now we just test --         it by manually passing a user id.
  
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
  
  
