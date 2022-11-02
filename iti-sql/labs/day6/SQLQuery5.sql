--1-Create it programmatically
--2-Create a new user data type named loc with the following Criteria:
--•	nchar(2)
--•	default:NY 
--•	create a rule for this Datatype :values in (NY,DS,KW)) and associate it
CREATE RULE 
	r1 
AS 
	@x in ('NY','DS','KW')



CREATE DEFAULT
	def1
AS 
	'NY'

sp_addtype loc ,'nchar(2)'

SP_BINDRULE r1, loc

SP_BINDEFAULT def1, loc


--1.	Create the following tables with all the required information and load the required data as specified in each table 
   --using insert statements[at least two rows]
 
 CREATE TABLE 
	department
(
	deptNo		CHAR(3)		PRIMARY KEY ,
	DeptName	VARCHAR(20)				,
	Location	loc	
)

INSERT INTO
	department
VALUES
	(
		'd1',
		'Research',
		'NY'
	)

INSERT INTO
	department
VALUES
	(
		'd2',
		'Accounting',
		'DS'
	)

INSERT INTO
	department
VALUES
	(	 'd3'
		,'Markiting'
		,'KW'
	), 
	(	 'd4'
		,'SALES'
		,'NY')


SELECt * from department

CREATE TABLE 
	Employee
	(
		EmpNo		INT				PRIMARY KEY ,
		EmpFname	VARCHAR(20)		NOT NULL	,
		EmpLname	VARCHAR(20)		NOT NULL    ,
		DeptNo		CHAR(3)					    ,
		Salary		INT						    ,
		CONSTRAINT	C1 FOREIGN KEY(DeptNo)	REFERENCES department(deptNo),
		CONSTRAINT	C2 UNIQUE(Salary)			,
		CONSTRAINT	C3 CHECK(Salary < 6000)
	)



INSERT INTO
	Employee
VALUES
	(
		25348,
		'Mathew',
		'Smith', 
		'd3',
		2500),
	(	10102,
		'Ann',
		'Jones',
		'd3',  
		3000),
	(	18316,
		'John',
		'Barrimore',
		'd1',
		2400)


--1-Add  TelephoneNumber column to the employee table[programmatically]

ALTER TABLE 
	Employee 
ADD  
	Teleohine INT


--2-drop this column[programmatically]
 
 ALTER TABLE
	Employee
DROP COLUMN
	Teleohine

SELECT * FROM Employee

--3-Bulid A diagram to show Relations between tables


--2.	Create the following schema and transfer the following tables to it 
--a.	Company Schema 
--i.	Department table (Programmatically)
--ii.	Project table (visually)

CREATE SCHEMA Company
ALTER SCHEMA Company TRANSFER department


--b.	Human Resource Schema-
--i.	  Employee table (Programmatically)

CREATE SCHEMA HumanResource
ALTER SCHEMA HumanResource TRANSFER Employee



--3.	 Write query to display the constraints for the Employee table.

SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 'd1'
WHERE TABLE_NAME = 'Employee'


--4.	Create Synonym for table Employee as Emp and then run the following queries and describe the results

CREATE SYNONYM emp FOR HumanResource.employee

--a.	Select * from Employee
SELECT * FROM emp


--b.	Select * from [Human Resource].Employee

SELECT * FROM HumanResource.emp


Select * from dbo.Emp

USE ITI
--5.	Increase the budget of the project where the manager number is 10102 by 10%.

UPDATE 
	Company.Project
SET 
	budget += (.1*budget)
FROM
	Company.project p INNER JOIN Works_on w
ON
	p.projectno = w.projectno
WHERE
	empno = 10102



	
--6.	Change the name of the department for which the employee named James works.The new department name is Sales.

update company.department
set DeptName='sales'
from company.department d inner join humanresource.employee e
on d.DeptNo=e.deptno
where empfname='james'

--7.	Change the enter date for the projects for those employees
-- who work in project p1 and belong to department ‘Sales’. The new date is 12.12.2007.
update works_on
set enter_date='12/12/2007'
from company.department d,humanresource.employee e,works_on w
where d.DeptNo=e.deptno and e.empno=w.empno and d.DeptName='sales' and projectno='p1'

--8.	Delete the information in the works_on table for all employees who work for the department located in KW.

delete from works_on
where empno in (select empno from humanresource.employee e,company.department d where d.DeptNo=e.deptno and d.Location='kw') 












