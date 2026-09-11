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


use SalesDB;

SELECT
    OrderID,
    OrderDate,
    ShipDate,
    CreationTime
FROM Sales.Orders;

-- HardCodded
SELECT
    OrderID,
    OrderDate,
    CreationTime,
    '2026-08-20' HardCoded
FROM Sales.Orders;


-- 	GETDATE()
-- This function is used to get the current database system date and time.

SELECT
    OrderID,
    OrderDate,
    ShipDate,
    CreationTime,
    GETDATE() Today
FROM Sales.Orders;

 
SELECT 
    DAY(ShipDate) as DayOfShip,
    MONTH(ShipDate) as MonthofShip,
    YEAR(ShipDate) as Yearofship
from Sales.Orders;

-- DATEPART()
-- Is used to return a specified part of a date or time value as integer.
SELECT 
     DATEPART(year,CreationTime) as Year_dp,
     DATEPART(quarter,CreationTime) as quarter_dp,
     DATEPART(week,CreationTime) as week_dp,
     DATEPART(Hour,CreationTime) as Hour_dp
From Sales.Orders;


-- 	DATE_BUCKET()
-- Is used to group data into groups that correspond to fixed periods of time.

-- 	DATEFROMPARTS()
-- This function is used to retrieve a date from individual segments such as year, month, and day.

-- 	DATENAME()
-- This function is used to retrieve a specified part of a date or time value as string.

Select
    DATENAME(quarter,CreationTime) as quater_in_string,
    DATENAME(Weekday,CreationTime) as week_in_str,
    DATENAME(Day,CreationTime) as day_in_str,
    DATENAME(month,CreationTime) month_in
From Sales.OrdersArchive;


-- DATETRUNC()
-- Is used to truncate a date or time value to a specified datepart (such as year, month, day, etc.).

Select
     DATETRUNC(minute, CreationTime) as Minute_afterward_reset,
     DATETRUNC(month, CreationTime) as Month_afterward_reset,
     CreationTime
From Sales.OrdersArchive;


-- 	EOMONTH()
-- This function is used to get the last day of the month for a specified date value.

Select
    CreationTime,
    EOMONTH(CreationTime) as ENDOftheMonth
From Sales.OrdersArchive;
    
-- 	GETUTCDATE()
-- This function is used to get the current database system UTC date and time.

-- 	ISDATE()
-- Is used to determine whether a value is a valid date or not.

-- Q:- How many orders were placed each year?
Select
    YEAR(OrderDate),
    COUNT(*)
From Sales.Orders
GROUP BY YEAR(OrderDate);


-- Q:-HOW many orders were placed each month?
Select 
    DATENAME(MONTH,OrderDate) as MonthOfOrder,
    count(*)
From Sales.Orders
GROUP BY DATENAME(MONTH,OrderDate);


-- Q: Show all orders That were placed during the month of february
Select 
    *
From Sales.Orders
Where MONTH(OrderDate)=2;
--Filtering data using an integer is faster than using a string
Select 
   *
From Sales.Orders
where DATENAME(Month, OrderDate)='February';
-- But it's slower than the integer searching. Avoid using DateName() for filtering data, instead use DatePart()


-- Formating & Casting ----------------------------------
-- Formating is Changing the format of a value from one to another. Changing how the data looks.
-- casting is Changing the datatype from one to another.

-- FORMAT(Value, Format);
Select 
    OrderID,
    CreationTime,
    FORMAT(CreationTime,'MM-dd-yyyy'),
    FORMAT(CreationTime, 'dd') as dd,
    FORMAT(CreationTime, 'ddd') as ddd,
    FORMAT(CreationTime, 'dddd') as dddd,
    FORMAT(CreationTime, 'MM') as MM,
    FORMAT(CreationTime, 'MMM') as MMM,
    FORMAT(CreationTime, 'MMMM') as mmmm
From Sales.Orders;

-- Q: Show CreationTime Using the Following Format:
-- Day WED Jan Q1 2025 12:34:56 PM

SELECT
    'Day '+FORMAT(CreationTime, 'ddd MMM') +
    ' Q'+DATENAME(QUARTER,CreationTime)+' '+
    FORMAT(CreationTime ,'yyyy hh:mm:ss tt') as CustomFormat
From Sales.Orders;

-- Q:- sales by MONTHwithyear
Select
    FORMAT(OrderDate, 'MMM yy') as OrderDate,
    COUNT(*)
From Sales.Orders
GROUP BY FORMAT(OrderDate,'MMM yy');


-- CONVERT() :- Converts a date or time value to a different datatype & format the value
-- CONVERT(data_type, value [,style])

Select
    CreationTime,
    CONVERT(DATE,CreationTime) as [Date_time to date],    -- casting
    CONVERT(VARCHAR,CreationTime, 32) as [USA std. Style:32] -- Formating
From Sales.Orders;


-- CAST() : Converts a value to a Specified dataType.

Select
    CAST('123' as INT ) as [String to int],
    CAST( 123 as varchar) as [INT as String],
    CAST('2025-08-20' as date) as [String to Date],
    CAST('2025-08-20' as datetime2) as [String to Datetime],
    CreationTime,
    CAST(CreationTime as date) as [Datetime to date]
From Sales.Orders;
    
--Date Calculation

-- 	DATEADD()
-- Is used to add a specific number of intervals to a given date or time value.

-- DATEADD(part,interval,date);
Select
    OrderID,
    OrderDate,
    DATEADD(MONTH,3,OrderDate) as addMonth,
    DATEADD(YEAR, 2,OrderDate) as addYear,           -- add the year
    DATEADD(DAY, -5,OrderDate) as subtractdate        -- subtract the date
from Sales.Orders;

-- 	DATEDIFF_BIG()
-- Is used to calculate the difference between two dates values and return in a bigint data type.

-- 	DATEDIFF()
-- Is used to calculate the difference between two date values and returns in a int data type.

-- find the interval days  between the shipping and delievery date
Select 
    OrderID,
    DATEDIFF(DAY,OrderDate,ShipDate) as Deliverydays
From Sales.Orders;
