
-- Exercises
-- Exercise Goals

-- Use CASE statements or IF() function to explore information in the employees database
-- Create a file named case_exercises.sql and craft queries to return the results for the following criteria:

-- 1. Write a query that returns all employees, their department number, their start date, their end date, 
-- and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not. DO NOT WORRY ABOUT DUPLICATE EMPLOYEES.

SELECT * , IF(to_date < CURDATE() , 1 , 0) AS is_current_employee
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
;

-- 2. Write a query that returns all employee names (previous and current), 
-- and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT  last_name ,
    CASE 
        WHEN LEFT(last_name, 1) <= 'H' THEN 'A-H'
        WHEN LEFT(last_name, 1) <= 'Q' THEN 'I-Q'
        ELSE 'R-Z'
    END AS alpha_group
FROM employees
;

-- 3. How many employees (current or previous) were born in each decade?

SELECT COUNT(emp_no) ,
	CASE
		WHEN SUBSTR(birth_date ,1 , 3) = '196' THEN "60's"
        ELSE "50's"
	END AS ERA
FROM employees
GROUP BY ERA
;
     
-- 4. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

SELECT AVG(salary) ,
   CASE
		WHEN dept_name IN ('research', 'development') THEN 'R&D'
		WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
		WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
		WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
		ELSE 'Customer Service'
   END AS dept_group
FROM dept_emp
LEFT JOIN salaries on dept_emp.emp_no = salaries.emp_no AND salaries.to_date > CURDATE()
LEFT JOIN departments on dept_emp.dept_no = departments.dept_no
GROUP BY dept_group
;


-- BONUS

-- Remove duplicate employees from exercise 1.

/*

- attempt 1
-doesn't work

SELECT * , IF(to_date < CURDATE() , 1 , 0) AS is_current_employee
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
WHERE emp_no IN 
	(
    SELECT DISTINCT emp_no
    FROM employees
    )
AND  emp_no IN 
	(
    SELECT DISTINCT emp_no
    FROM dept_emp
    )	
;
*/