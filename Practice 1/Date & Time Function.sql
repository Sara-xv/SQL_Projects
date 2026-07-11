-- Date & Time Functions

/*
1:Display all orders.

Output:
OrderID
OrderDate
Year
Month
Day
*/
SELECT
	O.OrderID,
	O.OrderDate,
	YEAR(O.OrderDate) Year,
	MONTH(O.OrderDate) Month,
	DAY(O.OrderDate) Day
FROM Orders O

/*
2:Display all payments.

Output:
PaymentID
PaymentDate
Month Name
*/
SELECT 
	P.PaymentID,
	P.PaymentDate,
	DATENAME(MONTH,P.PaymentDate) [Month Name]
FROM Payments P

-- 3:Display the number of days between each order date and today.
SELECT
	O.OrderDate,
	DATEDIFF(DAY,O.OrderDate, GETDATE()) Difference
FROM Orders O

-- 4:Display the date that is 30 days after each order date.
SELECT
	O.OrderDate,
	DATEADD(D,30,O.OrderDate)[After 30 days]
FROM Orders O

-- 5:Display all orders placed in March.
SELECT
	O.OrderID,
	O.OrderDate,
	DATENAME(MONTH,O.OrderDate) Month
FROM Orders O
WHERE DATENAME(MONTH,O.OrderDate) = 'March'

/*
6:For each order display:
OrderDate
Last day of that month
*/
SELECT
	O.OrderDate,
	EOMONTH(O.OrderDate) [Last day of that month]
FROM Orders O

/*
7:For each order display:

OrderDate
Weekday Name
Week Number
*/
SELECT
	O.OrderDate,
	DATENAME(WEEKDAY,O.OrderDate) [Weekday Name],
	DATEPART(WEEK,O.OrderDate) [Week Number]
FROM Orders O

-- Report:
/*
Order ID
Order Date
Year
Quarter
Month
Month Name
Week of the Year
Day of the Month
Day of the Week Name
Last Day of the Month
Number of Days Since Order to Today
*/
SELECT
    O.OrderID,
    O.OrderDate,
    DATEPART(YEAR, O.OrderDate)  [Year],
    DATEPART(QUARTER, O.OrderDate)  [Quarter],
    DATEPART(MONTH, O.OrderDate)  [Month],
    DATENAME(MONTH, O.OrderDate)  [Month Name],
    DATEPART(WEEK, O.OrderDate)  [Week of the Year],
    DAY(O.OrderDate)  [Day of the Month],
    DATENAME(WEEKDAY, O.OrderDate)  [Day of the Week Name],  
    EOMONTH(O.OrderDate)  [Last Day of the Month],
    DATEDIFF(DAY, O.OrderDate, GETDATE())  [Number of Days Since Order to Today]
FROM Orders O