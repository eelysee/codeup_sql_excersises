-- Exercises
-- Create a file named temporary_tables.sql to do your work for this exercise.

-- 1. Using the example from the lesson, create a temporary table called employees_with_departments that 
-- contains first_name, last_name, and dept_name for employees currently with that department. 
-- Be absolutely sure to create this table on your own database. 
-- If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database 
-- that you can only read.

USE somerville_2274
;

CREATE TEMPORARY TABLE  somerville_2274.employees_with_departments AS
SELECT employees.first_name , employees.last_name , departments.dept_name
FROM employees.employees
LEFT JOIN employees.dept_emp on employees.emp_no = dept_emp.emp_no AND dept_emp.to_date > CURDATE()
LEFT JOIN employees.departments on dept_emp.dept_no = departments.dept_no
;

-- a. Add a column named full_name to this table. 
-- It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.

ALTER TABLE somerville_2274.employees_with_departments
ADD full_name VARCHAR(31)
;

-- b. Update the table so that the full_name column contains the correct data.

UPDATE somerville_2274.employees_with_departments
SET full_name = CONCAT(first_name , ' ' , last_name)
;

-- c. Remove the first_name and last_name columns from the table.

ALTER TABLE somerville_2274.employees_with_departments
DROP COLUMN first_name 
;

ALTER TABLE somerville_2274.employees_with_departments
DROP COLUMN last_name
;

-- d. What is another way you could have ended up with this same table?

CREATE TEMPORARY TABLE  somerville_2274.employees_with_departments AS
SELECT CONCAT(employees.first_name , ' ' , employees.last_name) AS full_name, departments.dept_name
FROM employees.employees
LEFT JOIN employees.dept_emp on employees.emp_no = dept_emp.emp_no AND dept_emp.to_date > CURDATE()
LEFT JOIN employees.departments on dept_emp.dept_no = departments.dept_no
;

-- 2.Create a temporary table based on the payment table from the sakila database.

CREATE TEMPORARY TABLE somerville_2274.payment AS
SELECT *
FROM sakila.payment
;

-- Write the SQL necessary to transform the amount column such that it is stored as an integer 
-- representing the number of cents of the payment. 
-- For example, 1.99 should become 199.

ALTER TABLE somerville_2274.payment
MODIFY amount VARCHAR(10)
;

UPDATE somerville_2274.payment
SET amount = amount * 100
;

ALTER TABLE somerville_2274.payment
MODIFY amount INT
;




-- 3. Go back to the employees database. Find out how the current average pay in each department compares to the overall 
-- current pay for everyone at the company. For this comparison, you will calculate the z-score for each salary. 
-- In terms of salary, what is the best department right now to work for? The worst?

USE employees;

CREATE TEMPORARY TABLE  somerville_2274.z_score AS
SELECT AVG(salary) AS 'Average Salary', STDDEV(salary) AS 'Standars Deviation'
FROM salaries
WHERE to_date >= CURDATE()
;

/*

-- cant' get this to work with TEMP tables

SELECT * FROM somerville_2274.temp_payments;
-- Calculated the average salary and z-score for each department
SELECT departments.dept_name, AVG(salaries.salary) AS department_average_salary, (AVG(salaries.salary) - overall_avg.avg_salary) / overall_avg.std_dev AS z_score
FROM salaries
INNER JOIN dept_emp on salaries.emp_no = dept_emp.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
INNER JOIN (
  -- Subquery to get the overall average salary and standard deviation
  SELECT AVG(salary) AS avg_salary, STDDEV(salary) AS std_dev
  FROM salaries
  WHERE to_date >= CURDATE()
) overall_avg ON 1 = 1
WHERE dept_emp.to_date >= CURDATE()
GROUP BY departments.dept_name, overall_avg.avg_salary -- included the non-aggregated column
ORDER BY z_score DESC;
SELECT * FROM somerville_2273.temp_payments;
*/

-- Finding and using the z-score
-- A z-score is a way to standardize data and compare a data point to the mean of the sample.
/*
    -- Returns the current z-scores for each salary
    -- Notice that there are 2 separate scalar subqueries involved
    SELECT salary,
        (salary - (SELECT AVG(salary) FROM salaries where to_date > now()))
        /
        (SELECT stddev(salary) FROM salaries where to_date > now()) AS zscore
    FROM salaries
    WHERE to_date > now();
*/

-- Formula for the z-score
-- z
-- =
-- x
-- −
-- μ
-- σ

-- Notation	Description
-- z
-- the z-score for a data point
-- x
-- a data point
-- μ
-- the average of the sample
-- σ
-- the standard deviation of the sample
-- Hint The following code will produce the z-score for current salaries. Compare this to the formula for z-score shown above.


--     -- Returns the current z-scores for each salary
--     -- Notice that there are 2 separate scalar subqueries involved
--     SELECT salary,
--         (salary - (SELECT AVG(salary) FROM salaries where to_date > now()))
--         /
--         (SELECT stddev(salary) FROM salaries where to_date > now()) AS zscore
--     FROM salaries
--     WHERE to_date > now();
-- BONUS Determine the overall historic average department average salary, the historic overall average, and the historic z-scores for salary. Do the z-scores for current department average salaries (from exercise 3) tell a similar or a different story than the historic department salary z-scores?

-- Hint: How should the SQL code used in exercise 3 be altered to instead use historic salary values?