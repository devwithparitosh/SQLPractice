-- NULL Value MANAGE for * data aggregration *

-- Find the average scorce of the customers.
Select 
    CustomerID,
    Score,
    AVG(COALESCE(Score,0)) over() as AverageScore
From Sales.Customers;

/* Diaplay the full name of the customers in a single field 
-- by merging their first and last name ,
-- and add 10 bonus points to each customer's score */

Select 
    CustomerID,
    FirstName,
    LastName,
    FirstName+' '+COALESCE(LastName,'N/A') as FullName,
    Score,
    COALESCE(Score,0)+10 as BONUSSCORE
From Sales.Customers;


--Sort the Customers from lowest ot highest scores,
-- with nulls appearing last 

Select 
    CustomerID,
    Score,
    COALESCE(Score,0) NULL_HANDLE
from Sales.Customers
order by COALESCE(Score,0) desc;


-- Find the sales price for each order by dividing sales by quantity
Select 
    OrderID,
    Sales,
    Quantity,
    Sales/NULLIF(Quantity,0) as price
From Sales.Orders;


-- Filtering data
-- Q:- Identify the customer who have no scores.

Select 
    *
From Sales.Customers
where Score is null;

Select 
    *
From Sales.Customers
where Score is not null;


-- Q:-Finding the unmatched rows between two tables.
-- Q:- List all details for customers who have not placed any orders.
Select 
    c.*,
    o.OrderID
From Sales.Customers as c
left join Sales.Orders as o
on c.CustomerID=o.CustomerID
where o.CustomerID is null;

-- NULL vs Empty String vs BlankSpace
with Orders as (
select 1 Id, 'a' Category UNION
select 2, NULL UNION 
select 3, '' UNION
select 4, '  ' )

Select *,
    DATALENGTH(Category) as LegthofChar
from Orders;