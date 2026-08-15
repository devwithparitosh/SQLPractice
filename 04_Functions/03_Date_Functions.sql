-- Topic Covered
-- Date Functions
-- DATE_FORMAT
-- DATEDIFF
-- DAY
-- STR_TO_DATE
-- YEAR
-- MONTH
-- NOW
-- CURDATE

-- Questions
-- Show the current date.
-- Extract the year.
-- Extract the month.
-- Find employees hired today.


-- SQL Date Functions are built-in tools used to handle, modify and analyze date/time values in a database. They help perform tasks like retrieving current dates, calculating differences and formatting results effectively.

-- Extract specific parts of a date (year, month, day).
-- Format dates for user-friendly display.
-- Track trends, deadlines or schedules in business processes.

-- NOW()
-- The NOW() function retrieves the server’s current date and time, making it useful for capturing exact event moments such as transaction timestamps, as well as for logging and comparing time-based records.

-- Query:
--      SELECT NOW() AS current_datetime;

SELECT NOW() AS current_datetime;


-- CURDATE()
-- The CURDATE() function returns today’s date in YYYY-MM-DD format and is useful when only the current date is needed, especially for reporting or filtering records by date.

-- Query:
--       SELECT CURDATE() AS current_date;

-- Returns today’s date only.
-- Time part is not included.


SELECT CURDATE() AS current_datefor;


-- CURTIME()
-- The CURTIME() function returns the current time in HH:MM:SS format and is useful for time-based operations, such as scheduling or performing precise time comparisons.

-- Query:
--         SELECT CURTIME() AS current_time;

-- 
-- Returns the current system time.
-- Shows hours, minutes and seconds only.

SELECT CURTIME() AS current_time_stamp;

/*
    --DATE()
The DATE() function extracts only the date from a date or datetime value, making it useful for situations where the time component should be ignored, such as date-only comparisons or aggregations.

Query:
    SELECT sale_id, product_name,DATE(sale_date) AS sale_date_only FROM sales;

    -- Extracts only the date part from sale_date.
    -- Removes any time portion if present.
*/

SELECT * FROM temp_workers;

SELECT emp_id,first_name,DATE(joining_date) AS date_join FROM temp_workers;

/*
    --EXTRACT()
The EXTRACT() function retrieves a specific part of a date such as the year, month or day, making it useful for grouping, filtering or performing time-based analysis including year-over-year reports.

Query:

    SELECT sale_id, product_name, 
    EXTRACT(YEAR FROM sale_date) 
    AS sale_year FROM sales;

-- Pulls out the year from the sale date.
-- Useful for grouping or filtering by year.
*/

SELECT emp_id, first_name, EXTRACT(YEAR FROM joining_date) AS join_year FROM temp_workers;


SELECT emp_id,first_name, EXTRACT(MONTH FROM joining_date) AS join_date FROM temp_workers;

/*
   -- DATE_ADD()
The DATE_ADD() function adds a chosen time interval such as days, months or years to a date, making it useful for calculating future dates and simplifying planning or scheduling tasks.

Query:
SELECT sale_id, product_name, 
DATE_ADD(sale_date, INTERVAL 7 DAY) AS sale_date_plus_7_days 
FROM sales;    

-- Adds 7 days to the sale date.
-- Returns the new future date.
*/

SELECT emp_id, first_name, DATE_ADD(joining_date, INTERVAL 7 DAY ) AS joining_7_days FROM temp_workers;

/*
DATE_SUB()
The DATE_SUB() function subtracts a chosen time interval from a date, making it useful for determining past dates and performing retrospective data analysis.

Query:

SELECT sale_id, product_name, 
DATE_SUB(sale_date, INTERVAL 3 DAY) 
AS sale_date_minus_3_days 
FROM sales;


-- Subtracts 3 days from the sale date.
-- Returns an earlier date.
*/

SELECT emp_id,first_name,DATE_SUB(joining_date, INTERVAL 3 DAY) AS joining_sub FROM temp_workers;


/*
 DATEDIFF()
The DATEDIFF() function returns the number of days between two dates, making it useful for calculating durations such as deadlines or overdue periods. In this case, it shows how many days remain from each sale date until August 15, 2024.

Query:

SELECT sale_id, product_name, sale_date,
DATEDIFF('2024-08-15', sale_date) AS days_until_aug15
FROM sales;

-- Calculates days between two dates.
-- Shows how many days until 15-Aug-2024.
*/

SELECT emp_id, first_name, joining_date, DATEDIFF('2002-08-09', joining_date) AS amount_year_of_joining FROM temp_workers;

/*
-- DATE_FORMAT()
The DATE_FORMAT() function formats a date using a specified pattern, allowing customized output such as full day or month names and is useful for making reports clearer and more readable.

Query:

SELECT sale_id, product_name, 
DATE_FORMAT(sale_date, '%W, %M %d, %Y') 
AS formatted_sale_date FROM sales;

-- Converts date into a readable text format.
-- Displays weekday, month name, day and year.

*/

SELECT emp_id, first_name, DATE_FORMAT(joining_date, '%W, %M %D,%Y') AS format_joining_date FROM temp_workers;

/*
The SQL DATEADD() function is a built-in function which adds a specified number (a signed integer) of intervals to a given date or time, and returns a modified date/time value.

This function accepts three parameters − the interval to add (such as year, quarter, month, hour, minute, etc.), the number of intervals to add (which can be positive or negative integer value), and the date or time value that specifies the starting point for the addition.

Note − The data type of the return value for this function is dynamic and it depends on the argument supplied for the date.

-- Syntax
Following is the syntax of the SQL DATEADD() function −
DATEADD(datepart, number, date)


Parameters
This function accepts three parameters. The same is described below −

-- datepart − This specifies the segment of the date or time to add. The following are the possible values −
year, yyyy, yy = Year
quarter, qq, q = Quarter
month, mm, m = Month
dayofyear, dy, y = Day of the year
day, dd, d = Day
week, ww, wk = Week
weekday, dw, w = Weekday
hour, hh = Hour
minute, mi, n = Minute
second, ss, s = Second
millisecond, ms = Millisecond

-- number − This specifies the interval to add to the date. This interval can be positive (will get the date or datetime in the future) or a negative (will get the date or datetime in the past) integer.

-- date − This specifies the date to which the intervals are added.
*/

-- this is the best QUERY to work on the date it will do all  the operation of date, time , hour, year, month.

SELECT emp_id , first_name, DATEADD(YEAR,10, joining_date) AS DATE_add FROM temp_workers;