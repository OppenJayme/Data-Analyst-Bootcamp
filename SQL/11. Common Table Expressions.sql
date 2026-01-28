-- Common Table Expressions

-- almost works as a temporary table
WITH CTE_example AS 
(
	SELECT gender, AVG(salary) avg_sal, MAX(salary), MIN(salary)
    FROM employee_demographics ed
    JOIN employee_salary es
		ON ed.employee_id = es.employee_id
	GROUP by gender
)

SELECT avg_sal
FROM CTE_example;