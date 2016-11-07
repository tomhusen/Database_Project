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

Insert Into GABES_USER VALUES
  (000001, 'tehusen', 'tehusen@csbsju.edu', 'p@$$word', '1234567890', 'Tom', 'Husen', 'tehusen', 1, 1);




















