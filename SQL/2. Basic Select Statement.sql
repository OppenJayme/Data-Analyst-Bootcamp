SELECT *
FROM parks_and_recreation.employee_demographics;	

SELECT first_name, 
	   last_name,
	   birth_date,
       age,
       # You can Actually do mathematical expressions like this 
       (age + 30) AS 30Age
FROM parks_and_recreation.employee_demographics;

# Selecting DISTINCT VALUE!
SELECT DISTINCT first_name, gender # But here we select the DISTINCT FOR first_name and gender 
FROM parks_and_recreation.employee_demographics;