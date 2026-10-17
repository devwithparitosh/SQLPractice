-- ERROR HANDLING (WITH STORED PROCERDURE)
/*Syntax :
	BEGIN TRY
	 -- Statement THAT CAUSE ERROR 
	END TRY 
	
	BEGIN CATCH
		-- HANDLE THE ERROR
	END	CATCH							*/


ALTER PROCEDURE GetCustomerDetail @Country NVARCHAR(50) ='USA'
AS
BEGIN
	BEGIN TRY
		DECLARE @TotalCustomers INT, @AVGScore FLOAT;

		-- STEP 01:- Prepare and Cleanup Data

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

		-- STEP 02 :- Generating reports
		-- Calculate Total Customers And Average Score For Specific Country
		SELECT 
			@TotalCustomers=COUNT(*) ,
			@AVGScore = AVG(Score)
		FROM Sales.Customers
		WHERE Country = @Country;

		PRINT 'Total Customers '+ @Country +':'+ CAST(@TotalCustomers AS NVARCHAR);        -- Dynamic value print (Print all value in string )
		PRINT 'Average Score From '+ @Country +':'+ CAST(@AVGScore AS NVARCHAR);

		-- Calculate Total Number of Orders and Total Sales For Specific Country
		SELECT 
			COUNT(o.OrderID) TotalOrders,
			SUM(o.Sales) TotalSales ,
			1/0
		FROM Sales.Orders as o
		JOIN Sales.Customers as c
		on c.CustomerID=o.CustomerID
		WHERE c.Country=@Country;

	END TRY

	-- Error Handling 
	BEGIN CATCH
		PRINT ('AN ERROR OCCURED');
		PRINT ('ERROR MESSAGE :' +ERROR_MESSAGE());
		PRINT('ERROR NUMBER :'+ CAST(ERROR_NUMBER() AS NVARCHAR));
		PRINT ('ERROR LINE :'+ CAST(ERROR_LINE() AS NVARCHAR));
		PRINT('ERROR PROCEDURE :'+ ERROR_PROCEDURE())
	END CATCH

END
GO

EXEC GetCustomerDetail