DROP TABLE  ProductDeals_SalesRep CASCADE CONSTRAINTS;
CREATE TABLE ProductDeals_SalesRep(
	SLSREP_NUMBER CHAR(2) PRIMARY KEY,
	LAST VARCHAR(10),
	FIRST VARCHAR(10),
	STREET VARCHAR(15),
	CITY VARCHAR(15),
	STATE CHAR(2),
	ZIP_CODE CHAR(5),
	COMMISSION_RATE DECIMAL(3,2));

DROP TABLE ProductDeals_CUSTOMER CASCADE CONSTRAINTS;
CREATE TABLE ProductDeals_CUSTOMER(
	CUSTOMER_NUMBER CHAR(3) PRIMARY KEY,
	LAST VARCHAR(10) NOT NULL,
	FIRST VARCHAR(10) NOT NULL,
	STREET VARCHAR(15),
	CITY VARCHAR(15),
	STATE CHAR(2),
	ZIP_CODE CHAR(5),
	BALANCE DECIMAL(7,2),
	CREDIT_LIMIT DECIMAL(6,2),
	SLSREP_NUMBER CHAR(2),
	FOREIGN KEY (SLSREP_NUMBER) REFERENCES ProductDeals_SalesRep(SLSREP_NUMBER) 
    ON DELETE SET NULL);

DROP TABLE ProductDeals_TRANS CASCADE CONSTRAINTS;
CREATE TABLE ProductDeals_TRANS(
	TRANS_NUMBER CHAR(5) PRIMARY KEY,
	TRANS_DATE DATE,
	CUSTOMER_NUMBER CHAR(3),
	FOREIGN KEY (CUSTOMER_NUMBER) REFERENCES ProductDeals_CUSTOMER(CUSTOMER_NUMBER) 
    ON DELETE SET NULL);
	
DROP TABLE ProductDeals_PART CASCADE CONSTRAINTS;	
CREATE TABLE ProductDeals_PART(
	PART_NUMBER CHAR(4) PRIMARY KEY,
	PART_DESCRIPTION CHAR(12),
	UNITS_ON_HAND DECIMAL(4,0),
	UNIT_PRICE DECIMAL(6,2));

DROP TABLE ProductDeals_TransPart CASCADE CONSTRAINTS;	
CREATE TABLE ProductDeals_TransPart(
	TRANS_NUMBER CHAR(5),
	PART_NUMBER CHAR(4),
	NUMBER_ORDERED DECIMAL(3,0),
	QUOTED_PRICE DECIMAL(6,2),
	PRIMARY KEY (TRANS_NUMBER, PART_NUMBER),
	FOREIGN KEY (TRANS_NUMBER) REFERENCES ProductDeals_TRANS(TRANS_NUMBER) 
    ON DELETE CASCADE,
	FOREIGN KEY (PART_NUMBER) REFERENCES ProductDeals_PART(PART_NUMBER) 
    ON DELETE CASCADE);


Insert Into ProductDeals_SALESREP values ('03','Jones','Mary','123 Main','Grant','MI','49219',.05);
Insert Into ProductDeals_SALESREP values ('06','Smith','William','102 Raymond','Ada','MI','49441',.07);
Insert Into ProductDeals_SALESREP values ('12','Diaz','Miguel','410 Harper','Lansing','MI','49224',.05);

Insert Into ProductDeals_CUSTOMER values ('124','Adams','Sally','481 Oak','Lansing','MI','49224',818.75,1000,'03');
Insert Into ProductDeals_CUSTOMER values ('256','Samuels','Ann','215 Pete','Grant','MI','49219',21.50,1500,'06');
Insert Into ProductDeals_CUSTOMER values ('311','Charles','Don','48 College','Ira','MI','49034',825.75,1000,'12');
Insert Into ProductDeals_CUSTOMER values ('315','Daniels','Tom','914 Cherry','Kent','MI','48391',770.75,750,'06');
Insert Into ProductDeals_CUSTOMER values ('405','William','Al','519 Watson','Grant','MI','49219',402.75,1500,'12');
Insert Into ProductDeals_CUSTOMER values ('412','Adams','Sally','16 Elm','Lansing','MI','49224',1817.5,2000,'03');
Insert Into ProductDeals_CUSTOMER values ('522','Nelson','Mary','108 Pine','Ada','MI','49441',98.75,1500,'12');
Insert Into ProductDeals_CUSTOMER values ('567','Dinh','Tran','808 Ridge','Harper','MI','49421',402.40,750,'06');
Insert Into ProductDeals_CUSTOMER values ('587','Galvez','Mara','512 Pine','Ada','MI','49441',114.6,1000,'06');
Insert Into ProductDeals_CUSTOMER values ('622','Martin','Dan','419 Chip','Grant','MI','49219',1045.75,1000,'03');

Insert Into ProductDeals_TRANS values('12489',to_date('2002-09-02','YYYY-MM-DD'),'124');
Insert Into ProductDeals_TRANS values('12491',to_date('2002-09-02','YYYY-MM-DD'),'311');
Insert Into ProductDeals_TRANS values('12494',to_date('2002-09-04','YYYY-MM-DD'),'315');
Insert Into ProductDeals_TRANS values('12495',to_date('2002-09-04','YYYY-MM-DD'),'256');
Insert Into ProductDeals_TRANS values('12498',to_date('2002-09-05','YYYY-MM-DD'),'522');
Insert Into ProductDeals_TRANS values('12500',to_date('2002-09-05','YYYY-MM-DD'),'124');
Insert Into ProductDeals_TRANS values('12504',to_date('2002-09-05','YYYY-MM-DD'),'522');

Insert Into ProductDeals_PART values('AX12','Iron',104,24.95);
Insert Into ProductDeals_PART values('AZ52','Dartboard',20,12.95);
Insert Into ProductDeals_PART values('BA74','Basketball',40,29.95);
Insert Into ProductDeals_PART values('BH22','Cornpopper',95,25.95);
Insert Into ProductDeals_PART values('BT04','Gas Grill',11,149.99);
Insert Into ProductDeals_PART values('BZ66','Washer',52,399.99);
Insert Into ProductDeals_PART values('CA14','Griddle',78,39.99);
Insert Into ProductDeals_PART values('CB03','Bike',44,399.99);
Insert Into ProductDeals_PART values('CX11','Blender',112,22.95);
Insert Into ProductDeals_PART values('CZ81','Treadmill',68,349.95);

Insert Into ProductDeals_TRANSPART values('12489','AX12',11,21.95);
Insert Into ProductDeals_TRANSPART values('12491','BT04',1,149.99);
Insert Into ProductDeals_TRANSPART values('12491','BZ66',1,399.99);
Insert Into ProductDeals_TRANSPART values('12494','CB03',4,279.99);
Insert Into ProductDeals_TRANSPART values('12495','CX11',2,22.95);
Insert Into ProductDeals_TRANSPART values('12498','AZ52',2,12.95);
Insert Into ProductDeals_TRANSPART values('12498','BA74',4,24.95);
Insert Into ProductDeals_TRANSPART values('12500','BT04',1,149.99);
Insert Into ProductDeals_TRANSPART values('12504','CZ81',2,325.99);

-- function returns the total dollar for a given transaction
Create Or Replace Function ProductDeals_getTransVal(transNum varchar) Return Number
  AS
    transTotal Number :=0;
    Begin
      Select  SUM(NUMBER_ORDERED*QUOTED_PRICE) into transTotal 
      From    PRODUCTDEALS_TRANSPART  
      Where   TRANS_NUMBER = transNum;
      Return  transTotal;
    End ;

