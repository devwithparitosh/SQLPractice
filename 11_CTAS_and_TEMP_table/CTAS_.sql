/*The CREATE TABLE AS SELECT (CTAS) statement creates a new table using selected columns and data from an existing table.

Syntax:
>MYSQL | POSTGRES | ORACLE

CREATE TABLE new_table_name AS
SELECT 
	column1, column2, ...
FROM existing_table_name; 

-----------------or ---------------

>MYSQL SERVER

SELECT 
	column1,...
INTO TABLE_NAME
FROM existing_table_name; */

-- Q:-Create a table that shows total number of orders for each months.

SELECT 
	DATENAME(MONTH,OrderDate) AS OrderMonth,
	COUNT(OrderID) AS TotalSales
INTO Sales.MonthlyOrders
From Sales.Orders
GROUP BY DATENAME(MONTH,OrderDate);


Select * FROM Sales.MonthlyOrders;

-- HOW to Refresh CTAS?
IF OBJECT_ID('Sales.MonthlyOrders','U')IS NOT NULL      -- 'U' Stands for the user define table
	DROP TABLE Sales.MonthlyOrders;
GO
SELECT 
	DATENAME(MONTH,OrderDate) AS OrderMonth,
	COUNT(OrderID) AS TotalSales
INTO Sales.MonthlyOrders
From Sales.Orders
GROUP BY DATENAME(MONTH,OrderDate);