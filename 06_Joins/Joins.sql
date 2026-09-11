/*Get all customers along with their orders, 
but only customers who have placed an order */

use MyDatabase

SELECT * FROM customers;
select * from orders;

-- INNER JOIN--------------

SELECT *
FROM customers 
INNER JOIN orders
ON id=customer_id;
-- if a some column has a similar value with different name it fine to retirve with the name but is not he best practice.


SELECT
	customers.id,
	customers.first_name,
	orders.order_id,
	orders.sales
from customers 
INNER JOIN orders
on customers.id=orders.customer_id;

-- OR ---------------------------

SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
INNER JOIN orders AS o
ON c.id=o.customer_id;

-- LEFT JOIN ----------------

/* GET all customers along with thier orders,
includig those without orders  */

SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
LEFT JOIN orders AS o 
ON c.id = o.customer_id;


-- Right JOINS -------------

SELECT 
	c.id,
	c.country,
	o.order_id,
	o.order_date,
	o.sales
FROM customers AS c 
RIGHT JOIN orders AS o
on c.id=o.customer_id;

/* GET all customers along with thier orders,
includig orders without matching customers (USing LEFT JOIN) */

SELECT 
	t1.id,
	t1.country,
	t2.order_id,
	t2.order_date,
	t2.sales
FROM orders AS t2
LEFT JOIN customers AS t1
on t1.id=t2.customer_id;

-- FULL JOINS----------------------

SELECT 
	t1.id,
	t1.first_name,
	t2.order_id,
	t2.sales
FROM customers AS t1
FULL JOIN orders AS t2
ON t1.id=t2.customer_id;

-- LEFT ANTI JOIN------------------
-- Get all customer who haven't place any order

SELECT *
FROM customers AS t1
LEFT JOIN orders AS t2
ON t1.id =t2.customer_id
WHERE t2.customer_id IS NULL;


-- Right Anti join------------------
-- Get all orders without matching customers

SELECT *
FROM customers AS t1
RIGHT JOIN orders AS t2
ON t1.id=t2.customer_id
WHERE t1.id IS NULL;


-- FULL ANTI JOIN--------------

-- FIND the customers without orders and orders without customers

SELECT *
FROM customers AS t1
FULL JOIN orders AS t2
ON t1.id=t2.customer_id
WHERE t1.id IS NULL OR t2.customer_id IS NULL;

/*
Get all the customers along with their orders, 
but only for the customers who have placed an order 
Without using INNER JOIN */

SELECT *
FROM customers AS t1 
LEFT JOIN orders AS t2
ON t1.id=t2.customer_id
WHERE t2.customer_id IS NOT NULL;


-- PRACTICE QUE

-- List the firstname of each customer and their orderid.
SELECT 
	c.first_name,
	o.order_id
FROM customers AS c
INNER JOIN orders AS o
on c.id=o.customer_id;

/*Q2. Customer + Country

List each customer's:
customerid
firstname
country

Only include customers who have placed an order.*/

SELECT 
	o.customer_id,
	c.first_name,
	c.country
FROM customers AS c 
inner join orders AS o
on c.id=o.customer_id;

/*
Q3. Orders + Products

List:
orderid
product name
quantity 

Tables: orders, products */
USE SalesDB;

SELECT 
	O.OrderID,
	P.Product,
	O.Quantity
FROM Sales.Orders AS O
INNER JOIN Sales.Products AS P
ON O.ProductID=P.ProductID;

/*
Q4. Orders + Customers

List:
orderid
customer first name
sales

Sort by sales from highest to lowest.*/

SELECT 
	O.OrderID,
	C.FirstName,
	O.Sales
FROM Sales.Customers AS C
INNER JOIN Sales.Orders AS O
ON C.CustomerID=O.CustomerID
ORDER BY O.Sales DESC;


/*
Q5. Orders + Employees

List:
orderid
employee first name
orderstatus

Here the employee is the salesperson.*/


SELECT 
	O.OrderID,
	E.FirstName,
	O.OrderStatus
FROM Sales.Employees AS E
INNER JOIN Sales.Orders AS O
ON E.EmployeeID=O.SalesPersonID;

/*Q6. Customer + Product + Order

For every order, display:
customer name
product name
quantity
sales

You'll need 3 tables.*/

SELECT 
	c.FirstName,
	p.Product,
	o.Quantity,
	o.sales
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
ON c.CustomerID=o.CustomerID
INNER JOIN Sales.Products AS p
ON o.ProductID=p.ProductID;


/*Q7. Full Order Information

Display:

orderid
customer name
product name
salesperson name
quantity
sales
*/

SELECT 
	o.OrderID,
	c.FirstName AS CutomerName,
	p.Product,
	e.FirstName AS SalesPersonName,
	o.Quantity,
	o.Sales
FROM Sales.Orders AS o
INNER JOIN Sales.Customers AS c
ON o.CustomerID=c.CustomerID
INNER JOIN Sales.Products AS p
ON o.ProductID=P.ProductID
INNER JOIN Sales.Employees AS e
ON o.SalesPersonID=e.EmployeeID;


/*Q8. Customer Orders

Find all orders made by customers from the USA.

Display:
customer name
orderid
sales

Concept: JOIN + filtering from another table.*/

SELECT 
	c.FirstName,
	o.OrderID,
	o.Sales
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
ON c.CustomerID=o.CustomerID
WHERE c.Country = 'USA';

/*Q9. German Customers

Find orders made by customers from Germany.

Display:

customer name
orderid
product
sales
*/

SELECT 
	c.FirstName,
	o.OrderID,
	p.Product,
	o.Sales
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
ON c.CustomerID=o.CustomerID
INNER JOIN Sales.Products AS p
ON o.ProductID=p.ProductID
WHERE C.Country='Germany';


/*Q10. Salesperson Orders

Find all orders handled by Mary.

Display:
orderid
product
customer name
sales

Concept: Joining the same orders table to different entities.*/

SELECT 
	o.OrderID,
	p.Product,
	c.FirstName AS CustomerName,
	o.Sales,
	e.FirstName AS SalesPersonWHOHandle
FROM Sales.Orders AS o
INNER JOIN Sales.Customers AS c 
ON o.CustomerID=C.CustomerID
INNER JOIN Sales.Products AS p
ON o.ProductID=P.ProductID
inner join Sales.Employees AS e
ON o.SalesPersonID=e.EmployeeID
WHERE e.FirstName = 'Mary';

/*Q11. All Customers
List all customers, including customers who have never placed an order.

Display:
customer name
orderid

Concept: LEFT JOIN*/
Use MyDatabase;

SELECT 
	C.first_name AS CustomerName,
	O.order_id
From dbo.customers as C
left join dbo.orders as O
on C.id=O.customer_id;


/*Q12. Customers Without Orders

Find customers who have never placed an order.

Display:

customerid
firstname

Concept: LEFT JOIN + IS NULL*/

select 
	c.id AS customerID,
	c.first_name
from dbo.customers as c
left join dbo.orders as o 
on c.id=o.customer_id
where o.customer_id is null;


/*Q13. All Products

List all products, including products that have never been ordered.

Display:

product name
orderid

Concept: LEFT JOIN*/

use SalesDB;

select 
	p.Product AS ProductName,
	o.OrderId
from Sales.Products as p
left join Sales.Orders as o
on p.ProductID=o.ProductID;

/*Q14. Products Never Ordered
Find products that have never appeared in orders.*/

select 
	p.Product
from Sales.Products as p
left join Sales.Orders as o
on p.ProductID=o.ProductID
where o.ProductID is null;

/*
Q15. All Employees

List every employee and the orders they handled.

Employees without orders must also appear.

Display:

employee name
orderid*/

select 
	e.FirstName AS EmployeeName,
	o.OrderID
from Sales.Employees as e
left join Sales.Orders as o
on e.EmployeeID=o.SalesPersonID;

/*practice---JOIN + Aggregation

Q16. Number of Orders per Customer

Display:
customer name
number of orders

Include customers with zero orders.

Concept: LEFT JOIN + COUNT + GROUP BY
*/

select 
	c.FirstName as CustomerName,
	COUNT(o.OrderId) as NumberofOrders
from Sales.Customers as c
left join Sales.Orders as o
on c.CustomerID=o.CustomerID
group by c.CustomerID,c.FirstName;
	

/*Q17. Total Sales per Customer

Display:

customer name
total sales

Include customers with no orders.*/

select 
	c.FirstName as CustomerName,
	Sum(o.Sales) as TotalSales
from Sales.Customers as c 
left join Sales.Orders as o
on c.CustomerID=o.CustomerID
group by c.CustomerID,c.FirstName;


/*Q18. Total Sales per Product

Display:
product
total sales

Sort from highest to lowest.*/

select 
	p.Product,
	sum(o.sales) as TotalSales 
from Sales.Products as p
left join Sales.Orders as o
on p.ProductID=o.ProductID
group by p.ProductID,p.Product   -- p.Product alone can cause problems if two products have the same name that why we need to used a unique value.
order by Sum(o.Sales) desc;


/*Q19. Orders Handled by Each Employee

Display:
employee name
number of orders

Include employees with no orders.*/

select 
	e.FirstName as EmployeeName,
	Count(o.OrderID) as NumberofOrders
from Sales.Employees as e
left join Sales.Orders as o
on e.EmployeeID=o.SalesPersonID
group by e.EmployeeID,e.FirstName;

/*
Q20. Average Order Sales by Country
Display:
country
average sales
*/

select
	c.Country,
	AVG(o.Sales) as AverageSales
from Sales.Customers as c
left join Sales.Orders as o
on c.CustomerID=o.CustomerID
group by c.Country;

--------CROSS JOIN-----------
/*
SQL CROSS JOIN combines every row from one table with every row from another table. 
It produces a Cartesian product, meaning each row of the first table is paired with every row of the second table.

--Does not require a join condition.
--If one table has m rows and the other has n rows, the result contains m × n rows.*/


/*Q:- Generate all possible combinations of customers and orders. */
SELECT *
FROM customers
CROSS JOIN orders;

/*
Multi Join

Q:-Using SalesDB, Retrieve a list of all orders,along with
the related customer,product and employee deatils.*/

use SalesDB;

Select 
	o.OrderID,
	c.Firstname as CustomerName,
	p.Product,
	o.Sales,
	p.Price,
	e.Firstname as EmployeeName
From Sales.Orders as o
left join Sales.Customers as c
on o.CustomerID=c.CustomerID
left join Sales.Products as p
on o.ProductID=p.ProductID
left join Sales.Employees as e
on o.SalesPersonID=e.EmployeeID;
