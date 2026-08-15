
-- Practice Questions 
-- Count all employees.
-- Find the highest salary.
-- Find the lowest salary.
-- Calculate average salary.
-- Calculate total salary.
-- Count departments.

-- Learn
-- COUNT(DISTINCT column)
-- GROUP_CONCAT

USE practDB;
SELECT * FROM emp;

/*
-- MIN() Function
-- MIN() function returns the smallest value from a numeric or date column.
Syntax:
    SELECT MIN(column_name) FROM table_name;
*/

SELECT MIN(salary) FROM emp;

/*
-- Max() Function
-- MAX() function returns the largest value from a numeric or date column.

Syntax:
SELECT MAX(column_name) FROM table_name;
*/

SELECT MAX(salary) FROM emp;


/*
-- AVG() Function
-- AVG() calculates the average or arithmetic mean for a group of numbers or a numeric column.

Syntax:
SELECT AVG(column_name) FROM table_name;
*/

SELECT AVG(salary) FROM emp;

/*
-- SUM() Function
-- SUM() function returns the total of all numeric values in a column.

Syntax:
SELECT SUM(column_name) FROM table_name;   */

SELECT SUM(salary) FROM emp;

/*
-- Count() Function
-- COUNT() function counts the number of rows in a result set or the number of non-NULL numeric values in a column.

Syntax:
SELECT COUNT(*) FROM table_name;
SELECT COUNT(column_name) FROM table_name;


-- COUNT(*) counts all rows, including rows with NULL values.
-- COUNT(column_name) counts only non-NULL values in that column.   */

SELECT COUNT(*) FROM emp;

SELECT COUNT(salary) FROM emp;

