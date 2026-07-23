/*CREATE DATABASE practDB;
-- create a databases

use practDB;
-- use the database to perform query
 
-- create a table 
CREATE TABLE employees(
emp_id INT(50) PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
hourly_pay DECIMAL(5,2),
hire_date date;


-- add another column 
Alter TABLE employees ADD age int(10);
Alter TABLE employees ADD joining_date date;

-- insert the records(rows) and fields(column) into the table
Insert into employees(emp_id,first_name,last_name,hourly_pay,hire_date,age,joining_date) 
values(1,'Diablo','D dante',100,NULL,10000,'2002-08-20') -- date format 'YYYY-MM-DD' , 
(2,'Shion','tempest',120,NULL,2000,'2000-08-07'),
(3,'Gabta','Goblin',80,NULL,45,'1998-08-17'),
(4,'Bhenimaru','High Ogar',80,NULL,150,'2000-08-07'),
(5,'Valdora','tempest',120,NULL,100000,'1769-09-27'),
(6,'Rimaru','tempest',500,NULL,60,'1997-07-12'),
(7,'Shunna','Oger Priest',120,NULL,34,'2000-09-10');
*/
SELECT * FROM employees;

/*Which SQL query retrieves all records of employees who have an age greater than 2000 years?*/
select * from employees where age >2000;

/*How would you find all employees whose last_name starts with the letter 'T'?*/
SELECT * FROM employees WHERE last_name LIKE 'T%';

/*WRITE A query correctly identifies employees who joined the company exactly in the year 2000?*/
SELECT * FROM employees WHERE joining_date BETWEEN '2000-01-01' AND '2000-12-31';

ALTER TABLE employees DROP COLUMN hire_date;

/*What is the correct syntax to retrieve the first and last names of employees who earn more than $110 per hour AND are older than 1000?*/
SELECT first_name, last_name FROM employees WHERE hourly_pay>110 AND AGE>1000;

-- If you wanted to see the potential annual salary for each employee (assuming a 40-hour work week for 52 weeks), which expression would you use in the SELECT clause?
SELECT first_name,hourly_pay*40*52 FROM employees;

RENAME TABLE employees TO temp_workers;

SELECT * FROM temp_workers;

-- structure of the table

DESCRIBE temp_workers;
