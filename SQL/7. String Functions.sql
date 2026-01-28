-- String Functions

-- LENGTH
SELECT LENGTH('SKYFALL');

SELECT first_name, LENGTH(first_name)
FROM employee_demographics
ORDER BY 2; -- Orders the 2nd column in the SELECT statement in descending

-- UPPER AND LOWER
SELECT UPPER('Ivana');
SELECT LOWER('JOHN');

-- TRIM
-- take a whitespace and get rid of it (front or end)
SELECT TRIM('      Ivan Jayme  2');

-- SubString
SELECT first_name, 
LEFT(first_name, 4), -- What this does is it reads from LEFT and 4 CHARACTERS after it; 
RIGHT(first_name, 4), -- reads from RIght AND 4 characters after it.
SUBSTRING(first_name, 3, 2), -- reads from the 3rd letter and reads 2 characters inlcuding the 3rd letter
birth_date,
SUBSTRING(birth_date,6, 2) AS birth_month -- at position 6 and read 2 characters including position 6
FROM employee_demographics;	

-- Replace and Locate
SELECT first_name, REPLACE(first_name, 'a', '@') -- reads the first_name column and replaces letters with 'a' to '@'
FROM employee_demographics;

SELECT first_name, LOCATE('A', first_name) -- finds the position of 'A' in the first_name column for each person / row
FROM employee_demographics;

-- Concatenate
SELECT first_name, last_name, 
CONCAT(first_name, ' ', last_name) -- here we combine two columns and we add a small ' ' (space) in between them.
FROM employee_demographics;