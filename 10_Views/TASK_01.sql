-- Task :- Provide a view that Combines details from orders,
--             products,Customers and employeees.

/*  IF OBJECT_ID('Sales.employee_Overview', 'V') IS NOT NULL      -- FOR UPDATE VIEW IN CASE OF NEED 
	DROP VIEW Sales.employee_Overview;
GO */
CREATE VIEW Sales.employee_Overview AS (
		SELECT
			O.OrderID,
			C.CustomerID,
			C.FirstName + ' '+COALESCE(C.LastName,' ') AS CustomerName,
			C.Country AS CustomerCountry,
			O.Sales,
			P.Product,
			P.Price,
			O.Quantity,
			EMP.FirstName + ' '+COALESCE(EMP.LastName, '') AS SalesPerson,
			EMP.Department
		FROM Sales.Orders AS O
		LEFT JOIN Sales.Products AS P
		ON O.ProductID=P.ProductID
		LEFT JOIN Sales.Customers AS C
		ON O.CustomerID=C.CustomerID
		LEFT JOIN Sales.Employees AS EMP
		ON O.SalesPersonID=EMP.EmployeeID 
)

SELECT * FROM Sales.employee_Overview