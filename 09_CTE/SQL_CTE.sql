/*A Common Table Expression (CTE) is a temporary result set in SQL that you can reference within a single query. 
CTEs simplify complex queries, make them easier to read and can be reused multiple times within the same query. 
It is used for:

Performing recursive operations, such as traversing hierarchical data.
Breaking down multi-step calculations into manageable parts.
Replacing nested subqueries in complex data retrieval tasks.*/

-- Standalone CTE ---------------------------
-- To transform raw sales data into meaningful business insights and understand customer value through sales analysis.

-- Step 1:- Find the Total Sales Per Customer
With cte_TotalSales as (
	Select
		CustomerID,
		SUM(Coalesce(Sales,0)) as SalesPerCustomer
	From Sales.Orders
	Group BY CustomerID)

-- Step 2:- Find The last OrderDate For Each Customer
, cte_OrderDate as( 
	Select
		CustomerID,
		MAX(OrderDate) as LastOrderDate
	From Sales.Orders
	Group BY CustomerID)

-- Step 3:- Rank Customers based on total sales per customer
, cte_RankBasedOnTotalSales as (
	SELECT
		CustomerID,
		RANK() OVER(Order BY SalesPerCustomer DESC) AS Rank_Customer
	From cte_TotalSales)

-- Step 4:- Segment Customers based On their total Sales.
, cte_CustomerSegment as (
	Select 
		CustomerID,
		CASE
			WHEN SalesPerCustomer > 100 THEN 'HIGH'
			WHEN SalesPerCustomer >80 THEN 'MEDIUM'
			ELSE 'LOW'
		END AS Sales_Segment
	FROM cte_TotalSales)

-- Main Query
Select 
	c.CustomerID,
	c.FirstName,
	c.LastName,
	ctc.SalesPerCustomer,
	cto.LastOrderDate,
	ctr.Rank_Customer,
	cts.Sales_Segment
From Sales.Customers as c
LEFT JOIN cte_TotalSales as ctc
on c.CustomerID=ctc.CustomerID
LEFT JOIN cte_OrderDate as cto
ON c.CustomerID=cto.CustomerID
LEFT JOIN cte_RankBasedOnTotalSales AS ctr
on c.CustomerID = ctr.CustomerID
LEFT JOIN cte_CustomerSegment as cts
ON c.CustomerID=cts.CustomerID;