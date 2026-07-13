-- CTE

/*
1:Create a CTE that keeps only products whose price is greater than 30,000.

Then display:

ProductName
Price
*/
WITH Price_filter AS 
( 
	SELECT
		P.ProductName,
		P.Price
	FROM Products P
	WHERE P.Price > 30000
)
SELECT
	PF.ProductName,
	PF.Price
FROM Price_filter PF;

/*
2:Create a CTE that calculates the total purchase amount for each customer.

Then display only customers where:
Total Purchase > 70,000

Display:

CustomerID
TotalPurchase
*/
WITH Customer_info AS
(
	SELECT
		C.CustomerID,
		SUM(O.TotalAmount) TotalPurchase
	FROM Customers C
	INNER JOIN Orders O
	ON C.CustomerID = O.CustomerID
	GROUP BY C.CustomerID
)
SELECT 
	CI.CustomerID,
	CI.TotalPurchase
FROM Customer_info CI
WHERE CI.TotalPurchase > 70000;

/*
3:Create a CTE that contains the following information:

ProductName
CategoryID
Price

Then display products whose price is greater than the average of their own category.
*/
WITH Products_greater_AVG AS
(
	SELECT 
		P.ProductName,
		P.CategoryID,
		P.Price,
		AVG(P.Price) OVER(PARTITION BY P.CategoryID) AverageCategory
	FROM Products P
)
SELECT
	PGA.ProductName,
	PGA.CategoryID,
	PGA.Price
FROM Products_greater_AVG PGA
WHERE PGA.Price > PGA.AverageCategory;

/*
4:Create two CTEs.

First CTE:

Total purchase per customer

Second CTE:

Average purchase per customer

Display in the output:

CustomerID
Total Purchase
Average Purchas
*/
WITH TotalPurchase AS
(
    SELECT
        CustomerID,
        SUM(TotalAmount) AS TotalPurchase
    FROM Orders
    GROUP BY CustomerID
),  

AveragePurchase AS
(
    SELECT
        CustomerID,
        AVG(TotalAmount) AS AveragePurchase
    FROM Orders
    GROUP BY CustomerID
)
SELECT 
    T.CustomerID,
    T.TotalPurchase,
    A.AveragePurchase
FROM TotalPurchase T
INNER JOIN AveragePurchase A ON T.CustomerID = A.CustomerID;

/*
5:Create three CTEs.

First:

Number of orders (per customer)

Second:

Total purchase (per customer)

Third:

Highest purchase (per customer)

Then join them together.
*/
WITH Number_orders AS (
    SELECT CustomerID, COUNT(OrderID)  [Number of orders] FROM Orders GROUP BY CustomerID
),
Total_purchase AS (
    SELECT CustomerID, SUM(TotalAmount)  [Total purchase] FROM Orders GROUP BY CustomerID
),
Highest_purchase AS (
    SELECT CustomerID, MAX(TotalAmount)  [Highest purchase] FROM Orders GROUP BY CustomerID
)
SELECT 
    N.CustomerID, N.[Number of orders], T.[Total purchase], H.[Highest purchase]
FROM Number_orders N
INNER JOIN Total_purchase T ON N.CustomerID = T.CustomerID
INNER JOIN Highest_purchase H ON N.CustomerID = H.CustomerID;
/*
6:Create a CTE that includes:

CustomerID
OrderDate
TotalAmount
Running Total

Then display only orders where:
Running Total > 50,000
*/
WITH Customer_info2 AS
(
	SELECT
		O.CustomerID,
		O.OrderDate,
		O.TotalAmount,
		SUM(O.TotalAmount) OVER(PARTITION BY O.CustomerID ORDER BY O.OrderDate , O.TotalAmount) [Running Total]
	FROM Orders O
)
SELECT
	C2.CustomerID,
	C2.OrderDate,
	C2.TotalAmount,
	C2.[Running Total]
FROM Customer_info2 C2
WHERE C2.[Running Total] > 50000;

/*
7:Create a CTE that calculates the rank of products for each Category.
Then display only the most expensive product in each Category.
*/
WITH Rank_products AS 
(
	SELECT
		P.ProductName,
		P.CategoryID,
		ROW_NUMBER() OVER(PARTITION BY P.CategoryID ORDER BY P.Price DESC) Rank
	FROM Products P
)
SELECT
	RP.CategoryID,
	RP.ProductName,
	RP.Rank
FROM Rank_products RP
WHERE RP.Rank = 1;

/*
8:Create three CTEs.

First:

Orders Summary

Second:

Customers Summary

Third:

Employees Summary
*/
WITH Order_summery AS 
(
	SELECT
		O.OrderID,
		O.OrderDate,
		COUNT(O.TotalAmount) OVER() [Count All Orders],
		SUM(O.TotalAmount) OVER() [Total Amount Of Orders],
		AVG(O.TotalAmount) OVER() [Average Amount Of Orders],
		MAX(O.TotalAmount) OVER() [MAX Of Amount],
		MIN(O.TotalAmount) OVER() [MIN Of Amount]
	FROM Orders O
)
, Customers_summary AS
(
	SELECT
		C.CustomerID,
		CONCAT_WS(' ',C.FirstName,C.LastName) FullName_Customer,
		C.City
	FROM Customers C
)
,Employees_summary AS
(
	SELECT
	E.EmployeeID,
	CONCAT_WS(' ',E.FirstName,E.LastName) FullName_Employee,
	E.Department,
	E.Salary
	FROM Employees E
)
SELECT 
    ES.EmployeeID,
    ES.FullName_Employee,
    ES.Department,
    ES.Salary
FROM Employees_summary ES;


-- Monthly Report
WITH MonthlySales AS 
(
    SELECT
        DATEPART(YEAR, O.OrderDate) AS [Year],
        DATEPART(MONTH, O.OrderDate) AS [MonthNumber],
        DATENAME(MONTH, O.OrderDate) AS [MonthName],
        SUM(O.TotalAmount) AS Sales
    FROM Orders O
    GROUP BY DATEPART(YEAR, O.OrderDate), DATEPART(MONTH, O.OrderDate), DATENAME(MONTH, O.OrderDate)
),

SalesComparison AS 
(
    SELECT
        [Year],
        [MonthNumber],
        [MonthName] AS [Month],
        Sales,
        LAG(Sales) OVER(ORDER BY [Year], [MonthNumber]) AS [Previous Month Sales]
    FROM MonthlySales
)
SELECT
    [Month],
    Sales,
    ISNULL([Previous Month Sales], 0) AS [Previous Month Sales],
    Sales - ISNULL([Previous Month Sales], 0) AS Difference,
    CASE 
        WHEN [Previous Month Sales] IS NULL THEN '0%'
        ELSE CAST(ROUND(((Sales - [Previous Month Sales]) / [Previous Month Sales]) * 100, 2) AS VARCHAR) + '%'
    END AS [Growth Percentage]
FROM SalesComparison
ORDER BY [Year], [MonthNumber];
