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

SELECT emp_no
FROM salaries
WHERE to_date >= CURDATE()
GROUP BY emp_no
HAVING STD(salary) > 1
;

-- 

SELECT COUNT(*)
FROM
	(
	SELECT emp_no
	FROM salaries
	WHERE to_date >= CURDATE()
	GROUP BY emp_no
    HAVING STD(salary) > 1
	) AS Deviation
;

-- Percentage
-- Doesn't work yet. Need ot add a subquery in teh selct and another later in the where column.
/*
SELECT percent
From salaries
WHERE perecent = (Base / COUNT(*)) * 100
AND
	(
	SELECT COUNT(*)
	FROM
		(
		SELECT emp_no
		FROM salaries
		WHERE to_date >= CURDATE()
		GROUP BY emp_no
		HAVING STD(salary) > 1
		) AS Deviation
	) AS Base
;
*/

-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries.
-- BONUS

-- 1. Find all the department names that currently have female managers.

SELECT dept_name
FROM departments
WHERE dept_no IN
	(
	SELECT dept_no
	FROM dept_emp
	WHERE to_date >= CURDATE()
    AND emp_no IN
			(
		SELECT emp_no
		FROM employees
		WHERE gender = 'F'
		AND emp_no IN
				(
				SELECT emp_no
				FROM dept_manager
				WHERE to_date >= CURDATE()
				)
			)
	)
;

-- 2. Find the first and last name of the employee with the highest salary.


SELECT first_name , last_name
FROM employees
WHERE emp_no =
	(
    SELECT emp_no
	FROM salaries
    ORDER BY salary DESC
    LIMIT 1
    )
;

-- 3. Find the department name that the employee with the highest salary works in.

-- extra sub query just for style points

SELECT dept_name
FROM departments
WHERE dept_no =
	(
    SELECT dept_no
    FROM dept_emp
    WHERE emp_no =
		(
		SELECT emp_no
		FROM employees
		WHERE emp_no =
			(
			SELECT emp_no
			FROM salaries
			ORDER BY salary DESC
			LIMIT 1
			)
		)
	)
;

-- 4. Who is the highest paid employee within each department.

-- skeleton #3
-- I can just do 9 differst sub queries inside of first to bring out a list of the employees, without using an advanced feature like a union
/*
SELECT first_name , last_name 
FROM employees
WHERE emp_no IN
	(
    SELECT emp_no
    FROM dept_emp
    WHERE 
    AND emp_no =
		(
        SELECT salary
        FROM salaries
        WHERE dept_no
        )
	OR
    OR
    OR
    OR
    OR
    OR
    OR
    OR
    )
;

SELECT dept_name
FROM departments
WHERE dept_no =
	(
    SELECT dept_no
    FROM dept_emp
    WHERE emp_no =
		(
		SELECT emp_no
		FROM employees
		WHERE emp_no =
			(
			SELECT emp_no
			FROM salaries
			ORDER BY salary DESC
			LIMIT 1
			)
		)
	)
;
*/

/*
-- can't get the distinct departmesnt.dept_name and there is no aggregate function to group by

SELECT  employees.first_name , employees.last_name , departments.dept_name
FROM employees
JOIN salaries ON employees.emp_no = salaries.emp_no
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
JOIN departments on departments.dept_no = dept_emp.dept_no 
# GROUP BY departments.dept_name
ORDER BY salary DESC
;
*/

/*
-- skeleton

SELECT first_name , last_name , dept
FROM emplo

SELECT DISTINCT dept_no

ORDER BY salary DESC
;
*/