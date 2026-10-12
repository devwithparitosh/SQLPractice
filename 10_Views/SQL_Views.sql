/*A SQL View is a virtual table created from the result of a SELECT query. 
It does not store data physically but displays data stored in underlying tables.
Views help simplify complex queries, enhance security and present data in a cleaner, customized format.*/

-- Q:- Find the running total of Sales for each Month.

CREATE VIEW Sales.V_SALES_MONTH AS (
	Select 
		Month(OrderDate) as MonthofSales,	
		SUM(Sales) as TotalSales 
	From Sales.Orders
	Group BY Month(OrderDate)
)

SELECT 
	MonthofSales,
	SUM(TotalSales) Over(ORDER BY MonthofSales) AS RunningTotal
FROM Sales.V_SALES_MONTH;

Drop VIEW V_SALES_MONTH  -- Drop the old view

-- Update the view (by using T-SQL)
IF OBJECT_ID('Sales.V_SALES_MONTH', 'V') IS NOT NULL
	DROP VIEW Sales.V_SALES_MONTH;
GO
CREATE VIEW Sales.V_SALES_MONTH as (
	Select 
		Month(OrderDate) as MonthofSales,	
		SUM(Sales) as TotalSales,
		COUNT(OrderID) as TotalOrder
	From Sales.Orders
	Group BY Month(OrderDate)
)