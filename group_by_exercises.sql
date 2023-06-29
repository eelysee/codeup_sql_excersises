-- 1. Create a new file named group_by_exercises.sql

-- 2. In your script, use DISTINCT to find the unique titles in the titles table. 
-- How many unique titles have there ever been? Answer that in a comment in your SQL file.

SELECT DISTINCT title FROM titles;

-- 7

-- 3. Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.


SELECT last_name FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY(last_name);

-- 4. Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.

SELECT first_name , last_name FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY(first_name , last_name);

-- 5. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.

SELECT last_name FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY(last_name);

-- 'Chleq'
-- 'Lindqvist'
-- 'Qiwen'

-- 6. Add a COUNT() to your results (the query above) to find the number of employees with the same last name.

SELECT last_name , COUNT(last_name) FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY(last_name);


-- 7. Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. 
-- Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.


SELECT COUNT(*) , first_name , gender FROM employees
WHERE first_name IN ('Irena' , 'Vidya', 'Maya')
GROUP BY gender, first_name
Order by first_name, gender ASC;

-- 8. Using your query that generates a username for all of the employees, generate a count employees for each unique username.

SELECT COUNT(*) AS Dupes,
CONCAT(
	LOWER(SUBSTR(first_name , 1 , 1)) , 
    LOWER(SUBSTR(last_name , 1 , 4)) , '_' , 
    SUBSTR(birth_date , 6 , 2) ,
    SUBSTR(birth_date , 2 , 2)) 
 AS username
 FROM employees
GROUP BY username
ORDER BY Dupes DESC;

-- 9. From your previous query, are there any duplicate usernames? 
-- What is the higest number of times a username shows up? Bonus: How many duplicate usernames are there from your previous query?

/*
Not done with exercise
*/
--17

-- Bonus: More practice with aggregate functions:

-- Determine the historic average salary for each employee. 
-- When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.

-- Using the dept_emp table, count how many current employees work in each department. 
-- The query result should show 9 rows, one for each department and the employee count.

-- Determine how many different salaries each employee has had. This includes both historic and current.

-- Find the maximum salary for each employee.

-- Find the minimum salary for each employee.

-- Find the standard deviation of salaries for each employee.

-- Now find the max salary for each employee where that max salary is greater than $150,000.

-- Find the average salary for each employee where that average salary is between $80k and $90k.