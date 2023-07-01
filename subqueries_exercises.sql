-- Exercises
-- Exercise Goals

-- Use subqueries to find information in the employees database
-- Create a file named subqueries_exercises.sql and craft queries to return the results for the following criteria:


-- 1. Find all the current employees with the same hire date as employee 101010 using a subquery.

SELECT first_name , last_name
FROM employees
WHERE hire_date =
	(
	SELECT hire_date
    FROM employees
    WHERE emp_no = 101010
    )
AND emp_no IN
	(
    SELECT emp_no
	FROM dept_emp
	WHERE to_date <= CURDATE()
	)
;

-- 2. Find all the titles ever held by all current employees with the first name Aamod.

SELECT title FROM 
titles
WHERE emp_no IN
	(
	SELECT emp_no
	FROM employees
	WHERE first_name = 'Aamod'
    AND emp_no
    IN	
		(
        SELECT emp_no
        FROM dept_emp
        WHERE to_date >= CURDATE()
        )
    )
GROUP BY title
;

-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
-- 59,900 awnser key , employees not in
SELECT COUNT(emp_no)
FROM employees
WHERE emp_no IN
	(
    SELECT emp_no
    FROM dept_emp 
    WHERE to_date <= CURDATE()
    )
-- 85,108 past employees.
;

-- 4. Find all the current department managers that are female. List their names in a comment in your code.

SELECT CONCAT(first_name , ' ' , last_name) 
FROM employees
WHERE gender = 'F'
AND emp_no IN
	(
    SELECT emp_no
    FROM dept_manager
    WHERE emp_no 
    AND CURDATE() < to_date
	)
/*
'Isamu Legleitner'
'Karsten Sigstam'
'Leon DasSarma'
'Hilary Kambil'
*/
;


-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.

SELECT first_name , last_name
FROM employees
WHERE emp_no IN
	(
	SELECT emp_no 
	FROM salaries
	WHERE salary > 
		(
        SELECT AVG(salary)
        FROM salaries
        )
    AND emp_no IN
		(
        SELECT emp_no
        FROM dept_emp
        WHERE to_date > CURDATE()
        )
	)
;



-- 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries.
-- BONUS

-- 1. Find all the department names that currently have female managers.
-- 2. Find the first and last name of the employee with the highest salary.
-- 3. Find the department name that the employee with the highest salary works in.

-- 4. Who is the highest paid employee within each department.