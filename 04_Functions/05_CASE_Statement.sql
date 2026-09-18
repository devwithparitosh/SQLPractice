/* The SQL CASE statement is used to add conditional logic inside SQL queries. It checks conditions one by one and returns a value as soon as a matching condition is found.

Works like an IF-THEN-ELSE statement inside SQL.
Helps categorize data or transform values dynamically.
Can be used in SELECT, UPDATE, ORDER BY and other clauses. 

CASE case_value
    WHEN value1 THEN result1
    WHEN value2 THEN result2
    ...
    ELSE result
END

*/
-- *****************use Case***************************
-- #1 Categorizing the date base on the condition.

/* Q:- Generate a report showing the total sales for each category.
- High if sales>50
- medium if sales is between 20 and 50
-low if sales equal or lower than 20
Sort the result from lowest to highest. */

Select
Category,
SUM(Sales) as TotalSales
from(
    Select
        OrderID,
        Sales,
        CASE
            WHEN Sales > 50 THEN 'High'
            WHEN Sales >20 THEN 'MEDIUM'
            ELSE 'LOW'
        END AS Category
    from Sales.Orders
    
)t 
GROUP BY Category
ORDER BY TotalSales ASC;


-- #2 Mapping :- Transform the value from one form to another.
-- Q:-Retrive employee details with gender diaplayed as full text.
Select
    EmployeeID,
    FirstName,
    LastName,
    Gender,
    CASE
        WHEN Gender = 'M' Then 'Male'
        WHEN Gender='F' Then 'Female'
        ELSE 'Not Available'
    END as GenderINtext
from Sales.Employees;

-- Q:- Retrive customers deatils with abbreviated country code.
Select 
    CustomerID,
    FirstName,
    lastName,
    Country,
    CASE 
        WHEN Country='USA' THEN 'US'
        WHEN Country='Germany' THEN 'DE'
        ELSE 'N/A'
    END as CountryCode,

    CASE Country                         -- Quick FORM for the single column
         WHEN 'USA' THEN 'US'
         WHEN 'Germany' THEN 'DE'
         ELSE 'N/A'
    END as CountryCode2
From Sales.Customers;


-- #3 Handling the NULL values.
-- Q:- Find the average score of customers and treat NUlls AS 0. Additionally provide deatils such as CustomerID and LastName.
Select
    CustomerID,
    LastName,
    Score,
    CASE 
        WHEN Score IS NULL THEN 0
        ELSE Score
    END as CleanScore,

    AVG(CASE 
        WHEN Score IS NULL THEN 0
        ELSE Score
        END) Over() AVGScore,

    AVG(Score) Over() AVGScore2

    -- AVG(isnull(Score,0)) Over() AVGScore
From Sales.Customers;


-- #4 Conditinal Aggergation
-- Q:- Count How many times each customer has made an order with sales greater than 30.

Select
    CustomerID,
    SUM(Case 
        When Sales>30 then 1
        Else 0
        END) as TotalOrdersHIGHSales,
    COUNT(*) as TotalOrders
From Sales.Orders
GROUP BY CustomerID;