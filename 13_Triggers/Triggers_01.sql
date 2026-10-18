/*A trigger in SQL is a special stored procedure that runs automatically 
when an INSERT, UPDATE or DELETE operation occurs on a table.
It helps automate actions and keep data consistent.

Syntax:
		create trigger [trigger_name] 
		[before | after]  
		{insert | update | delete}  
		on [table_name]  
		FOR EACH ROW
		BEGIN
		END;

=================== Types of triggers =================================

 >>>>>1. DDL Triggers ================
Data Definition Language (DDL) triggers run when commands like CREATE, ALTER or DROP are used. 
They help track or stop changes to the database structure, such as creating, modifying or deleting tables.

Example: Prevent Table Deletions

		CREATE TRIGGER prevent_table_creation
		ON DATABASE
		FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
		AS 
		BEGIN
		   PRINT 'you can not create, drop and alter table in this database';
		   ROLLBACK;
		END;

>>>>>>2. DML Triggers =================
DML triggers fire when we manipulate data with commands like INSERT, UPDATE or DELETE. 
These triggers are perfect for scenarios where we need to validate data before it is inserted, 
log changes to a table or cascade updates across related tables.

Example: To prevent unauthorized updates in a sensitive students table, we can create a trigger that blocks such changes.

		CREATE TRIGGER prevent_update
		ON students
		FOR UPDATE, INSERT, DELETE
		AS
		BEGIN
			RAISERROR ('You can not insert, update and delete rows in this table.', 16, 1);
		END;

Note:  ROLLBACK TRANSACTION can included for safety, but in most cases RAISERROR itself will prevent the DML from completing.

>>>>>>3. Logon Triggers ====================
Logon triggers run when a user logs in. They are used to track logins, control access and limit sessions. 
Messages from these triggers are stored in the SQL Server error log.

Example: Track User Logins

		CREATE TRIGGER track_logon
		ON LOGON
		AS
		BEGIN
		   PRINT 'A new user has logged in.';
		END;
*/

CREATE TABLE Sales.EmpLOGS(
	LogID INT IDENTITY(1,1) PRIMARY KEY,
	EmployeeID INT,
	LogMessage VARCHAR(255),
	LogDate DATE
)

CREATE TRIGGER trg_AfterInsertEmployee ON Sales.Employees
AFTER INSERT
AS 
BEGIN 
	INSERT INTO Sales.EmpLOGS(EmployeeID,LogMessage,LogDate)
	SELECT 
		EmployeeID,
		'New Employee Added = '+ CAST(EmployeeID as varchar),
		GETDATE()
	FROM inserted                 -- Virtual table that holds a copy of the rows that are being inserted into the target table.
END

Select * from Sales.EmpLOGS

Insert into Sales.Employees
values ( 6, 'Maria','Doe','HR','1988-01-12','F',80000,3)