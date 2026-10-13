/*A temporary table in SQL is a special table used to store data temporarily during query execution. 
It helps hold intermediate results without affecting permanent tables.
	>Stored in the system’s temporary database (like TempDB in SQL Server).
	>Automatically deleted when the session ends.
	>Useful for calculations or data processing without changing permanent data.

Syntax:-
	->To Create a Temporary Table (MYSQL | POSTGRES | ORACLE)
CREATE TABLE #emp_details (
id INT, 
name VARCHAR(25)
) ;

	->To Create a Temporary Table (SQL Server)
SELECT 
	COL1,....
INTO #TEMP_TABLE_NAME
FROM TABLE_NAME;

	->To Insert Values Into a Temporary Table
INSERT INTO #emp_details 
VALUES (1, 'James'), (2, 'Mike');

	->To Select Values from the Temporary Table
SELECT * FROM #emp_details;
*/


/*
Step 1:- Load data into TEMP table
Step 2:- Transform Data in TEMP table 
Step 3:- Load TEMP Table into Permanent table	*/

SELECT
	*
INTO #ORDERS
FROM Sales.Orders;

SELECT * FROM #ORDERS;

-- Delete temp table
DELETE FROM #ORDERS
	WHERE OrderStatus='Delivered'

-- Want to Save result of temp_table to permanent_table
SELECT 
	* 
INTO Sales.OrdersTest
FROM #ORDERS;