-- Subqueries

SELECT *
FROM employee_demographics
WHERE employee_id IN 
					(SELECT employee_id
                     FROM employee_salary
                     WHERE dept_id = 1) 
;

-- the use case ehre is we want to comapre the person's salary to the AVG salary of everybody
SELECT first_name, salary,
	(SELECT AVG(salary)
	FROM employee_salary)
FROM employee_salary;


-- here we findout each gender's avg age, max ages, min ages and how many ages. 
-- However, it cannot calculate the average of the maximum ages and minimum ages
-- across genders because aggregate functions cannot be nested
-- at the same query level.
SELECT gender, AVG(age) AS avg_age, MAX(age) AS max_age, MIN(age) AS min_age, COUNT(age) AS count_age
FROM employee_demographics
GROUP BY gender;


-- so we solve it here by making a subqueury in the FROM statement almost like a temp table where we read from the results and columns of the FROM statement instead of an actual table.
SELECT AVG(max_age) 
FROM 
(SELECT gender, 
		AVG(age) AS avg_age, 
        MAX(age) AS max_age, 
        MIN(age) AS min_age, 
        COUNT(age) AS count_age
FROM employee_demographics
GROUP BY gender) AS Agg_Table	
; 