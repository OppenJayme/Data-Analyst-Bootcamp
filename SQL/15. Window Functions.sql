-- Window function

-- like a group by but does not group how a group by does it
-- allow us to look at a partition or group where they each keep their own rows in the output.
 
Select dem.first_name, dem.last_name, gender, AVG(sal.salary)
FROM employee_demographics dem
JOIN employee_salary sal
	ON sal.employee_id = dem.employee_id
GROUP BY dem.first_name, dem.last_name, gender;

-- Over (everthing) shows everybody and the avg salary of everybody in their own row.
-- Partition by Gender shows that values change based on gender, which means males and females can now have their own total AVG salary for their gender and not for ALL
-- this allows us to individually gain more info for each row rather than using group by which groups the whole.
Select dem.first_name, dem.last_name, gender, AVG(salary) OVER(PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON sal.employee_id = dem.employee_id;
    
-- heres another which shows the total SUM for males and females in each person's row based on their gender
Select dem.first_name, dem.last_name, gender, SUM(salary) OVER(PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON sal.employee_id = dem.employee_id;
    
-- Rolling total
-- start a specific value and add on vlaues from subsequent rows based on the partition
-- basically orders the first employee computing their salaries and adding them sequentially until the end of that gender.
Select dem.employee_id, dem.first_name, dem.last_name, gender, salary, SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS rolling_total
FROM employee_demographics dem
JOIN employee_salary sal
	ON sal.employee_id = dem.employee_id;

-- here we can understand that PARTITION BY makes values based on gender so instead of ROW_NUMBER putting numbers for all rows, this time it starts with 1 in females until last, and goes back to one if males.
-- ADDING RANK()
-- RANK() adds duplicates so if there are two people with the same salary instead of going to the next number (5-6), RANK() makes it 5-5
-- DENSE_RANK() instead of the row being numbered to what row it is, if there is a duplicate for exmaple, its gonna give the next number numerically not positionally.
Select dem.employee_id, dem.first_name, dem.last_name, gender, salary, 
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_rank_num
FROM employee_demographics dem
JOIN employee_salary sal
	ON sal.employee_id = dem.employee_id
    
-- row_number = sequentiall no condition
-- rank() = sequentiall but can have duplicate if same value
-- dense_rank() = sequentiall, can have duplicates but next number is numerically not positionally.