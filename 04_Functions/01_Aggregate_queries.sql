
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


-- NULL Value MANAGE for * data aggregration *

-- Find the average scorce of the customers.
Select 
    CustomerID,
    Score,
    AVG(COALESCE(Score,0)) over() as AverageScore
From Sales.Customers;

/* Diaplay the full name of the customers in a single field 
-- by merging their first and last name ,
-- and add 10 bonus points to each customer's score */

Select 
    CustomerID,
    FirstName,
    LastName,
    FirstName+' '+COALESCE(LastName,'N/A') as FullName,
    Score,
    COALESCE(Score,0)+10 as BONUSSCORE
From Sales.Customers;


--Sort the Customers from lowest ot highest scores,
-- with nulls appearing last 

Select 
    CustomerID,
    Score,
    COALESCE(Score,0) NULL_HANDLE
from Sales.Customers
order by COALESCE(Score,0) desc;


-- Find the sales price for each order by dividing sales by quantity
Select 
    OrderID,
    Sales,
    Quantity,
    Sales/NULLIF(Quantity,0) as price
From Sales.Orders;


-- Filtering data
-- Q:- Identify the customer who have no scores.

Select 
    *
From Sales.Customers
where Score is null;

Select 
    *
From Sales.Customers
where Score is not null;


-- Q:-Finding the unmatched rows between two tables.
-- Q:- List all details for customers who have not placed any orders.
Select 
    c.*,
    o.OrderID
From Sales.Customers as c
left join Sales.Orders as o
on c.CustomerID=o.CustomerID
where o.CustomerID is null;

-- NULL vs Empty String vs BlankSpace
with Orders as (
select 1 Id, 'a' Category UNION
select 2, NULL UNION 
select 3, '' UNION
select 4, '  ' )

Select *,
    DATALENGTH(Category) as LegthofChar
from Orders;