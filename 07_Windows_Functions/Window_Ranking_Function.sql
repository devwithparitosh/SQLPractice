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

/* Q:- Indentify duplicates rows in the table 'OrdersArchive' 
and return a clean result without any duplicates */
SELECT
	*
From(
	Select 
		ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) as Rowno,
		*
	From Sales.OrdersArchive
)t where Rowno=1;


/*Ntile():- a window function that distributes rows of an ordered partition into 
a pre-defined number of roughly equal groups.

Syntax:
		NTILE(number_expression) OVER ([PARTITION BY partition_expression]   ORDER BY sort_expression [ASC | DESC])
*/

Select
	OrderId,
	Sales,
	NTILE(1) OVER(ORDER BY Sales DESC) as BUcketOne,
	NTILE(2) OVER(ORDER BY Sales DESC ) as BucketTwo
From Sales.Orders

-- Use Case-----------
-- Data Segmentation -------
-- Q:- Segment all orders into 3 categories: high, medium and low Sales?
Select
	*,
	case
		when Bucket=1 then 'High'
		when Bucket=2 then 'Medium'
		when Bucket = 3 Then 'Low'
	End as SegmentCategories
From(
	Select
		OrderID,
		Sales,
		NTILE(3) OVER(Order by Sales desc) as Bucket 
	From Sales.Orders
)t

-- Equalizing the data 
-- Q:- In order to export the data, divide the orders into 2 groups.
Select
	NTILE(2) Over(Order By OrderID) as bucket,
	*
from Sales.Orders;
 
 /*CUME_DIST() – usually means cumulative distribution. 
 It tells you the proportion of rows that have a value less than or equal to the current row's value.

CUME_DIST() OVER (
    [PARTITION BY partition_expression, ... ]
    ORDER BY sort_expression [ASC | DESC], ...
)
*/

Select
	Sales,
	CUME_DIST() OVER(ORDER BY Sales desc) as Dist
From Sales.Orders;


/*PERCENT_RANK() is a SQL window function that tells you the relative rank of 
a row as a percentage of the way through the ordered data. 

PERCENT_RANK() = (RANK - 1)/(Total Rows in Partition - 1)        */

Select
	Sales,
	PERCENT_RANK() Over(Order BY Sales Desc) as Percentrank
From Sales.Orders

/*| Function		| Meaning |
  |---				|      ---|
| `PERCENT_RANK()` | How far this row is through the ranking |
| `CUME_DIST()` | What fraction of rows have a value ≤ this row | */

-- Q:- Find the products that fall within the highest 40% of the prices.
Select
	*,
	CONCAT(DistRank * 100 ,'%') as DistRankPerc
From(
	Select
		Product,
		Price,
		CUME_DIST() Over(Order by Price desc) as DistRank
	From Sales.Products
)t where DistRank<=0.4

-- Window Value Function --------------------------------
-- 1)LEAD :- Access a value from the next row within a window.
Select
	OrderID,
	Sales,
	LEAD(Sales) OVER(Order BY CreationTime ) as NEXTSales,
	LAG(Sales) OVER(Order by CreationTime)  as PerviousSales
From Sales.Orders;

/* Q:-Analyze the month-over-month(MoM) performance by finding 
the percentage change in Sales Between the current and Previous Month.*/
Select
	*,
	CONCAT(
		COALESCE(
			ROUND(
				CAST((CurrentMonthsales-PerviousMonthSales) as float)/ PerviousMonthSales *100,1),0),'%') as MOM_Percentage
from(
	Select 
		Month(OrderDate) as Months,
		SUM(Sales) as CurrentMonthsales,
		LAG(SUM(Sales)) OVER(ORDER BY Month(OrderDate)) as PerviousMonthSales
	From Sales.Orders
	GROUP BY Month(OrderDate)
)t 

-- Customer Retention analysis

--Q: Analysis customer Loyalty by ranking customers based on the average number of days between orders.
Select
	CustomerID,
	AVG(Coalesce(Pervious_Date_order,0)) as [AVG days between their orders],
	RANK() Over(order by AVG(Coalesce(Pervious_Date_order,0))) as RanktotheCustomers
from(
	Select
		CustomerID,
		DATEDIFF(DAY, LAG(Orderdate) Over(PARTITION BY CustomerID Order by Orderdate),OrderDate) as Pervious_Date_order
	from Sales.Orders
)t group by CustomerID

-- First_value /last_value  window function
-- Q:- Find the lowest and higest sales for each product
Select
	ProductID,
	Sales,
	FIRST_VALUE(Sales) Over(Partition By ProductID Order By Sales) as LowestSalesByProduct,
	LAST_VALUE(Sales) Over(Partition By ProductID Order by Sales
			Rows Between Current Row And Unbounded following ) as HighestSalesByProduct,
	MIN(Sales) Over(Partition By ProductID )  as LowestSalesByProductMIN,
	MAX(Sales) Over(Partition By ProductID ) as LowestSalesByProductMAX,
	FIRST_VALUE(Sales) Over(partition By ProductID Order By Sales Desc) as  HighestSalesByProductbyUsingSort
From Sales.Orders

