CREATE DATABASE Intercollegiate_Athletic


/*1. Write a CREATE TABLE statement for the Customer table. Choose data types appropriate 
for the DBMS used in your course. All columns are required (not null). A NOT NULL
constraint is not required for the primary key column as a primary key constraint implies 
null not allowed.
*/

CREATE TABLE Customer
(
	CustNo			VARCHAR(8)		NOT NULL,
	CustName		VARCHAR(50)		NOT NULL,
	Address			VARCHAR(50)		NOT NULL,
	City			VARCHAR(30)		NOT NULL,
	State			VARCHAR(2)		NOT NULL,
	Zip				VARCHAR(10)		NOT NULL DEFAULT '8020',
	Phone			VARCHAR(11)		NOT NULL,
	Contact			VARCHAR(35)		NOT NULL,
	Internal		VARCHAR(1)		NOT NULL  DEFAULT  'Y'
	CONSTRAINT PK_CUSTOMER PRIMARY KEY  (CustNo)
)
----------------------------------------------------------------------------------------
CREATE TABLE Customer 
(CustNo VARCHAR(8), 
CustName VARCHAR(30) CONSTRAINT CustNameNotNull NOT NULL, 
Address VARCHAR(50) CONSTRAINT AddressNotNull NOT NULL, 
Internal CHAR(1) CONSTRAINT InternalNotNull NOT NULL, 
Contact VARCHAR(35) CONSTRAINT ContractNotNull NOT NULL, 
Phone VARCHAR(11) CONSTRAINT CPhoneNotNull NOT NULL, 
City VARCHAR(30) CONSTRAINT CityNotNull NOT NULL,
State VARCHAR(2) CONSTRAINT StateNotNull NOT NULL, 
Zip VARCHAR(10) CONSTRAINT zipNotNull NOT NULL,
 CONSTRAINT PK_CUSTOMER PRIMARY KEY (CustNo) ) ;

DROP TABLE Customer
-----------------------------------------------------------------------------------------------------


/*2. Write a CREATE TABLE statement for the Facility table. Choose data types appropriate for 
the DBMS used in your course. All columns are required (not null). All columns are 
required (not null). A NOT NULL constraint is not required for the primary key column as a 
primary key constraint implies null not allowed.*/CREATE TABLE Facility(	FacNo		VARCHAR(8)		PRIMARY KEY,	FacName		VARCHAR(30)		NOT NULL)CREATE TABLE Facility
(FacNo VARCHAR(8), 
FacName VARCHAR(30) CONSTRAINT FacNameNotNull NOT NULL,
 CONSTRAINT PK_FACILITY PRIMARY KEY (FacNo) ); DROP TABLE Facility/*3. Write a CREATE TABLE statement for the Location table. Choose data types appropriate 
for the DBMS used in your course. LocName column is required (not null). All columns are 
required (not null). A NOT NULL constraint is not required for the primary key column as a 
primary key constraint implies null not allowed.
*/


/*
4. Identify the foreign key(s) and 1-M relationship(s) among the Customer, Facility, and 
Location tables. For each relationship, identify the parent table and the child table.
*/


CREATE TABLE Location
(
	LocNo		VARCHAR(8)			CONSTRAINT PK_LOCATION PRIMARY KEY,
	LocName		VARCHAR(30)			CONSTRAINT LOCNAME_NOTNULL NOT NULL,
	FacNo		VARCHAR(8)			CONSTRAINT FACNOFOREIGNKEY FOREIGN KEY REFERENCES Facility(FacNo)
)




/*
5. Extend your CREATE TABLE statement from problem (3) with referential integrity 
constraints.
*/

CREATE TABLE Location
(
	LocNo		VARCHAR(8)			CONSTRAINT PK_LOCATION PRIMARY KEY,
	LocName		VARCHAR(30)			CONSTRAINT LOCNAME_NOTNULL NOT NULL,
	FacNo		VARCHAR(8)			CONSTRAINT FACNOFOREIGNKEY FOREIGN KEY REFERENCES Facility(FacNo)
)


/*
6. From examination of the sample rows and your common understanding of scheduling and 
operation of events, are null values allowed for the foreign key in the Location table? Why 
or why not? Extend the CREATE TABLE statement in problem (5) to enforce the null value 
restrictions if any.
*/
CREATE TABLE Location
(LocNo VARCHAR(8), 
FacNo VARCHAR(8) CONSTRAINT FacNoFKNotNull NOT NULL, 
LocName VARCHAR(30) CONSTRAINT LocNameNotNull NOT NULL,
 CONSTRAINT PK_LOCATION PRIMARY KEY (LocNo),
 CONSTRAINT FK_FACNO FOREIGN KEY (FacNo) 
 REFERENCES FACILITY (FacNo) );

/*
7. Extend your CREATE TABLE statement for the Facility table (problem 2) with a unique 
constraint for FacName. Use an external named constraint clause for the unique constraint
*/


CREATE TABLE Facility 
(FacNo VARCHAR(8), 
FacName VARCHAR(30) CONSTRAINT FacNameNotNull NOT NULL,
 CONSTRAINT PK_FACILITY PRIMARY KEY (FacNo),
 CONSTRAINT Unique_FacName UNIQUE(FacName) )
