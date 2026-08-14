MyDatabase-- SQL CONSTRAINTS

-- Learn about 


--  1) NOT NULL constraint in SQL ensures a column must always contain a value and cannot be left empty. 

-- NOT NULL is used to enforce mandatory fields.
-- It prevents NULL values from being inserted or updated.
-- It is applicable at the column level.



-- 2) PRIMARY KEY constraint in SQL uniquely identifies each record in a table and ensures strong data integrity. It prevents duplicate and NULL values, making it essential for reliable relational database design.

-- Ensures all values are unique.
-- Does not allow NULL values.
-- Only one primary key per table (can be composite).
-- Automatically creates a unique index for faster searches.


-- Practice Questions


-- Create an Employee table with a primary key.
-- Prevent NULL values in Name.
CREATE TABLE emp(
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    city_state VARCHAR(50)
);

INSERT into emp( emp_id,emp_name,city_state) 
VALUES (101,'Diablo','Delhi'),
(102,'Shion','Gujarat'),
(103,'Shuna','Kanyakumari');


-- 3) FOREIGN KEY constraint is a concept in SQL that enforces a valid relationship between two tables by ensuring that the values stored in the child table correspond to existing values in the parent table. This constraint protects the database from inconsistent or invalid relational data.
/*
--------------------FOREIGN KEY on CREATE TABLE----------------
CREATE TABLE Orders (
    OrderID int PRIMARY KEY,
    OrderNumber int NOT NULL,
    PersonID int,
    CONSTRAINT fk_Person
    FOREIGN KEY (PersonID)
    REFERENCES Persons(PersonID)
);
*/
-- -----------------FOREIGN KEY on ALTER TABLE-------------------
/*
    ALTER TABLE Orders
    ADD CONSTRAINT fk_Person
    FOREIGN KEY (PersonID)
    REFERENCES Persons(PersonID);
*/

-- --------------Drop a FOREIGN KEY Constraint-------------
/*  
    ALTER TABLE Orders
    DROP FOREIGN KEY fk_Person;
*/


-- Create a Department table.
-- Connect Employee and Department using a foreign key.
CREATE TABLE Dept(
    Dept_no INT PRIMARY KEY,
    Dept_name VARCHAR(50) NOT NULL,
    Employee_id INT,
    CONSTRAINT ep_person
    FOREIGN KEY (Employee_id)
    REFERENCES emp(emp_id)
);
-- Insert valid records.
INSERT into Dept(Dept_no,Dept_name,Employee_id)
VALUES (01,'HR',101),
(02,'Finance',102),
(03,'IT',103);

SELECT * FROM Dept;
SELECT * FROM emp;


--  4) UNIQUE constraint in SQL prevents duplicate entries in specified column(s) while still allowing multiple NULL values. It helps maintain data accuracy without the strict non-NULL requirement of a PRIMARY key.

-- Supports single or multi-column definitions.
-- Can be added or removed using ALTER TABLE.
-- Index creation depends on the database.
/*
  -------------  UNIQUE Constraint on ALTER TABLE  ----------------
  ALTER TABLE Persons
  ADD UNIQUE (ID);


*/

-- Add a UNIQUE constraint to Email.
ALTER TABLE emp ADD COLUMN email VARCHAR(20) UNIQUE;

DESCRIBE emp;    -- see the structure of the table 

UPDATE emp Set email='abc123@gmail.com' WHERE emp_id=101;
UPDATE emp SET email='qwerty12@gmail.com' WHERE emp_id=102;
UPDATE emp SET email='tempest@gmail.com' WHERE emp_id=103;
SELECT * FROM emp;



-- Try inserting duplicate emails.
UPDATE emp SET email='qwerty12@gmail.com' WHERE emp_id=103;
-- output:-Duplicate entry 'qwerty12@gmail.com' for key 'emp.email'


-- 5) CHECK constraint in SQL ensures that only valid data enters a column by enforcing specific conditions. If a value doesn’t satisfy the defined rule, the insert or update operation is blocked.

-- Can be defined while creating a table or added later using ALTER TABLE.
-- Works with other constraints like PRIMARY KEY, FOREIGN KEY, and NOT NULL.
-- Can check multiple columns at once as a row-level condition.

-----------CHECK Constraint on ALTER TABLE---------------
/*
ALTER TABLE table_name
ADD CONSTRAINT constraint_name CHECK (condition);
                           OR
ALTER TABLE Persons
ADD CONSTRAINT constraint_name CHECK (Age >= 18 AND City = 'Sandnes');

-------------Drop a CHECK Constraint------------
ALTER TABLE Persons
DROP CHECK chk_PersonAge;
*/


-- Add a CHECK constraint for Salary > 10000.
ALTER TABLE emp ADD COLUMN salary Decimal(8,2);

ALTER TABLE emp ADD CONSTRAINT salar_check CHECK (salary>10000);


UPDATE emp SET salary=80000 WHERE emp_id=101;


-- Try violating the CHECK constraint.
UPDATE emp SET salary=2000 WHERE emp_id=102;
-- output:-Check constraint 'salar_check' is violated.


-- 6) DEFAULT constraint in SQL automatically assigns a predefined value to a column when no value is provided during insertion. It helps maintain consistency and reduces the need to specify values for every column in an INSERT query.

-- Fills the column with a preset value when omitted.
-- Ensures consistent data without manual input.
/*

CREATE TABLE table_name (
  column1 datatype DEFAULT default_value,
  column2 datatype DEFAULT default_value
);

-----------------Dropping the DEFAULT Constraint-------------
ALTER TABLE tablename
ALTER COLUMN columnname
DROP DEFAULT;

*/


-- Set a DEFAULT joining date.
ALTER TABLE emp ADD COLUMN joining_date DATE DEFAULT '2023-08-05';


-- Try inserting NULL names.
INSERT INTO emp(emp_id,emp_name,city_state,email,salary,joining_date)
VALUES(104, NULl, 'delhi', 'rugin@gmai.com',60000,DEFAULT);

-- output:-Column 'emp_name' cannot be null

-- Delete a parent record and observe the result.
DELETE from emp WHERE emp_id=101;

-- output:-Cannot delete or update a parent row: a foreign key constraint fails (`practDB`.`Dept`, CONSTRAINT `ep_person` FOREIGN KEY (`Employee_id`) REFERENCES `emp` (`emp_id`))

DESCRIBE emp;
DESCRIBE Dept;

-- Update a foreign key.


-- Remove a constraint.
ALTER TABLE emp DROP CONSTRAINT salar_check;


-- 7) An Alternate Key is a candidate key that is not chosen as the Primary Key but can still uniquely identify a record in a table.

-- When multiple attributes can uniquely identify records, only one is selected as the Primary Key.
-- The remaining unique attributes act as Alternate Keys, providing alternative ways to identify records.
/*
CREATE TABLE CustomerInfo (
    CustomerID INT PRIMARY KEY,         
    CustomerName VARCHAR(50),
    EmailAddress VARCHAR(100) UNIQUE,  
    PanNumber VARCHAR(20) UNIQUE,       
    City VARCHAR(50)
);


INSERT INTO CustomerInfo VALUES 
(1, 'James Carter', 'james.carter@example.com', 'PANA12345Z', 'New York'),
(2, 'Emily Watson', 'emily.watson@example.com', 'PANB67890Q', 'Los Angeles');


-- EmailAddress and PanNumber act as Alternate Keys (unique but not the Primary Key).
-- Both rows follow the uniqueness rules.

*/