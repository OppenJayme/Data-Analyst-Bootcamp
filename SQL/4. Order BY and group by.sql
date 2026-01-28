-- can use group by roll up and group similar values in a column and perform aggregate functions
SELECT * 
FROM parks_and_recreation.employee_demographics;

-- selecting a non aggrate column then it must match the group by EX.
SELECT first_name
FROM employee_demographics
GROUP BY gender;


-- SELECT the avg ages of gender, and biggest and smallest age;
# Count here counts how many values is in that row, 4 Females, 7 males
SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender;

-- ORDER BY
-- order of selected columns for the order by matter. Meaning any order by column that comes first will be ordered,
SELECT * 
FROM employee_demographics
ORDER BY gender, age;

# You can also, instead of writing the column name, you can write the number of where that column is. ex. if age is in third column then you can do 3 in the ORder by and not age but this is not recommended.