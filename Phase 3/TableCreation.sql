-- *** GENERAL NOTES ***
-- For IS_ATTRIBUTE attributes (Seller, Buyer, Admin, etc)  and any other boolean value
--    0 will denote false, and 1 will denote true.  These are CHAR(1) datatypes
-- Dropped the Admin table for now - seems a lot simpler to have a boolean value
--    for is_admin rather than a whole table just to have a single attribute
-- *********************************************************
-- *********************************************************
-- *********************************************************



-- Create table for the Users - has all attributes
DROP TABLE GABES_USER CASCADE CONSTRAINTS;
CREATE TABLE GABES_USER(
  USER_ID CHAR(6) PRIMARY KEY,
  USERNAME VARCHAR(15) NOT NULL UNIQUE,
  EMAIL VARCHAR(30) NOT NULL UNIQUE,
  PASS VARCHAR(15) NOT NULL,                      -- PASSWORD is keyword so we'll use PASS
  PHONE VARCHAR(10),
  FIRST_N VARCHAR(12),
  LAST_N VARCHAR(12),
  IS_ADMIN CHAR(1),
  A_USERNAME VARCHAR(15),
  IS_SELLER CHAR(1),
  IS_BUYER CHAR(1) --,

 -- FOREIGN KEY (A_USERNAME) REFERENCES GABES_ADMIN(A_USERNAME)
  );

---- Create table for the Admins - has all attributes
--DROP TABLE GABES_ADMIN CASCADE CONSTRAINTS;
--CREATE TABLE GABES_ADMIN(
--  A_USERNAME VARCHAR(15) PRIMARY KEY,
--  PASS VARCHAR(15) NOT NULL
--  );


-- Create table for the Items - has all attributes (Check requirements for unique, etc.
DROP TABLE GABES_ITEM CASCADE CONSTRAINTS;
CREATE TABLE GABES_ITEM(
  ITEM_ID CHAR(10) PRIMARY KEY,
  ITEM_CATEGORY VARCHAR(15),
  STATUS CHAR(1) NOT NULL,                     -- Will be 0=SOLD or 1=NOT_SOLD
  SELLING_PRICE DECIMAL(7, 2),
  DESCRIPTION VARCHAR(100),
  COMMISSION_FEE DECIMAL(7, 2),
  ITEM_NAME VARCHAR(30) NOT NULL,
  CURRENT_BID DECIMAL(7, 2),
  START_PRICE DECIMAL(7, 2) NOT NULL,
  START_DATE DATE NOT NULL,
  END_DATE DATE NOT NULL,
  USER_ID CHAR(6) NOT NULL,

  FOREIGN KEY (USER_ID) REFERENCES GABES_USER(USER_ID)
  );

-- Create table for the Feedback - has all attributes
DROP TABLE GABES_FEEDBACK CASCADE CONSTRAINTS;
CREATE TABLE GABES_FEEDBACK(
  ITEM_ID CHAR(10) PRIMARY KEY,
  ITEM_QUALITY CHAR(2),                       -- Will be value 1-10
  DELIVERY CHAR(2),                           -- Will be value 1-10
  OVERALL_RATING CHAR(2),                     -- Will be value 1-10
  COMMENTS VARCHAR(100)
  );

-- Create table for the Bids
DROP TABLE GABES_BIDS CASCADE CONSTRAINTS;
CREATE TABLE GABES_BIDS(
  ITEM_ID CHAR(10) PRIMARY KEY,
  USER_ID CHAR(6),
  BIDDING_TIME DECIMAL(15,15),                -- Probably need to change this data type
  MAX_BID DECIMAL(7, 2),

  FOREIGN KEY (ITEM_ID) REFERENCES GABES_ITEM(ITEM_ID),
  FOREIGN KEY (USER_ID) REFERENCES GABES_USER(USER_ID)
  );

-- ************************************************************
-- ************************************************************
-- ************************************************************

-- Insertions for the GABES_USER table
-- User(User ID, Username, Email, Password, Phone #, First Name, Last Name, is_admin?, admin who created user, is_seller?, is bidder?)

Insert Into GABES_USER VALUES
  (000001, 'tehusen', 'tehusen@csbsju.edu', 'p@$$word', '1234567890', 'Tom', 'Husen', 1, 'tehusen', 1, 1);
Insert Into GABES_USER VALUES
  (000002, 'gkboyer', 'gkboyer@csbsju.edu', 'p@$$word1', '1234567890', 'Grant', 'Boyer', 1, 'gkboyer', 1, 1);
Insert Into GABES_USER VALUES
  (000003, 'kaolson', 'kaolson@csbsju.edu', 'p@$$word2', '1234567890', 'Kyle', 'Olson', 1, 'kaolson', 1, 1);
Insert Into GABES_USER VALUES
  (000004, 'irahal', 'irahal@csbsju.edu', 'puppies123', '3203632837', 'Imad', 'Rahal', 0, 'tehusen', 1, 1);
Insert Into GABES_USER VALUES
  (000005, 'aSmith', 'aSmith55@gmail.com', 'kitties321', '3203631234', 'Alex', 'Smith', 0, 'kaolson', 1, 1);
Insert Into GABES_USER VALUES
  (000006, 'bJohnson', 'bradJohnson@hotmail.com', 'CSBSJUrox', '6129546532', 'Bradley', 'Johnson', 0, 'kaolson', 1, 1);
Insert Into GABES_USER VALUES
  (000007, 'jrSmith', 'jrSmith@cavs.com', 'goCavs', '9521234567', 'JR', 'Smith', 0, 'gkboyer', 1, 1);
Insert Into GABES_USER VALUES
  (000008, 'lJames', 'LeBron-J@yahoo.com', 'FlopAllDay', '6519842681', 'LeBron', 'James', 0, 'gkboyer', 1, 1);



---- Insertions for the GABES_ADMIN table
--Insert Into GABES_ADMIN VALUES
--  ('tehusen', 'p@$$word');
--Insert Into GABES_ADMIN VALUES
--  ('gkboyer', 'p@$$word1');
--Insert Into GABES_ADMIN VALUES
--  ('kaolson', 'p@$$word2');



-- Insertions for the GABES_ITEM table
-- Item(Item ID, Category, Sold?, Selling Price (Final Bid), Description, Commission, Name, Current Bid, Start Price, Start Date, End Date, Seller ID)

Insert Into GABES_ITEM VALUES
  (0000000001, 'Books', 0, NULL, 'Book for Computer Science class', NULL, 'Database Systems', NULL, 15.00, to_date('2016-12-10','YYYY-MM-DD'), to_date('2016-12-20','YYYY-MM-DD'), 00001);

Insert Into GABES_ITEM VALUES
  (0000000002, 'Cooking', 0, NULL, 'Frying pan for cooking', NULL, 'Non-Stick Skillet', NULL, 17.99, to_date('2016-12-08','YYYY-MM-DD'), to_date('2016-12-10','YYYY-MM-DD'), 00001);

Insert Into GABES_ITEM VALUES
  (0000000003, 'Movies', 0, NULL, '2016 Disney-Pixar Film', NULL, 'Finding Dory', NULL, 19.99, to_date('2016-12-07','YYYY-MM-DD'), to_date('2016-12-24','YYYY-MM-DD'), 00001);

Insert Into GABES_ITEM VALUES
  (0000000004, 'Books', 0, NULL, 'NY Times Bestseller!', NULL, 'The Da Vinci Code', NULL, 18.00, to_date('2016-12-15','YYYY-MM-DD'), to_date('2016-12-20','YYYY-MM-DD'), 00002);

Insert Into GABES_ITEM VALUES
  (0000000005, 'Books', 0, NULL, 'Biography by Walter Issacson', NULL, 'Steve Jobs', NULL, 21.99, to_date('2016-12-15','YYYY-MM-DD'), to_date('2016-12-19','YYYY-MM-DD'), 00006);

Insert Into GABES_ITEM VALUES
  (0000000006, 'Movies', 0, NULL, 'The second Avengers Movie', NULL, 'Avengers: Age of Ultron', NULL, 19.99, to_date('2016-12-07','YYYY-MM-DD'), to_date('2016-12-24','YYYY-MM-DD'), 00004);

Insert Into GABES_ITEM VALUES
  (0000000007, 'Electronics', 0, NULL, 'Also doubles as a fire starter', NULL, 'Samsung Note 7', NULL, 199.99, to_date('2016-12-10','YYYY-MM-DD'), to_date('2016-12-15','YYYY-MM-DD'), 00007);

Insert Into GABES_ITEM VALUES
  (0000000008, 'Merchandise', 0, NULL, 'Authentic Steph Curry Jersey', NULL, 'Curry #30 Jersey', NULL, 64.95, to_date('2016-12-08','YYYY-MM-DD'), to_date('2016-12-27','YYYY-MM-DD'), 00003);

Insert Into GABES_ITEM VALUES
  (0000000009, 'Clothing', 0, NULL, 'The North Face ultra-warm winter jacket', NULL, 'North Face Jacket', NULL, 149.99, to_date('2016-12-07','YYYY-MM-DD'), to_date('2016-12-22','YYYY-MM-DD'), 00004);


-- Insertions for the GABES_FEEDBACK table
-- Feedback(Item ID, Item Quality, Delivery, Overall Rating, Comments)
Insert Into GABES_FEEDBACK VALUES
  (0000000002, 4, 5, 4, 'Decent pan, does not cook evenly though.');
Insert Into GABES_FEEDBACK VALUES
  (0000000003, 9, 5, 8, 'Excellent movie - delivery was late though');
Insert Into GABES_FEEDBACK VALUES
  (0000000007, 1, 1, 1, 'Sucks.  It started on fire. ');
Insert Into GABES_FEEDBACK VALUES
  (0000000009, 10, 10, 10, '');
Insert Into GABES_FEEDBACK VALUES
  (0000000006, 8, 3, 7, 'Pretty good movie - slow to deliver though');
--Insert Into GABES_FEEDBACK VALUES
--  (0000000007, 1, 8, 1, 'Super quick delivery - but the box was in flames');
