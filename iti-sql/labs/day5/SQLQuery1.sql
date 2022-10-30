USE ITI

/*Adv SQLServer Lab
Notes:
•	Restore ITI and adventureworks2012 DBs to Server
*/
/*Part-1: Use ITI DB
1.	Retrieve number of students who have a value in their age. 
*/


SELECT COUNT(St_Id) AS "Student Number With Age NOT Null"
FROM Student 
WHERE St_Age IS NOT NULL

--2.	Get all instructors Names without repetition

SELECT DISTINCT Ins_Name
FROM Instructor

--3.	Display student with the following Format (use isNull function)

SELECT St_Id AS 'ID'
, ISNULL(CONCAT(St_Fname,  ' ', St_Lname), ' ') as "Full Name"
,ISNULL(St_Address, ' ' ) AS	'Address'
,ISNULL(Dept_Id, ' ') AS	'Department ID'
,ISNULL(St_super, ' ') AS 'Supervisor'
FROM Student

--4.	Display instructor Name and Department Name 

SELECT Ins_Name AS Name
, Dept_Name AS 'Department Name'
FROM Instructor i, Department d
WHERE D.Dept_Id = i.Dept_Id

--Note: display all the instructors if they are attached to a department or not

SELECT Ins_Name AS Name
, Dept_Name AS 'Department Name'
FROM Instructor i LEFT JOIN Department d
ON D.Dept_Id = i.Dept_Id

/*5.	Display student full name and the name of the course he is taking
For only courses which have a grade  
*/
SELECT CONCAT(St_Fname, ' ', St_Lname) AS 'Full Name'
, Crs_Name AS 'Course Name'
FROM Course c INNER JOIN Stud_Course s
on c.Crs_Id = s.Crs_Id AND s.Grade IS NOT NULL
INNER JOIN Student t
ON t.St_Id = s.St_Id

---------------------------------------------------------------

SELECT CONCAT(St_Fname, ' ', St_Lname) AS 'Full Name'
, Crs_Name AS 'Course Name'
FROM Course c, Student s, Stud_Course sc
WHERE s.St_Id = sc.St_Id and c.Crs_Id = sc.Crs_Id

--6.	Display number of courses for each topic name


SELECT Top_Name
, COUNT(Crs_Name) AS 'Courses Count'
FROM Course c, Topic t
WHERE t.Top_Id = c.Top_Id
GROUP BY Top_Name


--7.	Display max and min salary for instructors


SELECT MAX(Salary) AS 'Max Salary'
, MIN(Salary) AS 'Min Salary'
FROM Instructor


--8.	Display instructors who have salaries less than the average salary of all instructors.

-- ALL SALARIES ARE NUll BUT QUERY WILL BE LIKE THAT

SELECT i.*
FROM Instructor i
WHERE i.Salary < (SELECT AVG(Salary)
					FROM Instructor)

--9.	Display the Department name that contains the instructor who receives the minimum salary.

SELECT Ins_Name
FROM Department d, Instructor i
WHERE d.Dept_Id = i.Dept_Id AND i.Salary = (SELECT MIN(Salary) 
												FROM Instructor)

--10.	 Select max two salaries in instructor table. 


SELECT MAX(Salary)
FROM Instructor
UNION
SELECT MAX(Salary)
FROM Instructor 
HAVING Salary < (SELECT MAX(Salary)
						FROM Instructor)
						
--------------------------------------------------

SELECT TOP(2) MAX(Salary)
FROM Instructor


--11.	 Select instructor name and his salary but if there is no salary display instructor bonus. “use one of coalesce Function”

SELECT Ins_Name
,COALESCE(CONVERT(VARCHAR(20), Salary), 'bounus')
FROM Instructor


--12.	Select Average Salary for instructors 


SELECT AVG(Salary) AS 'Avg Salary'
FROM Instructor

--13.	Select Student first name and the data of his supervisor 

SELECT x.St_Fname 
,y.*
FROM Student x, Student y
WHERE y.St_ID = x.St_super


--14.	Write a query to select the highest two salaries in Each Department for instructors who have salaries. “using one of Ranking Functions”


SELECT *
FROM (
		SELECT *, ROW_NUMBER() OVER(PARTITION BY Dept_Id order by Salary DESC) AS MAX_Salary
		FROM Instructor) AS new
WHERE MAX_Salary <= 2


--15.	 Write a query to select a random  student from each department.  “using one of Ranking Functions”

SELECT *
FROM (
		SELECT *,  ROW_NUMBER() OVER(PARTITION BY dept_Id ORDER BY NEWID()) AS  Random
		FROM Student) AS NEW
WHERE Random = 1
-------------------------------------------------------------------------------------------------------------------------------------------------


/*Part-2: Use AdventureWorks DB
1.	Display the SalesOrderID, ShipDate of the SalesOrderHearder table (Sales schema) 
to designate SalesOrders that occurred within the period ‘7/28/2002’ and ‘7/29/2014’
*/

USE AdventureWorks2012

SELECT SalesOrderID
, ShipDate
FROM Sales.SAlesOrderHeader
WHERE OrderDate BETWEEN '7/28/2002' AND '7/29/2014'


--2.	Display only Products(Production schema) with a StandardCost below $110.00 (show ProductID, Name only)
SELECT ProductID
, Name
FROM Production.product
WHERE StandardCost < 110

--3.	Display ProductID, Name if its weight is unknown

SELECT ProductID
, Name
FROM Production.Product
WHERE Weight IS NULL

--4.	 Display all Products with a Silver, Black, or Red Color

SELECT * 
FROM Production.Product
WHERE Color IN ('Silver', 'Black', 'Red')

--5.	 Display any Product with a Name starting with the letter B

SELECT *
FROM Production.Product
WHERE Name LIKE 'b%'

/*6.	Run the following Query
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3
Then write a query that displays any Product description with underscore value in its description.
*/

UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3

SELECT *
FROM Production.ProductDescription
WHERE Description LIKE '%[_]%'

--7.	Calculate sum of TotalDue for each OrderDate in Sales.SalesOrderHeader table for the period between  '7/1/2001' and '7/31/2014'

SELECT SUM(TotalDue) AS Total
, OrderDate
FROM Sales.SalesOrderHeader
WHERE DueDate BETWEEN '7/1/2001' AND '7/31/2014'
GROUP BY OrderDate

--8.	 Display the Employees HireDate (note no repeated values are allowed)


SELECT HireDate
FROM HumanResources.Employee


--9.	 Calculate the average of the unique ListPrices in the Product table


SELECT AVG(DISTINCT ListPrice) AS UNiQ_AVG
FROM Production.Product

--10.	Display the Product Name and its ListPrice within the values of 100 and 120 the list should has the following format "The [product name] is only! [List price]" (the list will be sorted according to its ListPrice value)


SELECT CONCAT('The [', Name, '] is only!','[ ',ListPrice, ']') AS product_name_price
FROM Production.Product
WHERE ListPrice BETWEEN 100 AND 120
ORDER BY ListPrice
/*11.	

a)	 Transfer the rowguid ,Name, SalesPersonID, Demographics from Sales.Store table  in a newly created table named [store_Archive]
Note: Check your database to see the new table and how many rows in it?
b)	Try the previous query but without transferring the data? 
*/
--a
SELECT * INTO Store_Archive
FROM Sales.Store

--b
SELECT p.BusinessEntityID
, p.rowguid
, t.Name
, s.Demographics
FROM Sales.SalesPerson p, Sales.Store s, Sales.SalesTerritory t
WHERE 
p.BusinessEntityID = s.BusinessEntityID AND t.TerritoryID = p.TerritoryID


SELECT * INTO store_archieve2
FROM Sales.Store
WHERE 1 = 2

/*12.	Using union statement, retrieve the today’s date in different styles
Part-3: Bouns
Display results of the following two statements and explain what is the meaning of @@AnyExpression
select @@VERSION
select @@SERVERNAME
*/
SELECT CONVERT(VARCHAR(20), GETDATE()) AS TODAY_DATE
UNION
SELECT CAST(GETDATE() AS VARCHAR(20))
UNION
SELECT convert(varchar(20),getdate(),102)
union
select convert(varchar(20),getdate(),103)
union
select convert(varchar(20),getdate(),104)
union
select convert(varchar(20),getdate(),105)

select format(getdate(),'dd-MM-yyyy') 
union
select format(getdate(),'dddd MMMM yyyy')
union
select format(getdate(),'ddd MMM yy')
union
select format(getdate(),'dddd')
union
select format(getdate(),'MMMM')
union
select format(getdate(),'hh:mm:ss')
union
select format(getdate(),'HH')
union
select format(getdate(),'hh tt')
union
select format(getdate(),'dd-MM-yyyy hh:mm:ss tt')
union
select format(getdate(),'dd')

select day(getdate())

select eomonth(getdate())

select format(eomonth(getdate()),'dddd')
union
select format(eomonth(getdate()),'dd')
------------------------------------------------------------------------------

