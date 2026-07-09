--1
SELECT 
	C.CustomerName,
	C.City,
	C.JoinDate
FROM Customers C
WHERE C.JoinDate > '2023-06-01'

--2
SELECT 
	P.ProductName,
	P.Price
FROM Products P 
WHERE P.Category = 'Electronics' AND P.Price > 100

--3
SELECT 
	O.OrderID,
	O.OrderDate
FROM Orders O 
WHERE O.OrderDate >= '2024-03-01'
AND O.OrderDate < '2024-04-01'

--4
SELECT 
	O.OrderID,
	O.Quantity
FROM Orders O
WHERE O.Quantity > 3

--5
SELECT 
	O.OrderID,
	C.CustomerName,
	P.ProductName,
	O.Quantity
FROM Customers C
INNER JOIN Orders O
ON C.CustomerID = O.CustomerID
INNER JOIN Products P
ON O.ProductID = P.ProductID

--6
SELECT 
	C.CustomerName [Customer Name],
	P.ProductName [Product Name],
	P.Category,
	P.Price,
	O.Quantity
FROM Customers C
INNER JOIN Orders O
ON C.CustomerID = O.CustomerID
INNER JOIN Products P
ON O.ProductID = P.ProductID

--7
SELECT 
	C.CustomerName,
	COUNT(O.OrderID) TotalOrders
FROM Customers C
INNER JOIN Orders O 
ON C.CustomerID = O.CustomerID
GROUP  BY C.CustomerName, C.CustomerID -- (there might have been two names)

--8
SELECT 
	P.ProductName,
	SUM(P.Price*O.Quantity) TotalSales
FROM Products P
INNER JOIN Orders O
ON P.ProductID = O.ProductID
GROUP BY P.ProductName

--9
SELECT TOP 1 WITH TIES
    C.CustomerID,
    C.CustomerName,
    COUNT(O.OrderID) AS OrderCount
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CustomerName
ORDER BY COUNT(O.OrderID) DESC;

--10
SELECT TOP 1
	P.ProductName,
	SUM(O.Quantity) TotalQuantitySold
FROM Products P
INNER JOIN Orders O 
ON P.ProductID = O.ProductID
GROUP BY P.ProductName
ORDER BY SUM(O.Quantity) DESC

-- level two
--11
SELECT 
	P.ProductName,
	P.Price
FROM Products P 
WHERE P.Price > (SELECT AVG(P.Price) FROM Products P)

--12
SELECT 
	P.Category,
	COUNT(P.ProductName) TotalProducts ,
	AVG(P.Price) AveragePrice ,
	MAX(P.Price) MaxPrice
FROM Products P
GROUP BY P.Category

--13
SELECT 
	P.ProductName,
	SUM(O.Quantity) AS TotalQuantitySold
FROM Products P
INNER JOIN Orders O
ON P.ProductID = O.ProductID
GROUP BY P.ProductName
ORDER BY TotalQuantitySold DESC



--14
SELECT 
    C.CustomerID,
    C.CustomerName,
    SUM(P.Price * O.Quantity) AS TotalSpent
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
INNER JOIN Products P ON O.ProductID = P.ProductID
GROUP BY C.CustomerID, C.CustomerName
ORDER BY TotalSpent DESC;


--15
WITH Customer_total_sales AS
(
SELECT 
	C.CustomerID,
	C.CustomerName,
	COUNT(O.OrderID) TotalOrders
FROM Customers C
INNER JOIN Orders O 
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID , C.CustomerName	
)
SELECT 
	CTE.CustomerName,
	CTE.TotalOrders
FROM Customer_total_sales CTE
WHERE CTE.TotalOrders > 2

--16
SELECT 
	C.CustomerName,
	O.OrderID,
	O.OrderDate,
	ROW_NUMBER() OVER(PARTITION BY C.CustomerID ORDER BY O.OrderDate) RowNumber
FROM Customers C
INNER JOIN Orders O
ON C.CustomerID = O.CustomerID

--17
SELECT 
	P.ProductName,
	P.Price,
	RANK() OVER(ORDER BY P.Price)
FROM Products P

--18
SELECT TOP 1 WITH TIES
    C.CustomerID,
    C.CustomerName,
    SUM(P.Price * O.Quantity) AS TotalSpent
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
INNER JOIN Products P ON O.ProductID = P.ProductID
GROUP BY C.CustomerID, C.CustomerName
ORDER BY TotalSpent DESC;

--19
SELECT 
	DATEPART(MM , T.OrderDate) Month,
	COUNT(T.OrderID) TotalOrders ,
	SUM(T.Quantity * T.Price) TotalRevenue
FROM (SELECT 
	P.Price,
	O.OrderDate,
	O.Quantity,
	O.OrderID
	FROM Orders O 
	INNER JOIN Products P 
	ON O.ProductID = P.ProductID
	WHERE DATEPART(YY , O.OrderDate) = 2024)T
GROUP BY DATEPART(MM , T.OrderDate)

--20
SELECT
	T.Category,
	T.ProductName,
	T.TotalQuantitySold
FROM(SELECT 
	P.Category,
	P.ProductName,
	SUM(O.Quantity) TotalQuantitySold,
	RANK() OVER(PARTITION BY P.Category ORDER BY SUM(O.Quantity) DESC ) Rank
FROM Products P 
INNER JOIN Orders O
ON P.ProductID = O.ProductID
GROUP BY 	P.Category, P.ProductName)T
WHERE T.Rank = 1

--21
SELECT
    T.OrderDate,
    T.DailyRevenue,
    SUM(T.DailyRevenue) OVER(ORDER BY T.OrderDate) AS RunningRevenue
FROM
(
    SELECT
        O.OrderDate,
        SUM(O.Quantity * P.Price) AS DailyRevenue
    FROM Orders O
    JOIN Products P
        ON O.ProductID = P.ProductID
    GROUP BY O.OrderDate
) T
ORDER BY T.OrderDate;


--22
SELECT 
	T.CustomerName ,
	T.OrderDate  FirstOrderDate,
	T.TotalOrders
FROM(SELECT 
	C.CustomerID,
	C.CustomerName,
	O.OrderDate,
	O.OrderID,
	ROW_NUMBER() OVER(PARTITION BY C.CustomerID ORDER BY O.OrderDate) Rank_date,
	COUNT(O.OrderID) OVER(PARTITION BY C.CustomerID) TotalOrders
FROM Customers C
INNER JOIN Orders O 
ON C.CustomerID = O.CustomerID)T
WHERE Rank_date = 1

--23 
SELECT
    C.CustomerID,
    C.CustomerName,
    MAX(O.OrderDate) AS LastOrderDate
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CustomerName
HAVING MAX(O.OrderDate) < DATEADD(MONTH, -6, GETDATE());


--24
SELECT
    AVG(OrderValue) AS AverageOrderValue
FROM
(
    SELECT
        O.OrderID,
        SUM(O.Quantity * P.Price) AS OrderValue
    FROM Orders O
    JOIN Products P
        ON O.ProductID = P.ProductID
    GROUP BY O.OrderID
) T;


--25
SELECT DISTINCT
    T.CustomerName,
    T.TotalSpent,
    T.Rnk
FROM (
    SELECT 
        C.CustomerName,
        SUM(P.Price * O.Quantity) OVER(PARTITION BY C.CustomerID) TotalSpent,
        DENSE_RANK() OVER(ORDER BY SUM(P.Price * O.Quantity) OVER(PARTITION BY C.CustomerID) DESC) Rnk
    FROM Customers C
    INNER JOIN Orders O ON C.CustomerID = O.CustomerID
    INNER JOIN Products P ON O.ProductID = P.ProductID
) T
WHERE T.Rnk <= 3;

--26
SELECT
    P.ProductName,
    SUM(O.Quantity * P.Price) AS ProductRevenue,
    100.0 * SUM(O.Quantity * P.Price) 
        / SUM(SUM(O.Quantity * P.Price)) OVER() AS RevenuePercent
FROM Products P
JOIN Orders O
    ON P.ProductID = O.ProductID
GROUP BY P.ProductName;

--27
SELECT TOP 1
    DATEPART(YEAR,O.OrderDate) AS Year,
    DATEPART(MONTH,O.OrderDate) AS Month,
    SUM(O.Quantity * P.Price) AS TotalRevenue
FROM Orders O
JOIN Products P ON O.ProductID = P.ProductID
GROUP BY
    DATEPART(YEAR,O.OrderDate),
    DATEPART(MONTH,O.OrderDate)
ORDER BY TotalRevenue DESC;


--28
SELECT 
    C.CustomerName,
    SUM(P.Price * O.Quantity) AS TotalSpent,
    CASE
        WHEN SUM(P.Price * O.Quantity) > 5000 THEN 'VIP'
        WHEN SUM(P.Price * O.Quantity) BETWEEN 1000 AND 5000 THEN 'Regular'
        ELSE 'New'
    END AS Segment
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
INNER JOIN Products P ON O.ProductID = P.ProductID
GROUP BY C.CustomerID, C.CustomerName;

--29
SELECT 
	T.CustomerName,
	T.OrderDate,
	T.PreviousOrderDate,
	DATEDIFF(DD,T.PreviousOrderDate ,T.OrderDate) DaysBetweenOrders
FROM(SELECT 
	C.CustomerName,
	O.OrderDate,
	LAG(O.OrderDate) OVER(PARTITION BY C.CustomerID ORDER BY O.OrderDate) PreviousOrderDate
FROM Customers C
INNER JOIN Orders O
ON C.CustomerID = O.CustomerID)T

--30
SELECT
    CustomerName,
    ProductName,
    TotalQuantity
FROM(
SELECT
    C.CustomerName,
    P.ProductName,
    SUM(O.Quantity) TotalQuantity,
    ROW_NUMBER() OVER(
            PARTITION BY C.CustomerID
            ORDER BY SUM(O.Quantity) DESC
    ) rn
    FROM Customers C
    JOIN Orders O ON C.CustomerID = O.CustomerID
    JOIN Products P ON O.ProductID = P.ProductID
    GROUP BY
        C.CustomerID,
        C.CustomerName,
        P.ProductName)T
WHERE rn = 1;
