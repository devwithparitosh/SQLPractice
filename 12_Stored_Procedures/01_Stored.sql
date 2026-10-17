/*Stored procedures are used to group SQL statements and business logic into a single reusable unit that runs inside the database. 

These help in tasks such as:
	>Executing multiple SQL statements as one operation.
	>Accepting input and returning output values.
	>Reducing repeated code in applications.
	>Enforcing consistent business rules across systems.


Syntax
	CREATE PROCEDURE procedure_name
	(parameter1 data_type, parameter2 data_type, ...)
	AS
	BEGIN
	   -- SQL statements to be executed
	END

CREATE PROCEDURE – Creates a new stored procedure.
@parameters – Used to pass values into the procedure.
BEGIN…END – Contains the SQL code that the procedure runs.*/

-- Step:-1 Write a Query
-- For US Customers Find the total Number of Customers and the average Score.

/*SELECT 
	COUNT(*) AS TotalCustomers,
	AVG(Score) as AVGScore
FROM Sales.Customers
WHERE Country ='USA'*/

--Step 02:- Turning the Query into a Stored Procedure
CREATE PROCEDURE GetCutomerOFUSA as 
BEGIN
	SELECT 
		COUNT(*) TotalCustomer,
		AVG(Score) AVGScore
	FROM Sales.Customers
	WHERE Country='USA'
END


--sTEP 03:- execute the stored procedure 
EXEC GetCutomerOFUSA;


-- Stored procedure with parameter
ALTER PROCEDURE GetCutomerOFUSA @Country NVARCHAR(50)
AS 
BEGIN
	SELECT 
		COUNT(*) TotalCustomer ,
		AVG(Score) AVGScore
	FROM Sales.Customers
	Where Country= @Country
END

-- Execute with parameter 
EXEC GetCutomerOFUSA @Country='Germany';

DROP PROCEDURE GetCutomerOFUSA;


--Default value in paramerter
CREATE PROCEDURE GetCutomerOFUSA @Country NVARCHAR(50) ='USA'   -- Default value print (USA)
AS 
BEGIN
	SELECT 
		COUNT(*) TotalCustomer ,
		AVG(Score) AVGScore
	FROM Sales.Customers
	Where Country= @Country
END

EXEC GetCutomerOFUSA



-- MULTIPLE STORED PROCEDURE

CREATE PROCEDURE GetCustomerDetail @Country NVARCHAR(50) ='USA'
AS 
BEGIN
	SELECT 
		COUNT(*) TotalSales,
		AVG(Score) AVGScore
	FROM Sales.Customers
	WHERE Country= @Country;

-- Find the total NO. Of Orders and total Sales 
	SELECT 
		COUNT(o.OrderID) TotalOrders,
		SUM(o.Sales) TotalSales 
	FROM Sales.Orders as o
	JOIN Sales.Customers as c
	on c.CustomerID=o.CustomerID
	WHERE c.Country=@Country;
END

EXEC GetCustomerDetail




-- Stored Procedure Variables
-- Placeholders used to store values to be used later in the procedure.

ALTER PROCEDURE GetCustomerDetail @Country NVARCHAR(50) ='USA'
AS
BEGIN

DECLARE @TotalCustomers INT, @AVGScore FLOAT;

SELECT 
	@TotalCustomers=COUNT(*) ,
	@AVGScore = AVG(Score) 
FROM Sales.Customers
WHERE Country = @Country;

PRINT 'Total Customers '+ @Country +':'+ CAST(@TotalCustomers AS NVARCHAR);        -- Dynamic value print (Print all value in string )
PRINT 'Average Score From '+ @Country +':'+ CAST(@AVGScore AS NVARCHAR);

	SELECT 
		COUNT(o.OrderID) TotalOrders,
		SUM(o.Sales) TotalSales 
	FROM Sales.Orders as o
	JOIN Sales.Customers as c
	on c.CustomerID=o.CustomerID
	WHERE c.Country=@Country;
END
GO

EXEC GetCustomerDetail;         -- Check the msg section also result

EXEC GetCustomerDetail @Country = 'Germany';   



-- Control flow (IF- ELSE)
-- Handling the NULLs
ALTER PROCEDURE GetCustomerDetail @Country NVARCHAR(50) ='USA'
AS
BEGIN

DECLARE @TotalCustomers INT, @AVGScore FLOAT;

-- Prepare and Cleanup Data

IF EXISTS (Select 1 from Sales.Customers where Score IS NULL AND Country = @Country)
BEGIN 
	PRINT ('Updating NULL Score to 0');
	UPDATE Sales.Customers
	SET Score=0
	WHERE Score IS NULL AND Country = @Country;
END 

ELSE 
BEGIN 
	PRINT ('NO NULL Scores Found');
END 

-- Generating reports
SELECT 
	@TotalCustomers=COUNT(*) ,
	@AVGScore = AVG(Score) 
FROM Sales.Customers
WHERE Country = @Country;

PRINT 'Total Customers '+ @Country +':'+ CAST(@TotalCustomers AS NVARCHAR);        -- Dynamic value print (Print all value in string )
PRINT 'Average Score From '+ @Country +':'+ CAST(@AVGScore AS NVARCHAR);

	SELECT 
		COUNT(o.OrderID) TotalOrders,
		SUM(o.Sales) TotalSales 
	FROM Sales.Orders as o
	JOIN Sales.Customers as c
	on c.CustomerID=o.CustomerID
	WHERE c.Country=@Country;
END
Go
EXEC GetCustomerDetail