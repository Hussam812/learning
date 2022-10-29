USE Company_SD
/*DQL

1.	Display (Using Union Function)
a.	 The name and the gender of the dependence that's gender is Female and depending on Female Employee.
b.	 And the male dependence that depends on Male Employee.
*/

SELECT Fname + ' ' + Lname AS Employee
, d.Dependent_name AS Dependent
FROM Employee e,  Dependent d
WHERE e.Sex = 'f' AND  d.Sex = 'f'	
UNION 

SELECT Fname + ' ' + Lname AS Employee
, d.Dependent_name AS Dependent
FROM Employee e,  Dependent d
WHERE e.Sex = 'm' AND  d.Sex = 'm'	


--2.	For each project, list the project name and the total hours per week (for all employees) spent on that project.

SELECT Pname AS 'Project Name'
,SUM(Hours) AS 'Total Hours Per Week'
FROM  Works_for  INNER JOIN project 
ON  Pnumber = Pno
GROUP BY Pname


--3.	Display the data of the department which has the smallest employee ID over all employees' ID.


SELECT top(1) d.*
FROM Departments d INNER JOIN Employee e
ON d.Dnum = e.Dno
ORDER BY SSN DESC
-------------------------------------------------------------------
SELECT *
FROM Departments 
WHERE Dnum = (SELECT Dno
				FROM Employee
				WHERE SSN = (SELECT MIN(SSN)
				FROM Employee))

--4.	For each department, retrieve the department name and the maximum, minimum and average salary of its employees.

SELECT Dname
, MAX(Salary) as 'Max Salary'
, MIN(Salary) as 'Min Salary'
, AVG(Salary) as 'Avg Salary'
FROM Departments INNER JOIN Employee
ON Dnum = Dno
GROUP BY Dname


--5.	List the last name of all managers who have no dependents.


SELECT Lname 
FROM Employee INNER JOIN Departments
ON SSN = MGRSSN 
LEFT JOIN Dependent
ON SSN = ESSN 
WHERE ESSN IS NULL

--6.	For each department-- if its average salary is less than the average salary of all employees-- display its number, name and number of its employees.
SELECT  Dname AS 'Nanme'
,AVG(ISNULL(Salary, 0)) AS ' AVG Salary'
,COUNT(SSN) AS 'Count'
FROM Employee, Departments
WHERE Dnum = Dno
GROUP BY Dname
HAVING AVG(Salary) < (SELECT AVG(ISNULL(salary,0)) FROM Employee)

--7.	Retrieve a list of employees and the projects they are working on ordered by department and within each department, ordered alphabetically by last name, first name.

SELECT e.*
, p.Pname
, d.Dname
FROM Project p INNER JOIN Departments d
on d.Dnum = p.Dnum
INNER JOIN Employee e
ON D.Dnum = e.Dno 
ORDER BY Dno, Lname, Fname
--8.	Try to get the max 2 salaries using subquery

SELECT ToP(2)Salary
FROM Employee
ORDER BY 1 desc 

--9.	Get the full name of employees that is similar to any dependent name


SELECT CONCAT(Fname, '', Lname) AS 'Full Name'
FROM Employee , Dependent
WHERE SSN = ESSN AND CONCAT(Fname, ' ', Lname) like Dependent_name 



--10.	Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30% 

UPDATE Employee
SET Salary =  Salary * 1.3
WHERE 
--11.	Display the employee number and name if at least one of them have dependents (use exists keyword) self-study.

--DML

--1.	In the department table insert new department called "DEPT IT" , with id 100, employee with SSN = 112233 as a manager for this department. The start date for this manager is '1-11-2006'

/*2.	Do what is required if you know that : Mrs.Noha Mohamed(SSN=968574)  moved to be the manager of the new department (id = 100), and they give you(your SSN =102672) her position (Dept. 20 manager) 

a.	First try to update her record in the department table
b.	Update your record to be department 20 manager.
c.	Update the data of employee number=102660 to be in your teamwork (he will be supervised by you) (your SSN =102672)
*/

--3.	Unfortunately the company ended the contract with Mr. Kamel Mohamed (SSN=223344) so try to delete his data from your database in case you know that you will be temporarily in his position.
--Hint: (Check if Mr. Kamel has dependents, works as a department manager, supervises any employees or works in any projects and handle these cases).

