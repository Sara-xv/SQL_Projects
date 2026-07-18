-- CTAS (IN SQL SERVER = SELECT INTO)

/*
Create a new table called:

Products_Backup

Copy all data from the Products table into it.
*/
SELECT *
INTO Products_Backup
FROM Products P

/*
Create a new table:

Expensive_Products

Store only products where:

Price > 50000

Display:

ProductID
ProductName
Price
Stock
*/
SELECT
	P.ProductID,
	P.ProductName,
	P.Price,
	P.Stock
INTO Expensive_Products
FROM Products P
WHERE P.Price > 50000

/*
Create a report table:

Product_Report

using JOIN between:

Products
Categories
Suppliers

Columns:

ProductID
ProductName
CategoryName
SupplierName
Price
*/
SELECT
	P.ProductID,
	P.ProductName,
	C.CategoryName,
	S.SupplierName,
	P.Price
INTO Product_Report
FROM Products P 
INNER JOIN Categories C
ON P.CategoryID = C.CategoryID
INNER JOIN Suppliers S
ON P.SupplierID = S.SupplierID

/*
Create:

Product_Ranking

Store:

ProductName
CategoryID
Price
Category Rank
*/
SELECT
	P.ProductName,
	P.CategoryID,
	P.Price,
	RANK() OVER(PARTITION BY P.CategoryID ORDER BY P.Price) RANK
INTO Product_Ranking
FROM Products P

/*
Create a table:

Sales_Dashboard

for Power BI.

Include:

OrderID
OrderDate
CustomerName
EmployeeName
ProductName
CategoryName
SupplierName
TotalAmount
*/
SELECT
	O.OrderID,
	O.OrderDate,
	CONCAT_WS(' ', C.FirstName,C.LastName) CustomerName,
	CONCAT_WS(' ', E.FirstName,E.LastName) EmployeeName,
	P.ProductName,
	CA.CategoryName,
	S.SupplierName,
	O.TotalAmount
INTO Sales_Dashboard
FROM Orders O
INNER JOIN Customers C
ON O.CustomerID = C.CustomerID
INNER JOIN OrderItems OI
ON O.OrderID = OI.OrderID
INNER JOIN Products P
ON OI.ProductID = P.ProductID
INNER JOIN Suppliers S
ON P.SupplierID = S.SupplierID
INNER JOIN Employees E
ON O.EmployeeID = E.EmployeeID
INNER JOIN Categories CA
ON P.CategoryID = CA.CategoryID
