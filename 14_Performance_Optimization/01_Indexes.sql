/*	
Indexes in SQL are special database structures that improve query performance by allowing 
faster access to data instead of scanning the entire table. 
They help retrieve records efficiently and enhance overall database performance.

Note: Primary Key and Unique constraints automatically create indexes.

=========== Clustered Index ===================
A Clustered Index defines the physical order of rows in a table. 
When you create a clustered index on a column, SQL Server rearranges the actual data rows to match the index order. 
This is why a table can have only one clustered index. 

It is created only when both the following conditions are satisfied:
	>The data can be stored in a sequential or sorted manner.
	>The column used as the key must contain unique values.

Follows the B-tree structure.

=============== Non-Clustered Index ====================
A non-clustered index stores indexed values separately from the table and uses pointers to locate the actual rows.
Multiple non-clustered indexes can be created to improve query performance.

Stores index data separately from the table.
Multiple non-clustered indexes can exist on a table.
Contains a copy of the indexed column(s) and a pointer to the actual data row.

Follows the B-tree structure with extra layer of basdata pages
*/

Select 
	*
INTO Sales.DBCustomers
From Sales.Customers;

CREATE CLUSTERED INDEX idx_DBCustomers_CustomerID
ON Sales.DBCustomers (CustomerID);

DROP INDEX idx_DBCustomers_CustomerID ON Sales.DBCustomers;

CREATE INDEX idx_DBCustomers_Firstname
ON Sales.DBCustomers (FirstName);

SELECT * 
FROM Sales.DBCustomers
WHERE FirstName= 'Anna';


-- Composite Indexes
CREATE INDEX idx_DBCustomers_Score_Country 
ON Sales.DBCustomers (Score,Country);

--Rule :- The Columns Of Index Order Must Match the Order in Your Query (Score,Country).
-- Score >500 AND Country='USA'
SELECT 
	*
FROM Sales.DBCustomers
WHERE Score >500 AND Country='USA' ;