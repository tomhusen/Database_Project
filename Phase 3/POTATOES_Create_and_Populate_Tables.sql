-- *****************************************************************************
-- Creates a new sequence for generating next users number
DROP SEQUENCE new_user_seq;
CREATE SEQUENCE new_user_seq
  MAXVALUE 99999
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

-- Creates a new sequence for generating next item number
DROP SEQUENCE new_item_seq;
CREATE SEQUENCE new_item_seq
  MAXVALUE 9999999999
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

-- Create table for the Users - has all attributes
DROP TABLE GABES_USER CASCADE CONSTRAINTS;
CREATE TABLE GABES_USER(
  USER_ID CHAR(6) PRIMARY KEY,
  USERNAME VARCHAR(15) NOT NULL UNIQUE,
  EMAIL VARCHAR(30) NOT NULL UNIQUE,
  PASS VARCHAR(15) NOT NULL,                      
  PHONE VARCHAR(10),
  FIRST_N VARCHAR(12),
  LAST_N VARCHAR(12),
  IS_ADMIN CHAR(1),
  A_USERNAME VARCHAR(15),
  IS_SELLER CHAR(1),
  IS_BUYER CHAR(1)
  );



-- Create table for the Items - has all attributes (Check requirements for unique, etc.
DROP TABLE GABES_ITEM CASCADE CONSTRAINTS;
CREATE TABLE GABES_ITEM(
  ITEM_ID CHAR(10) PRIMARY KEY,
  ITEM_CATEGORY VARCHAR(15),
  STATUS CHAR(1) NOT NULL,                  -- 0=Not Sold and 1=Sold                     
  SELLING_PRICE DECIMAL(7, 2),
  DESCRIPTION VARCHAR(100),
  COMMISSION_FEE DECIMAL(7, 2),
  ITEM_NAME VARCHAR(30) NOT NULL,
  CURRENT_BID DECIMAL(7, 2),
  START_PRICE DECIMAL(7, 2) NOT NULL,
  START_DATE TIMESTAMP NOT NULL,
  END_DATE TIMESTAMP NOT NULL,
  USER_ID CHAR(6) NOT NULL,
  WINNER_ID CHAR(6),

  FOREIGN KEY (USER_ID) REFERENCES GABES_USER(USER_ID) ON DELETE CASCADE
  );

-- Create table for the Feedback - has all attributes
DROP TABLE GABES_FEEDBACK CASCADE CONSTRAINTS;
CREATE TABLE GABES_FEEDBACK(
  ITEM_ID CHAR(10) PRIMARY KEY,
  ITEM_QUALITY CHAR(2),                       
  DELIVERY CHAR(2),                           
  OVERALL_RATING CHAR(2),                     
  COMMENTS VARCHAR(100),
  
  FOREIGN KEY (ITEM_ID) REFERENCES GABES_ITEM(ITEM_ID) ON DELETE CASCADE
    );

-- Create table for the Bids
DROP TABLE GABES_BIDS CASCADE CONSTRAINTS;
CREATE TABLE GABES_BIDS(
  ITEM_ID CHAR(10),
  BIDDER_ID CHAR(6),
  BIDDING_TIME TIMESTAMP(0),               
  MAX_BID DECIMAL(7, 2),
  
  CONSTRAINT PK_BIDS PRIMARY KEY(ITEM_ID, BIDDER_ID, BIDDING_TIME),

  FOREIGN KEY (ITEM_ID) REFERENCES GABES_ITEM(ITEM_ID) ON DELETE CASCADE,
  FOREIGN KEY (BIDDER_ID) REFERENCES GABES_USER(USER_ID) ON DELETE CASCADE
  );

-- ************************************************************
-- ************************************************************
-- ************************************************************

-- Insertions for the GABES_USER table
-- User(User ID, Username, Email, Password, Phone #, First Name, Last Name, is_admin?, admin who created user, is_seller?, is bidder?)

Insert Into GABES_USER VALUES
  (new_user_seq.NEXTVAL, 'tehusen', 'tehusen@csbsju.edu', 'p@$$word', '1234567890', 'Tom', 'Husen', 1, 'tehusen', 1, 1);
Insert Into GABES_USER VALUES
  (new_user_seq.NEXTVAL, 'gkboyer', 'gkboyer@csbsju.edu', 'p@$$word1', '1234567890', 'Grant', 'Boyer', 1, 'gkboyer', 1, 1);
Insert Into GABES_USER VALUES
  (new_user_seq.NEXTVAL, 'kaolson', 'kaolson@csbsju.edu', 'p@$$word2', '1234567890', 'Kyle', 'Olson', 1, 'kaolson', 1, 1);
Insert Into GABES_USER VALUES
  (new_user_seq.NEXTVAL, 'irahal', 'irahal@csbsju.edu', 'puppies123', '3203632837', 'Imad', 'Rahal', 0, 'tehusen', 1, 1);
Insert Into GABES_USER VALUES
  (new_user_seq.NEXTVAL, 'aSmith', 'aSmith55@gmail.com', 'kitties321', '3203631234', 'Alex', 'Smith', 0, 'kaolson', 1, 1);
Insert Into GABES_USER VALUES
  (new_user_seq.NEXTVAL, 'bJohnson', 'bradJohnson@hotmail.com', 'CSBSJUrox', '6129546532', 'Bradley', 'Johnson', 0, 'kaolson', 1, 1);
Insert Into GABES_USER VALUES
  (new_user_seq.NEXTVAL, 'jrSmith', 'jrSmith@cavs.com', 'goCavs', '9521234567', 'JR', 'Smith', 0, 'gkboyer', 1, 1);
Insert Into GABES_USER VALUES
  (new_user_seq.NEXTVAL, 'lJames', 'LeBron-J@yahoo.com', 'FlopAllDay', '6519842681', 'LeBron', 'James', 0, 'gkboyer', 1, 1);




-- Insertions for the GABES_ITEM table
-- Item(Item ID, Category, Sold?, Selling Price (Final Bid), Description, Commission, Name, Current Bid, Start Price, Start Date, End Date, Seller ID, Winner_ID)

Insert Into GABES_ITEM VALUES
  (new_item_seq.NEXTVAL, 'Books', 1, 20.00, 'Book for Computer Science class', 5.00, 'Database Systems', 20.00, 15.00, CURRENT_TIMESTAMP, TO_TIMESTAMP('2016-12-25 06:15:00', 'YYYY-MM-DD HH24:MI:SS'), 00002, 00008);

Insert Into GABES_ITEM VALUES
  (new_item_seq.NEXTVAL, 'Cooking', 1, 25.00, 'Frying pan for cooking', 3.00, 'Non-Stick Skillet', 25.00, 17.99,  CURRENT_TIMESTAMP, TO_TIMESTAMP('2016-12-25 06:15:00', 'YYYY-MM-DD HH24:MI:SS'), 00002, 00007);

Insert Into GABES_ITEM VALUES
  (new_item_seq.NEXTVAL, 'Movies', 0, NULL, '2016 Disney-Pixar Film', NULL, 'Finding Dory', NULL, 19.99, CURRENT_TIMESTAMP, TO_TIMESTAMP('2016-12-25 06:15:00', 'YYYY-MM-DD HH24:MI:SS'), 00001, NULL);

Insert Into GABES_ITEM VALUES
  (new_item_seq.NEXTVAL, 'Books', 0, NULL, 'NY Times Bestseller!', NULL, 'The Da Vinci Code', NULL, 18.00, CURRENT_TIMESTAMP, TO_TIMESTAMP('2016-12-25 06:15:00', 'YYYY-MM-DD HH24:MI:SS'), 00002, NULL);

Insert Into GABES_ITEM VALUES
  (new_item_seq.NEXTVAL, 'Books', 0, NULL, 'Biography by Walter Issacson', NULL, 'Steve Jobs', NULL, 21.99, CURRENT_TIMESTAMP, TO_TIMESTAMP('2016-12-25 06:15:00', 'YYYY-MM-DD HH24:MI:SS'), 00006, NULL);

Insert Into GABES_ITEM VALUES
  (new_item_seq.NEXTVAL, 'Movies', 0, NULL, 'The second Avengers Movie', NULL, 'Avengers: Age of Ultron', NULL, 19.99, CURRENT_TIMESTAMP, TO_TIMESTAMP('2016-12-25 06:15:00', 'YYYY-MM-DD HH24:MI:SS'), 00004, NULL);

Insert Into GABES_ITEM VALUES
  (new_item_seq.NEXTVAL, 'Electronics', 0, NULL, 'Also doubles as a fire starter', NULL, 'Samsung Note 7', NULL, 199.99, CURRENT_TIMESTAMP, TO_TIMESTAMP('2016-12-25 06:15:00', 'YYYY-MM-DD HH24:MI:SS'), 00007, NULL);

Insert Into GABES_ITEM VALUES
  (new_item_seq.NEXTVAL, 'Merchandise', 0, NULL, 'Authentic Steph Curry Jersey', NULL, 'Curry #30 Jersey', NULL, 64.95, CURRENT_TIMESTAMP, TO_TIMESTAMP('2016-12-25 06:15:00', 'YYYY-MM-DD HH24:MI:SS'), 00003, NULL);

Insert Into GABES_ITEM VALUES
  (new_item_seq.NEXTVAL, 'Clothing', 0, NULL, 'The North Face ultra-warm winter jacket', NULL, 'North Face Jacket', NULL, 149.99, CURRENT_TIMESTAMP, TO_TIMESTAMP('2016-12-25 06:15:00', 'YYYY-MM-DD HH24:MI:SS'), 00004, NULL);


-- Insertions for the GABES_FEEDBACK table
-- Feedback(Item ID, Item Quality, Delivery, Overall Rating, Comments)
Insert Into GABES_FEEDBACK VALUES
  (2, 4, 5, 4, 'Decent pan, does not cook evenly though.');
Insert Into GABES_FEEDBACK VALUES
  (3, 9, 5, 8, 'Excellent movie - delivery was late though');
Insert Into GABES_FEEDBACK VALUES
  (7, 1, 1, 1, 'Sucks.  It started on fire. ');
Insert Into GABES_FEEDBACK VALUES
  (9, 10, 10, 10, '');
Insert Into GABES_FEEDBACK VALUES
  (6, 8, 3, 7, 'Pretty good movie - slow to deliver though');


-- Insertions for the GABES_BIDS table
-- Bids(Item ID, Bid ID, Bidding_Time, Time of Bid, Max Bid)
Insert Into GABES_BIDS VALUES
  (1, 000008, CURRENT_TIMESTAMP, 20.00);
Insert Into GABES_BIDS VALUES
  (2, 000007, CURRENT_TIMESTAMP, 25.00);

