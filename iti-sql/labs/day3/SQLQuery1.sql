--Try to create the following Queries:

USE Company_SD

--1.	Display the Department id, name and id and the name of its manager.

SELECT Dnum
,Dname
,Fname + ' ' + Lname as 'Manger Name'
FROM Departments , Employee 
WHERE SSN = MGRSSN

--2.	Display the name of the departments and the name of the projects under its control.
SELECT Dname
,Pname
FROM Departments d,Project p
WHERE d.Dnum = p.Dnum

--3.	Display the full data about all the dependence associated with the name of the employee they depend on him/her.

SELECT Fname + ' ' + Lname as 'employee'
, *
FROM Dependent , Employee
WHERE SSN = ESSN

--4.	Display the Id, name and location of the projects in Cairo or Alex city.

SELECT Pnumber as Id
,Pname
, Plocation
FROM project
WHERE City IN ('Cairo', 'Alex')
select * from project
--5.	Display the Projects full data of the projects with a name starts with "a" letter.

SELECT *
FROM Project
WHERE Pname LIKE 'a%'

--6.	display all the employees in department 30 whose salary from 1000 to 2000 LE monthly

SELECT * 
FROM Employee
WHERE Dno = 30 AND Salary BETWEEN 1000 AND 2000

--7.	Retrieve the names of all employees in department 10 who works more than or equal10 hours per week on "AL Rabwah" project.

SELECT e.*
FROM Employee e INNER JOIN Works_for w
ON e.SSN=w.ESSn AND e.dno=10 
INNER JOIN Project
ON  Pnumber=Pno and hours>=10 and Pname='Al Rabwah'

--8.	Find the names of the employees who directly supervised with Kamel Mohamed.

SELECT x.Fname AS Employee
,y.Fname+ ' '+ y.Lname AS Super
FROM Employee x , Employee y
WHERE y.SSN = x.Superssn AND y.Fname = 'Kamel' and y.Lname = 'Mohamed'

--9.	Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name.

SELECT Fname
,Pname
FROM Employee  INNER JOIN  Works_for 
ON SSN = ESSn
INNER JOIN Project 
ON Pnumber = Pno
ORDER BY Pname 

select fname,pname
from Employee inner join Departments d
on  Dnum=dno
inner join Project p
on d.Dnum=p.Dnum
order by Pname

--10.	For each project located in Cairo City , find the project number, the controlling department name ,the department manager last name ,address and birthdate.

SELECT Pname
,Pnumber
,Dname
,Lname as 'Manger Last Name' 
,Address
,Bdate
FROM Project p INNER JOIN  Departments d
on  d.Dnum = p.Dnum AND City = 'Cairo'
INNER JOIN Employee e
on e.SSN = d.MGRSSN 


--11.	Display All Data of the mangers

SELECT e.* 
FROM Employee e INNER JOIN Departments d
on e.SSN = d.MGRSSN

--12.	Display All Employees data and the data of their dependents even if they have no dependents

SELECT e.*
,d.*
FROM Employee e LEFT JOIN Dependent d
ON e.SSN = d.ESSn

--Data Manipulating Language:

--1.	Insert your personal data to the employee table as a new employee in department number 30, SSN = 1026720, Superssn = 112233, salary=3000.

INSERT INTO Employee 
VAlUES('Omar', 'Hosni', 1026720, 10/12/1999, '28 Lotfy street Alexandria', 'M', 3000, 112233, 30)


--2.	Insert another employee with personal data your friend as new employee in department number 30, SSN = 1026600, but don’t enter any value for salary or manager number to him.


INSERT INTO Employee 
VAlUES('Mahmoud','Elshorbagy',1026600,8/14/1995,'133-elshrouk','m',3000,112233,30)


3.	Upgrade your salary by 20 % of its last value.

UPDATE Employee
SET Salary += .2 * Salary
WHERE Fname = 'Hussam' AND Lname = 'Hosni'
