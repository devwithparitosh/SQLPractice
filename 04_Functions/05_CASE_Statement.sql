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