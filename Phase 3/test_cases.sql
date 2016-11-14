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
  
  
  
  
  
