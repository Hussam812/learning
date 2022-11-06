USE ITI


--1.	 Create a scalar function that takes date and returns Month name of that date.

CREATE FUNCTION	GETSMO(@date DATE)
RETURNS VARCHAR(20)
BEGIN
DECLARE @name  VARCHAR(20)
SET @name = (FORMAT( @date, 'MMMM'))
RETURN @name
END


SELECT dbo.GETSMO('12/12/1997')


--2.	 Create a multi-statements table-valued function that takes 2 integers and returns the values between them.
CREATE FUNCTION btw(@a INT, @b INT)
RETURNS @T TABLE
	(val INT)
		AS
			BEGIN
				DECLARE @midel INT  = @a + 1
				WHILE
					@midel < @b
					BEGIN
						INSERT INTO
							@T
						SELECT 
							@midel
						SET @midel += 1
					END
				RETURN
			END


SELECT * FROM  dbo.btw(10, 20)


--3.	 Create a tabled valued function that takes Student No and returns Department Name with Student full name.

CREATE FUNCTION STUDINF(@id INT)
RETURNS TABLE
	AS
	RETURN 
	(
		SELECT
			CONCAT(St_Fname, ' ', St_lname) AS 'FULl NAME',
			Dept_Name
		FROM 
			Student s, Department d
		WHERE 
			d.Dept_Id= s.Dept_Id AND s.St_Id = @id

	)


SELECT * FROM STUDINF(10)


4.	Create a scalar function that takes Student ID and returns a message to user 
a.	If first name and Last name are null then display 'First name & last name are null'
b.	If First name is null then display 'first name is null'
c.	If Last name is null then display 'last name is null'
d.	Else display 'First name & last name are not null'


CREATE FUNCTION STUDENTINFO(@id INT)
RETURNS VARCHAR(20)
		BEGIN
			DECLARE @fname VARCHAR(20), @lname VARCHAR(20), @massage VARCHAR(20)
			SELECT 
				@fname=St_Fname
			FROM 
				Student
			WHERE 
				St_Id = @id
			select
				@lname = St_Lname
			FROM
				Student
			WHERE 
				St_Id = @id
			IF @fname IS NULL AND @lname IS NULL
				SELECT @massage ='First name & last name are null'
			IF @fname IS NULL 
				SELECT @massage = 'first name is null'
			IF @lname IS NULL 
				SELECT @massage = 'last name is null'
			ELSE 
				SELECT @massage = 'First name & last name are not null'
			RETURN @massage
		END
SELECT dbo.studentinfO(2)


--5.	Create a function that takes integer which represents manager ID and displays department name,
--Manager Name and hiring date 

CREATE FUNCTION MANGErINF(@id INT)
RETURNS TABLE
	AS
	RETURN
	(
		SELECT 
			Dept_Name,
			Ins_Name,
			Manager_hiredate
		FROM Department
		WHERE
			Dept_Id = @id
	)
SELECt *FROM MANGERINF(10)



/*
6.	Create multi-statements table-valued function that takes a string
If string='first name' returns student first name
If string='last name' returns student last name 
If string='full name' returns Full Name from student table 
Note: Use “ISNULL” function
*/

CREATE FUNCTION STname(@car VARCHAR(20))
RETURNS @t TABLE
	( name VARCHAR(20))
	AS
		BEGIN
			IF @car = 'first name'
				INSERT INTO 
					@t
				SELECT 
					St_Fname 
				FROM Student
			IF @car = 'last name'
				INSERT INTO 
					@t
				SELECT 
					ISNULL(St_Lname, '') 
				FROM Student
			ELSE IF @car = 'last name'
				INSERT INTO 
					@t
				SELECT 
					ISNULL(St_Lname, '') 
				FROM Student
			ELSE IF @car = 'Full Name'
				INSERT INTO 
					@t
				SELECT 
					ISNULL(CONCAt(St_Lname, ' ', St_Lname), '') 
				FROM Student
			RETURN
		END 
SELECT * FROM STname('FULl NAME')

--7.	Write a query that returns the Student No and Student first name without the last char
select 
	st_id,
	st_fname,
	LEFT(St_Fname,len(St_Fname)-1) as newdata 
from Student