
-- Join Example Database
-- Use the join_example_db. Select all the records from both the users and roles tables.

-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. 
-- Before you run each query, guess the expected number of results.

-- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. 
-- Use count and the appropriate join type to get a list of roles along with the number of users that has the role. 
-- Hint: You will also need to use group by in the query.

-- 1. Use the employees database.

USE employees;

-- 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department 
-- along with the name of the current manager for that department.


SELECT departments.dept_name AS 'Department Name' , CONCAT(employees.first_name, ' ', employees.last_name) AS 'Department Manager'
FROM dept_manager
JOIN employees ON employees.emp_no = dept_manager.emp_no 
JOIN departments ON departments.dept_no = dept_manager.dept_no
WHERE dept_manager.to_date >= NOW()
ORDER BY departments.dept_name ASC;

/*




  Department Name    | Department Manager
 --------------------+--------------------
  Customer Service   | Yuchang Weedman
  Development        | Leon DasSarma
  Finance            | Isamu Legleitner
  Human Resources    | Karsten Sigstam
  Marketing          | Vishwani Minakawa
  Production         | Oscar Ghazalie
  Quality Management | Dung Pesch
  Research           | Hilary Kambil
  Sales              | Hauke Zhang

*/
-- 3. Find the name of all departments currently managed by women.

SELECT departments.dept_name AS 'Department Name' , CONCAT(employees.first_name, ' ', employees.last_name) AS 'Department Manager'
FROM dept_manager
JOIN employees ON employees.emp_no = dept_manager.emp_no 
JOIN departments ON departments.dept_no = dept_manager.dept_no
WHERE employees.gender = 'F'
AND dept_manager.to_date >= NOW()
ORDER BY  departments.dept_name ASC
;



/*
Department Name | Manager Name
----------------+-----------------
Development     | Leon DasSarma
Finance         | Isamu Legleitner
Human Resources | Karsetn Sigstam
Research        | Hilary Kambil
*/

-- 4. Find the current titles of employees currently working in the Customer Service department.

SELECT titles.title AS 'Title' , COUNT(*) AS 'Count'
FROM employees
LEFT JOIN dept_emp ON employees.emp_no = dept_emp.emp_no 
LEFT JOIN departments ON departments.dept_no = dept_emp.dept_no
LEFT JOIN titles ON titles.emp_no = employees.emp_no
WHERE departments.dept_name = 'Customer Service'
AND dept_emp.to_date >= NOW()
AND titles.to_date >= NOW()
GROUP BY titles.title
ORDER BY titles.title ASC;

/*
Title              | Count
-------------------+------
Assistant Engineer |    68
Engineer           |   627
Manager            |     1
Senior Engineer    |  1790
Senior Staff       | 11268
Staff              |  3574
Technique Leader   |   241
*/

-- 5. Find the current salary of all current managers.

SELECT departments.dept_name AS 'Department Name' , CONCAT(employees.first_name, ' ', employees.last_name) AS 'NAME',
Salary
FROM dept_manager
JOIN employees ON employees.emp_no = dept_manager.emp_no 
JOIN departments ON departments.dept_no = dept_manager.dept_no
JOIN salaries on salaries.emp_no = employees.emp_no
WHERE dept_manager.to_date >= NOW()
AND salaries.to_date >= NOW()
ORDER BY  departments.dept_name ASC
;

/*
Department Name    | Name              | Salary
-------------------+-------------------+-------
Customer Service   | Yuchang Weedman   |  58745
Development        | Leon DasSarma     |  74510
Finance            | Isamu Legleitner  |  83457
Human Resources    | Karsten Sigstam   |  65400
Marketing          | Vishwani Minakawa | 106491
Production         | Oscar Ghazalie    |  56654
Quality Management | Dung Pesch        |  72876
Research           | Hilary Kambil     |  79393
Sales              | Hauke Zhang       | 101987
*/


-- 6. Find the number of current employees in each department.

SELECT departments.dept_no, dept_name , COUNT(departments.dept_no) AS 'num_employees' -- '' arnt necesary when there is no space
FROM departments
JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
WHERE dept_emp.to_date >= NOW()
GROUP BY departments.dept_no
;

/*
+---------+--------------------+---------------+
| dept_no | dept_name          | num_employees |
+---------+--------------------+---------------+
| d001    | Marketing          | 14842         |
| d002    | Finance            | 12437         |
| d003    | Human Resources    | 12898         |
| d004    | Production         | 53304         |
| d005    | Development        | 61386         |
| d006    | Quality Management | 14546         |
| d007    | Sales              | 37701         |
| d008    | Research           | 15441         |
| d009    | Customer Service   | 17569         |
+---------+--------------------+---------------+
*/

-- 7. Which department has the highest average salary? Hint: Use current not historic information.

SELECT departments.dept_name AS dept_name , AVG(salaries.salary) AS average_salary
FROM salaries
JOIN dept_emp ON dept_emp.emp_no = salaries.emp_no 
JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE dept_emp.to_date >= NOW()
AND salaries.to_date >= NOW()
GROUP BY departments.dept_name
ORDER BY  average_salary DESC
LIMIT 1
;

/*
+-----------+----------------+
| dept_name | average_salary |
+-----------+----------------+
| Sales     | 88852.9695     |
+-----------+----------------+
*/

8. Who is the highest paid employee in the Marketing department?

SELECT first_name , last_name
FROM employees
JOIN salaries ON employees.emp_no = salaries.emp_no
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
JOIN departments on departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name = 'Marketing'
# AND dept_emp.to_date <= CURDATE()
ORDER BY salaries.salary DESC
LIMIT 1
;

/*
+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Akemi      | Warwick   |
+------------+-----------+
*/


9. Which current department manager has the highest salary?

SELECT employees.first_name , employees.last_name, salary, departments.dept_name AS dept_name
FROM dept_manager
JOIN employees ON employees.emp_no = dept_manager.emp_no 
JOIN departments ON departments.dept_no = dept_manager.dept_no
JOIN salaries on salaries.emp_no = employees.emp_no
WHERE dept_manager.to_date >= NOW()
AND salaries.to_date >= NOW()
ORDER BY Salary DESC
LIMIT 1
;

/*
# Partial code awnsering wrong question
SELECT employees.first_name , employees.last_name , salary , departments.dept_name AS dept_name
FROM salaries
JOIN dept_emp ON dept_emp.emp_no = salaries.emp_no 
JOIN departments ON departments.dept_no = dept_emp.dept_no
JOIN employees ON dept_emp.emp_no = employees.emp_no 
WHERE dept_emp.to_date >= NOW()
AND salaries.to_date >= NOW()
AND dept_manager.to_date >= NOW()
# Do I need to make sure it is a current manager as there will always be current employee
# Yes because they could have been demoted
ORDER BY salary DESC
LIMIT 1
;

+------------+-----------+--------+-----------+
| first_name | last_name | salary | dept_name |
+------------+-----------+--------+-----------+
| Vishwani   | Minakawa  | 106491 | Marketing |
+------------+-----------+--------+-----------+
*/

10. Determine the average salary for each department. Use all salary information and round your results.

SELECT departments.dept_name , ROUND(AVG(salary)) AS average_salary
FROM salaries
JOIN dept_emp ON dept_emp.emp_no = salaries.emp_no
JOIN departments on departments.dept_no = dept_emp.dept_no
GROUP BY dept_name
ORDER BY average_salary DESC
;

+--------------------+----------------+
| dept_name          | average_salary | 
+--------------------+----------------+
| Sales              | 80668          | 
+--------------------+----------------+
| Marketing          | 71913          |
+--------------------+----------------+
| Finance            | 70489          |
+--------------------+----------------+
| Research           | 59665          |
+--------------------+----------------+
| Production         | 59605          |
+--------------------+----------------+
| Development        | 59479          |
+--------------------+----------------+
| Customer Service   | 58770          |
+--------------------+----------------+
| Quality Management | 57251          |
+--------------------+----------------+
| Human Resources    | 55575          |
+--------------------+----------------+

11. Bonus Find the names of all current employees, their department name, and their current manager's name.

-- could not figure it out with only Joins. Could not get the FULL JOINS to work.
-- the sub queries work though

/*
SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS 'Employee Name' , 
departments.dept_name AS 'Department Name' , 
CONCAT(employees.first_name, ' ', employees.last_name) AS 'Manager Name'
FROM employees
JOIN dept_manager ON employees.emp_no = dept_manager.emp_no 
JOIN departments ON departments.dept_no = dept_manager.dept_no
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
WHERE dept_emp.to_date >= CURDATE()
AND dept_manager.to_date >= CURDATE()
;

*/

240,124 Rows

Employee Name | Department Name  |  Manager Name
--------------|------------------|-----------------
 Huan Lortz   | Customer Service | Yuchang Weedman

 .....