/*Subqueries :- A subquery in SQL is a query nested inside another SQL query. 
It allows complex filtering, aggregation and data manipulation by using the result of one query inside another.
They are an essential tool when we need to perform operations like:

Apply aggregate functions like SUM, COUNT or AVG dynamically.
Update data using values from other tables.
Delete rows based on conditions returned by another query.*/
Select
	*
From INFORMATION_SCHEMA.COLUMNS;

-- Scalar SubQuery
Select
	*
From Sales.Employees
Where Salary=(Select MAX(Salary) from Sales.Employees);

-- Multiple Rows + Single Column
Select 
	*
from Sales.Customers
Where Country in (Select Country from Sales.Customers where Score>500);

Select 
	*
from Sales.Customers
Where Score>500;

-- Clause/location ------------------------------
-- 1) From
-- Q:- Find The products that have a price higher than the average price of all products.
Select
	*
from (
		--Subquery
		Select
			Product,
			Price,
			AVG(Price) Over() as AvgPrice
		From Sales.Products
)t where Price > AvgPrice

-- Q:- Rank Customers based on their total amount of Sales
Select
	*,
	RANK() Over(order by CustomerPerSales DESC) as RankofCustomer
From(
	Select 
		CustomerID,
		SUM(Sales) as CustomerPerSales
	From Sales.Orders
	group by CustomerID
)t 

-- 2) Select ----------- 
Select 
	ProductID,
	Product,
	Price,
	--SubQuery
	(Select COUNT(*) FROM Sales.Orders) as TotalOrders
from Sales.Products;

-- 3) JOIN Clause-------------------
-- Q:- Show all Customer details and find the total orders for each customer.
