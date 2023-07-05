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

Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'AS Base' at line 15

