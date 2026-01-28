-- Triggers and Events in MYSQL

SELECT * 
FROM employee_demographics;

SELECT * 
FROM employee_salary;

-- Trigger gets automatically things done and can save alot of time.

DELIMITER $$
CREATE TRIGGER employee_insert -- create a trigger called employee_insert
	AFTER INSERT ON employee_salary -- After insert we perform below, when new info is inserted in the salary table, its automatically updated in the emographics table
    FOR EACH ROW -- trigger gets activated for each ROW that gets inserted 
BEGIN
	INSERT INTO employee_demographics (employee_id, first_name, last_name)
    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name); -- only take new ROWS that are inserted, OLD takes rows deleted or updated
END $$
DELIMITER ; 

-- can read it as, create a trigger that after a row is inserted into the salary table for each row, heres whats gonna happen, insert into demographics table, the employee_id, first_name, and last_name
-- the values New.employee_id etc. WHEN NEW it talks about the event that takes place, the new data being inserted

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES (13, 'Ivan', 'Jaymer', 'Data Analytics', 52000, NULL);

-- Events
-- Scheduled automator rather than trigger when an event takes place
-- like import data pull data from a specific file path on schedule, daily monthly etc.

SELECT * 
FROM employee_demographics;

DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO 
BEGIN
	DELETE
	FROM employee_demographics
    WHERE age >= 60;
END $$
DELIMITER ;

-- some times it wont work, small troubleshoot
SHOW VARIABLES LIKE 'event%'; -- if OFF turn on

-- mybe no permission to delete
-- edit -> preference -> sql editor (very button), uncheck safe updates
