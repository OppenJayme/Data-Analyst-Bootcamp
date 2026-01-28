-- Where clause helps us filter data

# Selects all columns in the employee_salary but specific to the first_name of Leslie
SELECT * 
FROM parks_and_recreation.employee_salary
Where first_name = "Leslie"; 

# THe equal is called a comparison operator

SELECT * 
FROM parks_and_recreation.employee_salary
Where salary > 50000;
# selects people who has the salary over 50,000 and not equal or lower to 50,000
# we can also do this with <
# we can also do >= or <= which can select equal and over than the valueu to compare to

SELECT * 
FROM parks_and_recreation.employee_demographics
Where birth_date > '1985-01-01';

-- We can also do AND, OR, and NOT -- logical operators 
# AND = both conditions have to be true 
# OR = either conditions have to be true
SELECT * 
FROM parks_and_recreation.employee_demographics
Where birth_date > '1985-01-01' 
	  OR NOT gender = 'MALE';
      
# We can also perform PEMDAS  like this
SELECT * 
FROM parks_and_recreation.employee_demographics
Where birth_date > '1985-01-01' OR (gender = 'MALE'AND age >= 36);
# returns an output of people who has birthdate over that OR people who are MALE AND age >= 36 (greater or equal than 36)

-- LIKE STATEMENT
-- % and _w
SELECT * 
FROM parks_and_recreation.employee_demographics
Where first_name LIKE 'a__' # this prints people with first_name that starts with a with 2 characters after it NO MORE NO LESS!
;
#LIKE 'Jer%';
# Prints people with first_name that starts with Jer AND ANYTHING AFTER IT"
# 