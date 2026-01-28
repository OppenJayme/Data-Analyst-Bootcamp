-- Joins

SELECT * 
FROM employee_demographics;

SELECT * 
FROM employee_salary;

SELECT dem.first_name, sal.salary -- must correspond to their table
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal -- alias for easier readability
	ON dem.employee_id = sal.employee_id;


-- Outer Joins
-- Left Join and Right join
SELECT *
FROM employee_demographics AS dem -- this is the left table
RIGHT JOIN employee_salary AS sal -- this is the right table
	ON dem.employee_id = sal.employee_id;
    
-- Self Join
-- join that ties the table to itself

SELECT emp1.employee_id AS emp_santa,
emp1.first_name AS first_name_santa,
emp1.last_name AS last_name_santa
FROM employee_salary AS emp1
JOIN employee_salary AS emp2
	ON  emp1.employee_id + 1 = emp2.employee_id
;
