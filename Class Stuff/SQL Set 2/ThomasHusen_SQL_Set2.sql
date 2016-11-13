-- Problem #1 - *** DONE ***
CREATE OR REPLACE VIEW ProductDeals_CustomerWorth AS
  Select t.CUSTOMER_NUMBER, 
      SUM(tp.QUOTED_PRICE * tp.NUMBER_ORDERED) as Total_Spent, 
      COUNT(DISTINCT(tp.TRANS_NUMBER)) as Number_of_Transactions
  From PRODUCTDEALS_TRANS t, PRODUCTDEALS_TRANSPART tp
  Where t.TRANS_NUMBER = tp.TRANS_NUMBER
  Group By t.CUSTOMER_NUMBER;
  
-- Test call for view for problem #1
Select * From ProductDeals_CustomerWorth;

-- Output from test call
--311	549.98	1
--256	45.9	1
--124	391.44	2
--522	777.68	2
--315	1119.96	1


-- Problem #2 - *** DONE ***
CREATE OR REPLACE TRIGGER ProductDeals_QuantityOnHand
  AFTER INSERT ON PRODUCTDEALS_TRANSPART
  FOR EACH ROW
  BEGIN
    Update PRODUCTDEALS_PART
    Set UNITS_ON_HAND = UNITS_ON_HAND - :NEW.NUMBER_ORDERED
    Where PART_NUMBER = :NEW.PART_NUMBER;
  END;
  
-- OUTPUT
-- Trigger PRODUCTDEALS_QUANTITYONHAND compiled

    
Select * From PRODUCTDEALS_PART;
-- OUTPUT
--AX12	Iron        	104	24.95
--AZ52	Dartboard   	20	12.95
--BA74	Basketball  	40	29.95
--BH22	Cornpopper  	95	25.95
--BT04	Gas Grill   	11	149.99
--BZ66	Washer      	52	399.99
--CA14	Griddle     	78	39.99
--CB03	Bike        	44	399.99
--CX11	Blender     	112	22.95
--CZ81	Treadmill   	68	349.95

Insert INTO PRODUCTDEALS_TRANSPART VALUES('12504','AZ52', 10, 12.95);
-- OUTPUT
-- 1 row inserted.

Select * From PRODUCTDEALS_PART;
-- OUTPUT
--AX12	Iron        	104	24.95
--AZ52	Dartboard   	10	12.95
--BA74	Basketball  	40	29.95
--BH22	Cornpopper  	95	25.95
--BT04	Gas Grill   	11	149.99
--BZ66	Washer      	52	399.99
--CA14	Griddle     	78	39.99
--CB03	Bike        	44	399.99
--CX11	Blender     	112	22.95
--CZ81	Treadmill   	68	349.95



-- Problem #3 -> *** DONE ***
CREATE OR REPLACE FUNCTION ProductDeals_CUST_TRANS_Func(custNum int) RETURN int AS
  transNum int := 0;
  BEGIN
    Select COUNT(*) into transNum
    From PRODUCTDEALS_TRANS t
    Where custNum = t.CUSTOMER_NUMBER;
    If (transNum<0)
      Then transNum :=0;
    End If;
    Return transNum;
  END;

-- Test 1 Statements
Select * From PRODUCTDEALS_TRANS Where CUSTOMER_NUMBER='124';
Select ProductDeals_CUST_TRANS_FUNC('124') From DUAL;
-- OUTPUT
-- 12489	02-SEP-02	124
-- 12500	05-SEP-02	124
--
-- 2
-- Test 2 Statements
Select * From PRODUCTDEALS_TRANS Where CUSTOMER_NUMBER='111';
Select PRODUCTDEALS_CUST_TRANS_FUNC('111') From DUAL;
-- OUTPUT
-- empty table
--
-- 0


-- Problem #4 - *** DONE ***
CREATE OR REPLACE PROCEDURE ProductDeals_UP_LIMIT_Proc(custNum int, partNum VARCHAR) AS
  BEGIN
    Update PRODUCTDEALS_CUSTOMER c
    Set CREDIT_LIMIT = (1.1*CREDIT_LIMIT)
    Where CUSTOMER_NUMBER = (Select t.CUSTOMER_NUMBER
                             From PRODUCTDEALS_TRANS t, PRODUCTDEALS_TRANSPART tp
                             Where t.CUSTOMER_NUMBER = custNum and
                                   tp.PART_NUMBER = partNum and
                                   t.TRANS_NUMBER = tp.TRANS_NUMBER);
  END;

-- TEST 1
Select CREDIT_LIMIT From PRODUCTDEALS_CUSTOMER Where CUSTOMER_NUMBER='124';
-- OUTPUT
--1000

EXEC PRODUCTDEALS_UP_LIMIT_Proc('124', 'AX12');
-- OUTPUT
--PL/SQL procedure successfully completed.

Select CREDIT_LIMIT From PRODUCTDEALS_CUSTOMER Where CUSTOMER_NUMBER='124';
-- OUTPUT
-- 1100

-- TEST 2
Select CREDIT_LIMIT From PRODUCTDEALS_CUSTOMER Where CUSTOMER_NUMBER='124';
-- OUTPUT
-- 1100

EXEC PRODUCTDEALS_UP_LIMIT_Proc('124', 'BZ66');
-- OUTPUT
-- PL/SQL procedure successfully completed.

Select CREDIT_LIMIT From PRODUCTDEALS_CUSTOMER Where CUSTOMER_NUMBER='124';
-- OUTPUT
-- 1100