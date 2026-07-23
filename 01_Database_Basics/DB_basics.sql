/*Week 1 – Database Basics

Learn
CREATE DATABASE
CREATE TABLE
INSERT
SELECT
UPDATE
DELETE
DROP
TRUNCATE

Practice Questions 
Create a database named CollegeDB.
*/

-- Create a Students table.

CREATE TABLE Students(
    Student_id INT(2) PRIMARY KEY,
    first_name CHAR(50),
    last_name CHAR(50),
    age INT(80),
    city CHAR(10)
)

-- Insert 10 student records.

INSERT INTO Students(Student_id,first_name,last_name,age,city)
VALUES (01,'Rohan','Kumar',18,'Bihar'),
(02,'Sonam','Kumari',20,'Delhi'),
(03,'Riya','Singh',21,'Sonpur'),
(04,'Rajat','Singh',23,'Baliya'),
(05,'Priyanshu','Raj',17,'Bhopal'),
(06,'Sourabh','Mishra',20,'G Noida'),
(07,'Neeraj','Kumar',18,'Gorakhpur'),
(08,'Aman','Yadav',26,'Noida'),
(09,'Akash','Kumar',17,'Delhi'),
(10,'Vivek','Kumar',18,'Bihar'),
(11,'Golu','Singh',22,'Jammu'),
(12,'Gujiya','Kumar',17,'Punjab');


-- Display all students.
SELECT * FROM Students;


-- Display only student names.
SELECT first_name, last_name FROM Students;

-- Display students older than 20.
SELECT * FROM Students WHERE age>20;


