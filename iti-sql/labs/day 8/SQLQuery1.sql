USE ITI


--1.	 Create a view that displays student full name, course name if the student has a grade more than 50. 

CREATE VIEW 
	stgrade
AS
	SELECT 
		CONCAT(St_Fname, '', St_Lname) AS 'FULL NAME',
		c.Crs_Name,
		g.Grade
	FROM
		Student s, Stud_Course g, Course c
	WHERE
		s.St_Id = g.St_Id AND g.Crs_Id = C.Crs_Id

SElECT * FROM stgrade



--2.	 Create an Encrypted view that displays manager names and the topics they teach. 

CREATE VIEW
	mangertopics
WITH ENCRYPTION
AS
	SELECT 
		Ins_Name AS 'Manger Name',
		Crs_Name
	FROM 
		Instructor i,Department d, Ins_Course ic,Course c
	WHERE
		i.Ins_Id=d.Dept_Manager and i.Ins_Id=ic.Ins_Id and c.Crs_Id=ic.Crs_Id
		

SELECT * FROM mangertopics



--3.	Create a view that will display Instructor Name,
--Department Name for the ‘SD’ or ‘Java’ Department “use Schema binding” and describe what is the meaning of Schema Binding


CREATE VIEW
	dbo.INSTINFO
WITH SCHEMABINDING
AS
	SELECT
		Ins_Name,
		Dept_Name
	FROM 
		dbo.Instructor i INNER JOIN dbo.Department d
	ON 
		d.Dept_Id = i.Dept_Id AND d.Dept_Name IN ('sd','java')



--Create a view “V1” that displays student data for student who lives in Alex or Cairo. 
--Note: Prevent the users to run the following query 
--Update V1 set st_address=’tanta’
--Where st_address=’alex’;




CREATE VIEW
	V1
AS
	SELECT
		*
	FROM 
		Student
	WHERE
		St_Address in ('Alex', 'Cario')
	WITH CHECK OPTION



--5.	Create index on column (Hiredate) that allow u to cluster the data in table Department. 
--What will happen?

CREATE CLUSTERED INDEX hire
ON 
	Department (Manager_hiredate)

--6.	Create index that allow u to enter unique ages in student table. What will happen?

CREATE UNIQUE INDEX Age
on student(St_age)



--7.	Create temporary table [Session based] on Company DB to save employee name and his today task.

CREATE  TABLE
	#employee
	(
		E_Name		 VARCHAR(20),
		Task		 VARCHAR(20)
	)




--8.	Using Merge statement between the following two tables [User ID, Transaction Amount]

CREATE TABLE tlast
(
	  userid int primary key,
		  tamount int
)
 insert into tlast values(1,4000),(4,2000),(2,10000)
		  create table tdaliy
		  (
		  userid int primary key,
		  tamount int
		  )
		  insert into tdaliy values(1,1000),(2,2000),(3,1000)

		  merge into tlast as l
		  using tdaliy as d

		  on l.userid=d.userid
		  when matched then
		  update set l.tamount=d.tamount
		  when not matched by source then delete;

		  select*from tlast


/*
Part 2: use CompanyDB
1)	Create view named   “v_clerk” that will display employee#,project#, 
the date of hiring of all the jobs of the type 'Clerk'.
*/

USE Company_SD


CREATE VIEW 
	V_clarck
AS
	SELECT 
		e.SSN
		CONCAT(Fname,'',Lname) AS 'Full Name',
		d.DNAME,
		p.Pname,
		d.[MGRStart Date]

	FROM
		Employee e, Departments d, Project p
	WHERE
		d.Dnum = e.DNO AND d.Dnum = p.Dnum 


select *from v_clerk


--Create view named  “v_without_budget” that will display all the projects data 
--without budget

CREATE VIEW C_WITHOUT_BUDGET
AS
	SELECT *
	FROM
	project



--3)	Create view named  “v_count “ that will display the project name and the # of jobs in it
create view v_count 
as
select pname,count(job) as numofjobs
from Project p,Departments d
where d.Dnum=p.Dnum
group by Pname

select *from v_count

--4)	 Create view named ” v_project_p2” that will display the emp# s for the project# ‘p2’
---------use the previously created view  “v_clerk”
create view v_project_p2
as
select count(SSN)
from v_clerk where Pname='p2'

select*from v_project_p2

--5)	modifey the view named  “v_without_budget”  to display all DATA in project p1 and p2 
alter view v_without_budget
as
select p.City,p.Dnum,p.Plocation,p.Pname,p.Pnumber from Project p
where Pname in ('p1','p2')

select * from v_without_budget	

--6)	Delete the views  “v_ clerk” and “v_count”
drop view v_count
drop view v_clerk

--7)	Create view that will display the emp# and emp lastname who works on dept# is ‘d2’
alter view dep2
as
select Lname, count(ssn) as numbers from
Employee e,Departments d
where d.Dnum=e.Dno and d.Dname='dp2'
group by Lname

select lname from dep2

--8)	Display the employee  lastname that contains letter “J”
--------Use the previous view created in Q#7
select lname from dep2 where lname like '%j%'

--9)	Create view named “v_dept” that will display the department# and department name
alter view v_dept(dname,dnum)
as
select dname,dnum
from Departments

select * from v_dept

--10)	using the previous view try enter new department data where dept# is ’d4’ and dept name is ‘Development’

insert into v_dept(dname,dnum)
values('development','p4')

--11)	Create view name “v_2006_check” that will display employee#, 
--the project #where he works and the date of joining the project which must be from
-- the first of January and the last of December 2006.this view will be used to insert data so
-- make sure that the coming
-- new data must match the condition
alter view v_2006_check(empno,projectn,edate)
as
select empno,projectno,enter_date
from works_on where enter_date between '1-1-2006'and'12-31-2006'
with check option


select * from v_2006_check