/*
-- CONCAT()
The CONCAT() function is used to concatenate (combine) two or more strings into one string. It is useful when we want to merge fields like first and last names into a full name.

Query:
SELECT CONCAT('John', ' ', 'Doe') AS FullName;
*/

SELECT CONCAT(name,' ',last_name) AS NAME FROM Students;

/*
-- CHAR_LENGTH() / CHARACTER_LENGTH()
The CHAR_LENGTH() or LENGTH() function returns the length of a string in characters. It’s essential for validating or manipulating text data, especially when you need to know how many characters a string contains.

Query:
SELECT CHAR_LENGTH('Hello') AS StringLength;*/

SELECT CHAR_LENGTH(name) AS StringLength, name From Students;

/*
-- UPPER() and LOWER()
These UPPER() and LOWER() functions convert the text to uppercase or lowercase, respectively. They are useful for normalizing the case of text in a database.

Query:
SELECT UPPER('hello') AS UpperCase;
SELECT LOWER('HELLO') AS LowerCase;
*/

SELECT UPPER(name) as captial_case, name FROM Students;

SELECT LOWER(name) AS Small_case, name FROM Students;


/*
-- REPLACE()
The REPLACE() function replaces occurrences of a substring within a string with another substring. This is useful for cleaning up data, such as replacing invalid characters or formatting errors.

Query:
SELECT REPLACE('Hello World', 'World', 'SQL') AS UpdatedString;*/

SELECT REPLACE(last_name, 'Singh', 'Rajput') AS last_new_name, last_name FROM Students;


/*
SUBSTRING() / SUBSTR()
The SUBSTRING() (or SUBSTR()) function is used to extract a substring from a string, starting from a specified position.

Query:
SELECT SUBSTRING('Hello World', 1, 5) AS SubStringExample;
*/

SELECT SUBSTRING(emp_name,1,3) AS SUBstring_name,emp_name FROM emp;


/*---LEFT() and RIGHT()
The LEFT() and RIGHT() functions allow you to extract a specified number of characters from the left or right side of a string, respectively. It is used for truncating strings for display.

Query:
SELECT LEFT('Hello World', 5) AS LeftString;
SELECT RIGHT('Hello World', 5) AS RightString;*/

SELECT LEFT(emp_name,3) as left_example, emp_name FROM emp;
SELECT RIGHT(emp_name,3) as RIGHT_example, emp_name FROM emp;


/*
-- INSTR()
The INSTR() function is used to find the position of the first occurrence of a substring within a string. It returns the position (1-based index) of the substring. If the substring is not found, it returns 0.

Syntax:
SELECT INSTR('Hello World', 'World') AS SubstringPosition;*/

SELECT INSTR(emp_name, 'a') as in_string_postion, emp_name FROM emp;


/*
-- LOCATE()
LOCATE() allows you to find the nth occurrence of a substring in a string. This is especially useful when you need to locate a specific substring based on its position.

Query:
SELECT LOCATE('for', 'geeksforgeeks', 1);*/

SELECT LOCATE('a', 'asnjnanaaajdjsja',4);

/*
-- TRIM()
The TRIM() function removes leading and trailing spaces (or other specified characters) from a string. By default, it trims spaces but can also remove specific characters using TRIM(character FROM string).

Query:
SELECT TRIM(' ' FROM '  Hello World  ') AS TrimmedString;*/

SELECT TRIM('S' FROM emp_name) AS Trim_example, emp_name FROM emp;

/*
REVERSE()
The REVERSE() function reverses the characters in a string. It’s useful in situations where we need to process data backward, such as for password validation or certain pattern matching.

Query:
SELECT REVERSE('Hello') AS ReversedString;*/

SELECT REVERSE(emp_name) AS reverse_name , emp_name FROM emp;



