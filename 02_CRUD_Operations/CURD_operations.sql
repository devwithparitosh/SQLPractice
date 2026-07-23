use practDB;

DESCRIBE Students;

SELECT * from Students;

-- Update one student's age.
UPDATE Students SET first_name='Mohit', last_name='Kumar' WHERE first_name= 'Aman' AND last_name='Yadav';
SELECT * from Students;

-- Update all students from one city.
UPDATE Students SET city='Fharidabad' WHERE city='Delhi';
SELECT first_name,city from Students WHERE city='Fharidabad';


-- Delete one student.
DELETE from Students WHERE age=21;
SELECT * from Students;

-- Delete students older than 25.
DELETE from Students WHERE age>25; 
SELECT * from Students;

-- Add a new column (Email).
ALTER table Students ADD Email text(20);
SELECT * from Students;

-- Rename a column.
ALTER TABLE Students RENAME COLUMN first_name TO name;
SELECT * from Students;

-- Drop a column.
ALTER TABLE Students DROP COLUMN last_name;
SELECT * from Students;

-- Truncate the table.
TRUNCATE TABLE Students;

-- Drop the table.
DROP TABLE Students;