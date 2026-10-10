/*A recursive CTE references itself to retrieve hierarchical data, such as employee-manager relationships.
Use MAXRECURSION to prevent infinite loops.
It consist of two parts:

Anchor member: The initial query that selects the base case (e.g., top-level managers).
Recursive member: The query that references the CTE itself, pulling the next level of data.*/

-- Q:- Generate a Sequence of Numbers from 1 to 20.
With Series as (
Select 
	1 as MyNumber

	UNION ALL

	-- RECURSIVE QUERY
	SELECT
	MyNumber+1 as CurrentNUmber
	From Series
	Where MyNumber <20
)

-- Q:- Show The employee hierarchy by displaying each employee's level within the organization.
, cte_Hierarchy as (
Select
	EmployeeID,
	FirstName,
	ManagerID,
	1 as LEVEL
From Sales.Employees
where ManagerID IS NUll 

UNION ALL

Select
	e.EmployeeID,
	e.FirstName,
	e.ManagerID,
	LEVEL+1 
From Sales.Employees as e
JOIN cte_Hierarchy as che
on e.ManagerID=che.EmployeeID
)


-- Main Query
/*SELECT * 
FROM Series ; 
-- OPTION (MAXRECURSION 10)           -- HELP TO CONTROL RECURSION OF THE EXECUTION (DEFAULY IS 100)
*/

Select *
from cte_Hierarchy;

