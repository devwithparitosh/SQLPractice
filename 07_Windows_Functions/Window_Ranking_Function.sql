/* --ROW_NUMBER() is a window function that assigns a sequential number to rows within each partition,
in the order defined by the ORDER BY inside the OVER(...) clause. 
The PARTITION BY is optional—if you omit it, the entire result set is treated as a single partition.

The ORDER BY clause is mandatory for ROW_NUMBER() because it defines the logical order used to number rows. 
In each partition, numbering starts at 1.*/

-- Rank The oRders based on their Sales from Higest to lowest.
Select 
	OrderID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales Desc) as SalesRank_ROW
From Sales.Orders;


/*SQL RANK() is used to assign a rank or position to each row within a result set based on a specified order. 
Rows with the same values receive the same rank, and the next rank is skipped for ties.

PARTITION BY: Ranks are assigned independently within each group defined by PARTITION BY.
ORDER BY: Determines the order of ranking within the result set or within each partition.*/

-- Q:- Rank The ORders based on their Sales from Higest to lowest.
Select 
	OrderID,
	ProductID,
	Sales,
	RANK() OVER(ORDER BY Sales DESC) AS SalesRANK
From Sales.Orders;


/*DENSE_RANK() :- gives the same rank to rows with equal values. 
It then continues with the next number without skipping, 
keeping the ranking sequence continuous. */

-- Q:- Rank The ORders based on their Sales from Higest to lowest.
Select
	OrderID,
	ProductID,
	Sales,
	DENSE_RANK() OVER(ORDER BY Sales DESC) AS Dense_RankValue
From Sales.Orders;


-- Use Cases of Row_Number() Function

-- top-n analysis------------------
--Q:- Find the top highest Sales for each product.
Select
	*
From(
	Select
		OrderID,
		ProductID,
		Sales,
		ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) AS Sales_Rank
	From Sales.Orders
)t Where Sales_Rank=1;

--Q:- Find the top lowest Sales for each product.
Select
	*
From(
	Select
		OrderId,
		ProductID,
		Sales,
		ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales asc) as Sales_Rank_lowest
	from Sales.Orders
)t WHERE Sales_Rank_lowest=1;

--BOttom-n analysis-------------------
-- Q:- Find the lowest 2 customers based on the their total sales.
Select
	*
From(
	Select 
		CustomerID,
		SUM(Sales) as Total_Sales,
		ROW_NUMBER() OVER(ORDER BY SUM(Sales) asc) as Lowest_Sales_by_customer
	From Sales.Orders
	GROUP BY CustomerID
)t Where Lowest_Sales_by_customer <=2;

--Assign's Unique value-------------
-- Q:- Assign unique IDs the the rows of the 'OrderArchive' table.

Select 
	ROW_NUMBER() OVER(ORDER BY OrderId, OrderDate) as UniqueID,
	*
From Sales.OrdersArchive;

/*-------Identify Duplicates --------------------
Identify and remove duplicate rows to improve data quality.*/
