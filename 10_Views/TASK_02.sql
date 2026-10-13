/*TASK-02 : PRovide a view for the EU Sales Team that combines details form all 
tables and excludes data realated to the USA*/

CREATE VIEW Sales.EU_Sales_Team AS (
	SELECT 
		O.OrderID,
		O.CustomerID,
		O.OrderDate,
		C.FirstName+' '+COALESCE(C.LastName,'') AS CustomerName,
		c.Country as CustomerCountry,
		o.Sales,
		P.Product,
		EMP.FirstName + ' '+COALESCE(EMP.LastName, '') AS SalesPerson,
		EMP.Department
	FROM Sales.Orders AS O
	LEFT JOIN Sales.Customers AS C
	ON O.CustomerID=C.CustomerID
	LEFT JOIN Sales.Products AS P
	ON O.ProductID=P.ProductID
	LEFT JOIN Sales.Employees AS EMP
	ON O.SalesPersonID=EMP.EmployeeID
	WHERE C.Country !='USA' )

Select * from Sales.EU_Sales_Team