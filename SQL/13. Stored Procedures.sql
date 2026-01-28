-- Stored Procedures
-- way to save sql code to use it over and over
-- simplyfying repetitive code
-- storing complex code

SELECT *
FROM employee_salary
WHERE salary >= 25000;

CREATE PROCEDURE mid_salary_25k()
SELECT *
FROM employee_salary
WHERE salary >= 25000;

CALL mid_salary_25k();

DELIMITER $$
CREATE PROCEDURE mid_salaries3()
BEGIN 
	SELECT * 
    FROM employee_salary 
    WHERE salary >= 25000;
    SELECT *
    FROM employee_salary
    WHERE salary >= 75000;
END $$
DELIMITER ; 

CALL mid_salaries3();


-- parameter usage
DELIMITER $$
CREATE PROCEDURE mid_salary5(test_id INT)
BEGIN
	SELECT salary
    FROM employee_salary
    WHERE employee_id = test_id;
END $$
DELIMITER ;
