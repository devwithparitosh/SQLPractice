/*SET OPERATORS 

*/

-- Union ----------------------

 
/*
Q:- Combine the data from employees and customers into one table*/

Select
	FirstName,
	LastName
from Sales.Customers
UNION
Select
	FirstName,
	LastName
from Sales.Employees;


-- UNION ALL -----------------------
/*
Return all rows from both quiers, including duplicates.
*/

Select
	FirstName,
	LastName
From Sales.Customers
union all
Select 
	FirstName,
	LastName
from Sales.Employees;

-- Except  --------------------------------

/*Q:- Find Employees who are not customers at the Same time*/

Select 
	FirstName,
	LastName
From Sales.Employees
Except
Select 
	FirstName,
	LastName
From Sales.Customers;

-- 
Select 
	FirstName,
	LastName
From Sales.Customers
Except
Select 
	FirstName,
	LastName
From Sales.Employees;


--- Intersect ---------------

Select 
	FirstName,
	LastName
From Sales.Customers
INTERSECT
Select 
	FirstName,
	LastName
From Sales.Employees;

-- UNION Use case ------------
-- Combination Similar information before analyzing the data

/* Q:- ORders are Stored in Separate Tables (ORders and OrdersArchive).
Combine all Orders Into one Report Without Duplicates*/

Select *
From Sales.Orders
UNION 
Select *
From Sales.OrdersArchive;

-- Not a great practice

-- OR---------
Select 
	'Orders' as SourceTable,
	OrderID,
	ProductID,
	CustomerID,
	SalesPersonID,
	OrderDate,
	ShipDate,
	OrderStatus,
	ShipAddress,
	BillAddress,
	Quantity,
	Sales,
	CreationTime
From Sales.Orders
Union
Select
	'OrdersArchive' as SourceTable,
	OrderID,
	ProductID,
	CustomerID,
	SalesPersonID,
	OrderDate,
	ShipDate,
	OrderStatus,
	ShipAddress,
	BillAddress,
	Quantity,
	Sales,
	CreationTime
From Sales.OrdersArchive
ORDER BY OrderID;

-- EXCEPT Use cases (Delta Detection) --------

/*
:- Indentifying the differnece or changes(delta) between two batches of data 
*/

-- Except Use case (Check Completeness)
-- :- Except Operator can be used to compare tables to detect discrepancies between databases.