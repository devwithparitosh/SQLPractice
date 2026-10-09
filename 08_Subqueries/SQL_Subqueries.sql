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
Select 
	c.*,
	o.TotalSales
From Sales.Customers as c
LEFT JOIN (
	Select	
		CustomerID,
		COUNT(*) as TotalSales
	From Sales.Orders
	Group By CustomerID ) as o
ON c.CustomerID=o.CustomerID;

-- 4) Where Clause---------
-- Comparsion Operator----------------
-- Q:- Find The Products That Have a Price higher than the average price of all products
Select
	Product,
	Price
From Sales.Products 
Where Price > (
			Select AVG(Price)
			from Sales.Products);


-- Logical Operator of where clause----------
-- IN ---------
-- Q:- Show the details of orders made by customers in Germany.
Select
	*
From Sales.Orders
Where CustomerID IN (Select 
					CustomerID 
					from Sales.Customers 
					Where Country = 'Germany');
						
-- Q:- Show the details of orders made by customers Who are not fom Germany.			
Select 
	*
From Sales.Orders
Where CustomerID NOT IN (Select
						CustomerID
						From Sales.Customers 
						Where Country='Germany');

-- ANY -----------------------
-- Q:- Find fenmale employeea whose Salaries are greater than the Saleries of the any male employees
Select
	*
From Sales.Employees
Where Gender = 'F' AND
Salary > ANY (Select 
			  Salary 
			  from Sales.Employees 
			  where Gender='M' );

-- ALL ---------------------
-- Q:- Find Female Employees whose Salaries are greater than the Salaries of all male employees.
Select
	*
From Sales.Employees
Where Gender = 'F' AND
Salary > ALL (Select 
			  Salary
			  From Sales.Employees
			  Where Gender='M');


-- Correlated Subquery ------------------------
-- >Row-by-row Comparisons and Dynamic Filtering .
-- >Executed For each row processed by the main Query and it leads to the bad performance 
-- Q:- Show all customer details and find the total orders for each customer.
Select
	*,
	(Select COUNT(*) From Sales.Orders as O Where O.CustomerID=C.CustomerID) as TotalSalesByCustomer
From Sales.Customers as C


-- Exists (Logical Operator Subquery) ---------------
-- Q:- Show the order details for customers in germany.
Select
	o.*
From Sales.Orders as o
Where EXISTS (Select * 
			 From Sales.Customers as c
			 Where Country= 'Germany'
			 AND o.CustomerID=c.CustomerID);