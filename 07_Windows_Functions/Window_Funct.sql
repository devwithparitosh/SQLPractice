/*SQL window functions allow performing calculations across a set of rows that are related to the current row, without collapsing the result into a single value. 
They are commonly used for tasks like aggregates, rankings and running totals. 
The OVER clause defines the “window” of rows for the calculation. 
It can:
	PARTITION BY: It divides the data into groups using PARTITION BY.
	ORDER BY: It specifies the order of rows within each group using ORDER BY.

Syntax:

SELECT column_name1, 
       window_function(column_name2) 
       OVER ([PARTITION BY column_name3] [ORDER BY column_name4]) AS new_column
FROM table_name;
*/
use SalesDB;

-- Find the total sales Across all Product
Select
	Sum(Sales) as TotalSales
From Sales.Orders;

--Find The total sales of each product.
Select 
	ProductID,
	SUM(Sales) as TotalSales
From Sales.Orders
Group By ProductID;

/* Find The total Sales for each product, 
additionally provide details such orderid and order date. */
Select 
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) OVER(PARTITION BY ProductID) as TiitalSalesBYPRoducts   -- window concept
From Sales.Orders;

/* Find the Total sales across all orders 
additionally provide details such orderId and order date. */
Select 
	OrderID,
	OrderDate,
	SUM(Sales) OVER() as TotalSales
From Sales.Orders;

/* Find the total sales for each Combination of product and order status.*/
Select
	OrderID,
	OrderStatus,
	ProductID,
	SUM(Sales) OVER( Partition by ProductID, OrderStatus) as CombitionOFSatus
From Sales.Orders;


-- Frame -----------------------------------------

Select
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
			ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING ) as TotalSales,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
			ROWS 2 PRECEDING ) as TotalSales_2							-- SHORT FORM ONLY WORKS WITH PRECEDING
from Sales.Orders;                                           

/* Rank():- to assign a rank or position to each row within a result set based on a specified order. 
Rows with the same values receive the same rank, and the next rank is skipped for ties.*/

/*Q:- Rank Each Order Based on their Sales from highest to lowest
additionally provide details such orderID and OrderDate */

Select
	OrderID,
	OrderDate,
	Sales,
	RANK() Over(order by Sales desc) as RankSales
From Sales.Orders;

-- Rank Customers Based on their total Sales.
Select
	CustomerID,
	SUM(Sales) TotalSales,
	RANK() Over(order by sum(Sales) desc) as RankCustomers              -- Sum(Sales) is a Part of group by thats why we can used it 
From Sales.Orders
Group by CustomerID;


-- -------Aggregate Function-------------
-- Count()------
-- Q:- Find The total number of orders for each product.
Select
	o.Sales,
	p.Product,
	COUNT(*) Over( PARTITION BY Product) as productbysales
From Sales.Orders as o
left join Sales.Products as p
on o.ProductID=p.ProductID;

-- Q:- Find The total number of orders for each Customers.
Select
	OrderID,
	OrderDate,
	CustomerID,
	COUNT(*) OVER(PARTITION BY CustomerID) as CustomerPerOrder
From Sales.Orders;

/*Find The total Number of customers,
additionally provide all customer's details. */
Select
	*,
	Count(*) OVER() as Total_Customer,
	COUNT(Score) Over() as total_Customer_by_score           -- Because it doesn't count null values as a real value.
From Sales.Customers;

/* Check whether the table 'orders' contains any duplicates rows .*/
Select
OrderID,
	COUNT(*) OVER(PARTITION BY OrderID) as CheckPK
From Sales.Orders;

Select
OrderID,
	COUNT(*) OVER(PARTITION BY OrderID) as CheckPK
From Sales.OrdersArchive;


-- SUM()---------------
-- Q:- Find The total number of Sales for each product.
Select
	O.Sales,
	O.OrderID,
	P.Product,
	COUNT(*) OVER(PARTITION BY Product) as SalesByProduct,
	SUM(COALESCE(Sales,0)) OVER(PARTITION BY Product) as SUMSalesByProduct
From Sales.Orders as O
left join Sales.Products as P
ON O.ProductID=P.ProductID;

/* find The Total Sales across all orders 
And the total sales for each product
additionally provide deatils such order_id, orderdate. */

Select
	O.OrderID,
	O.OrderDate,
	P.Product,
	SUM(COALESCE(Sales,0)) OVER()  AS TOTAL_SALES,
	SUM(COALESCE(Sales,0)) OVER(PARTITION BY Product) as TOTALSALES_BY_PRODUCT
From Sales.Orders AS O
LEFT JOIN Sales.Products AS P
ON O.ProductID=P.ProductID;

/*Find the percentages contribution of 
each product's Sales to the total Sales */
SELECT 
	OrderID,
	ProductID,
	Sales,
	SUM(Sales) OVER() AS TotalSales,
	ROUND(CAST(Sales as float) /SUM(Sales) Over() * 100 ,2) AS PERCENTAGE_BY_TOTAL
FROM Sales.Orders;


-- AVG()----------------------

/*fIND THE aVERAGE sALES FOR EACH PRODUCT.*/
Select
	O.OrderID,
	P.Product,
	AVG(COALESCE(Sales,0)) OVER(PARTITION BY Product) AS AVERAG_SALES_OF_PRODUCT
from Sales.Orders as O
LEFT JOIN Sales.Products AS P
ON O.ProductID=P.ProductID;

/*Find the average Sales across all orders and 
additionaly , provide deatils such as ORder ID and orderdate */
Select
	OrderID,
	OrderDate,
	AVG(COALESCE(Sales,0)) over() as AVGsales 
fROM Sales.Orders;

/*Find the Average score of the customers
Additionally provide deatils such CustomerId and LastName */
Select
	CustomerID,
	LastName,
	AVG(coalesce(score,0)) over() as avg_score
From Sales.Customers;

/*Find all orders where Sales are higher than 
the average sales across all orders*/
Select
	*
From(
	Select
		OrderID,
		ProductID,
		Sales,
		AVG(COALESCE(Sales,0)) Over() as AVG_SALES
	From Sales.Orders
)t WHERE Sales>AVG_SALES;         -- Because of the window fuction rule we can't use window fuction Directly with the WHERE Clause

-- MIN()------------------
-- Find the highest Sales for each product
Select
	ProductID,
	Sales,
	MIN(Coalesce(Sales,0)) OVER(PARTITION BY ProductID) as MINValue_by_product
From Sales.Orders;

-- MAX()--------------------
Select 
	ProductID,
	Sales,
	MAX(COALESCE(Sales,0)) OVER(PARTITION BY ProductID) as MAXValue_by_product
From Sales.Orders;

-- Find the Employee who have the higest salary

SELECT
* 
FROM (
	Select
		*,
		MAX(Salary) OVER() AS MAX_salary
	From Sales.Employees
)t WHERE Salary=MAX_salary;