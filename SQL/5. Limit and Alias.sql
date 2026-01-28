-- Limit & Aliasing

SELECT * 
FROM employee_demographics
ORDER BY age DESC
LIMIT 2, 1; -- selects ONLY the row 2, and the next row of it, meaning if row 2 then row 3 will be displayed	

-- Aliasing
SELECT gender, AVG(age) AS avg_age -- can put AS or no AS works either way
FROM employee_demographics
GROUP BY gender
HAVING avg_age > 40;
