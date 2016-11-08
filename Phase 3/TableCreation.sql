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
  A_USERNAME VARCHAR(15),
  IS_SELLER CHAR(1),
  IS_BUYER CHAR(1),
  
  FOREIGN KEY (A_USERNAME) REFERENCES GABES_ADMIN(A_USERNAME)
  );

-- Create table for the Admins - has all attributes
DROP TABLE GABES_ADMIN CASCADE CONSTRAINTS;
CREATE TABLE GABES_ADMIN(
  A_USERNAME VARCHAR(15) PRIMARY KEY,
  PASS VARCHAR(15) NOT NULL
  );


-- Create table for the Items - has all attributes (Check requirements for unique, etc.
DROP TABLE GABES_ITEM CASCADE CONSTRAINTS;
CREATE TABLE GABES_ITEM(
  ITEM_ID CHAR(10) PRIMARY KEY,
  ITEM_CATEGORY VARCHAR(15),
  STATUS CHAR(1) NOT NULL,                     -- Will be 0=SOLD or 1=NOT_SOLD
  SELLING_PRICE DECIMAL(7, 2),
  DESCRIPTION VARCHAR(100),
  COMMISSION_FEE DECIMAL(7, 2),
  ITEM_NAME VARCHAR(20) NOT NULL,
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
  ITEM_ID CHAR(6) PRIMARY KEY,
  ITEM_QUALITY CHAR(1),                       -- Will be value 1-10
  DELIVERY CHAR(1),                           -- Will be value 1-10
  OVERALL_RATING CHAR(1),                     -- Will be value 1-10
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
Insert Into GABES_USER VALUES
  (000001, 'tehusen', 'tehusen@csbsju.edu', 'p@$$word', '1234567890', 'Tom', 'Husen', 'tehusen', 1, 1);
Insert Into GABES_USER VALUES
  (000002, 'gkboyer', 'gkboyer@csbsju.edu', 'p@$$word1', '1234567890', 'Grant', 'Boyer', 'gkboyer', 1, 1);
Insert Into GABES_USER VALUES
  (000003, 'kaolson', 'kaolson@csbsju.edu', 'p@$$word2', '1234567890', 'Kyle', 'Olson', 'kaolson', 1, 1);
Insert Into GABES_USER VALUES
  (000004, 'irahal', 'irahal@csbsju.edu', 'p@$$word', '1234567890', 'Imad', 'Rahal', 'tehusen', 1, 1);
  
  
  
-- Insertions for the GABES_ADMIN table
Insert Into GABES_ADMIN VALUES
  ('tehusen', 'p@$$word');
Insert Into GABES_ADMIN VALUES
  ('gkboyer', 'p@$$word1');
Insert Into GABES_ADMIN VALUES
  ('kaolson', 'p@$$word2');



-- Insertions for the GABES_ITEM table
Insert Into GABES_ITEM VALUES
  (0000000001, 'Books', 0, NULL, 'Book for Computer Science class', NULL, 'Database Systems', NULL, 15.00, to_date('2016-11-10','YYYY-MM-DD'), to_date('2016-12-02','YYYY-MM-DD'), 00001);
Insert Into GABES_ITEM VALUES
  (0000000002, 'Cooking', 0, NULL, 'Frying pan for cooking', NULL, 'Non-Stick Skillet', NULL, 17.99, to_date('2016-11-08','YYYY-MM-DD'), to_date('2016-12-01','YYYY-MM-DD'), 00001);
Insert Into GABES_ITEM VALUES
  (0000000003, 'Movies', 0, NULL, '2016 Disney-Pixar Film', NULL, 'Finding Dory', NULL, 19.99, to_date('2016-11-07','YYYY-MM-DD'), to_date('2016-11-24','YYYY-MM-DD'), 00001);



-- Insertions for the GABES_FEEDBACK table
Insert Into GABES_FEEDBACK VALUES
  (0000000002, 4, 5, 4, 'Decent pan, does not cook evenly though.');
Insert Into GABES_FEEDBACK VALUES
  (0000000003, 9, 5, 8, 'Excellent movie - delivery was late though');



