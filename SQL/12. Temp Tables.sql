-- Temp Tables

CREATE TEMPORARY TABLE temp_table
(
first_name varchar(24),
last_name varchar(16),
dsa_grade float(5)
);

SELECT *
FROM temp_table;

INSERT INTO temp_table
VALUES ('Ivan', 'Jayme', 2.6);

SELECT *
FROM temp_table;

-- But we can also populate a temp table by doing...

CREATE TEMPORARY TABLE age_over_25_and_salary_over_35k AS
SELECT
    es.employee_id,
    es.salary,
    ed.age,
    ed.gender
FROM employee_salary es
JOIN employee_demographics ed
    ON ed.employee_id = es.employee_id
WHERE ed.age > 25
  AND es.salary > 35000;

SELECT *
FROM age_over_25_and_salary_over_35k;