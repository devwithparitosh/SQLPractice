-- FLOOR
-- MOD
-- TRUNCATE
-- POWER
-- ABS
-- ROUND
-- CEIL
-- SQRT


/*
ABS() – Absolute Value
The ABS() function returns the absolute value of a number, which is the number without its sign (i.e., it converts negative numbers to positive).

Syntax:

SELECT ABS(number);
*/

SELECT emp_id, emp_name, salary, ABS(salary*0.10) as Bouns_salary FROM emp;




/*
     -- CEIL() or CEILING() – Round Number Up
The CEIL() (or CEILING()) function rounds a number up to the nearest integer, regardless of whether the decimal part is greater than or less than 0.5.

Syntax:
SELECT CEIL(number);
*/


UPDATE emp SET salary = 80000.92 WHERE emp_id=101 ;
UPDATE emp SET salary=20000.25 WHERE emp_id=102;
UPDATE emp SET salary=30000.50 WHERE emp_id=103;

SELECT CEIL(Salary) AS base_salary FROM emp;


/*
-- FLOOR() – Round Number Down
The FLOOR() function rounds a number down to the nearest integer, ignoring the decimal part.

Syntax:
SELECT FLOOR(number);
*/

SELECT FLOOR(salary) AS round_salary FROM emp;

/*
-- ROUND() – Round a Number to a Specified Decimal Place
The ROUND() function rounds a number to a specified number of decimal places. It is very useful for financial calculations or whenever precise rounding is necessary.

Syntax:
SELECT ROUND(number, decimal_places);
*/

SELECT ROUND(salary,1) AS round_salary,salary FROM emp; 


/*
-- TRUNCATE() – Remove Decimal Places
The TRUNCATE() function is used to remove the decimal portion of a number without rounding. It truncates the number to the specified number of decimal places.

Syntax:
SELECT TRUNCATE(number, decimal_places);*/


-- SELECT TRUNCATE(80000.92,1) from emp;

/*
-- MOD() – Modulo or Remainder
The MOD() function returns the remainder of a division operation (i.e., it computes the modulus). This function is useful for tasks like determining even/odd numbers or finding remainders in mathematical operations.

Syntax:
SELECT MOD(dividend, divisor);*/

SELECT MOD(salary,9) AS Mod_salary FROM emp;

/*
POWER() – Raise a Number to the Power of Another
The POWER() function is used to raise a number to the power of another number. It is often used in mathematical calculations like compound interest or growth rate.

Syntax:

SELECT POWER(base, exponent);
*/

SELECt POWER(Salary, 2) AS Double_salary FROM emp;

/*
EXP() – Exponential Function
The EXP() function returns the value of e raised to the power of a specified number, where e is the base of the natural logarithm (approximately 2.71828).

Syntax:

SELECT EXP(number);
*/

SELECT EXP(1);

/*
-- LOG() – Logarithm
The LOG() function returns the natural logarithm (base e) of a number. You can also use LOG(base, number) to calculate the logarithm of a number with a custom base.

Syntax:
SELECT LOG(number);
SELECT LOG(base, number);
*/

SELECT LOG(100);

/*
-- RAND() – Random Number
The RAND() function generates a random floating-point number between 0 and 1. This function is commonly used for simulations, lotteries or generating random samples.

Syntax:
SELECT RAND();
*/

SELECT RAND();

-- Convert names to uppercase.
-- Convert names to lowercase.
-- Display the length of each name.
-- Round decimal values.

-- Replace text in a column.
-- Concatenate first and last names.
-- Find the longest name.
-- Find the shortest name.

-- Find duplicate names.
-- Remove duplicate records.


