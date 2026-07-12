-- Subquery

/*
1:Display:

ProductName
Price
Average Price of All Products

Use a scalar subquery.
*/
SELECT
	P.ProductName,
	P.Price,
	(SELECT AVG(P.Price) FROM Products P) [AVG Price]
FROM Products P

/*
2:Display all products whose price is greater than the average price of all products.

ProductName
Price
*/
SELECT
	P.ProductName,
	P.Price
FROM Products P
WHERE P.Price > (SELECT AVG(P.Price) FROM Products P)

-- 3:Display all customers who have placed at least one order.
SELECT
	C.CustomerID,
	CONCAT_WS(' ', C.FirstName , C.LastName) FullName,
	C.City
FROM Customers C
WHERE C.CustomerID IN (SELECT O.CustomerID FROM Orders O)

-- 4:Display all customers who have not placed any orders.
SELECT
	C.CustomerID,
	CONCAT_WS(' ', C.FirstName , C.LastName) FullName,
	C.City
FROM Customers C
WHERE C.CustomerID NOT IN (SELECT O.CustomerID FROM Orders O WHERE O.CustomerID IS NOT NULL)

-- 5:Display all products that are supplied by a supplier from the city of Tehran.
SELECT
    P.ProductID,
    P.ProductName,
    P.Price
FROM Products P
WHERE P.SupplierID IN(SELECT S.SupplierID FROM Suppliers S WHERE S.City='Tehran')

-- 6: Display all orders that have been placed by customers from the city of Shiraz.
SELECT
	O.OrderID,
	O.OrderDate
FROM Orders O
WHERE O.CustomerID IN (SELECT C.CustomerID FROM Customers C WHERE C.City = 'Shiraz')

/*
7:For each product, display:

ProductName
Price
Only show products whose price is greater than the average price of their own category.
*/
 
SELECT
	I.ProductName,
	I.Price
FROM(SELECT
	P.ProductName,
	P.Price,
	P.CategoryID,
	AVG(P.Price) OVER(PARTITION BY P.CategoryID) [AVG Category]
FROM Products P)I
WHERE I.Price > I.[AVG Category]


/*
8:For each employee, display:

Full Name
Salary
Only show employees whose salary is greater than the average salary of their own department.
*/
SELECT
	I.FullName,
	I.Salary
FROM(SELECT
	CONCAT_WS(' ',E.FirstName,E.LastName) FullName,
	E.Salary,
	AVG(E.Salary) OVER(PARTITION BY E.Department) [AVG Department]
FROM Employees E)I
WHERE I.Salary > I.[AVG Department]

/*
9:For each customer, display:

Customer Name
Number Of Orders
Total Amount
Use a Subquery inside SELECT.
*/
SELECT
	CONCAT_WS(' ',C.FirstName,C.LastName) FullName,
	(SELECT COUNT(*) FROM Orders O  WHERE C.CustomerID = O.CustomerID) [Number Of Orders],
	(SELECT SUM(O.TotalAmount) FROM Orders O  WHERE C.CustomerID = O.CustomerID) [Total Amount]
FROM Customers C

-- OR
SELECT
	I.FullName,
	COUNT(*) [Number Of Orders],
	SUM(I.TotalAmount) [Total Amount]
FROM(SELECT
	CONCAT_WS(' ',C.FirstName,C.LastName) FullName,
	O.OrderID,
	O.TotalAmount
FROM Customers C
INNER JOIN Orders O
ON C.CustomerID = O.CustomerID)I
GROUP BY I.FullName

-- 10:Display all products whose price is greater than at least one of the products in Category number 2.
SELECT
	P.ProductName,
	P.Price
FROM Products P
WHERE P.Price > ANY (SELECT P.Price FROM Products P WHERE P.CategoryID = 2)

-- 11:Display all products whose price is greater than all products in Category number 2.
SELECT
	P.ProductName,
	P.Price
FROM Products P
WHERE P.Price > ALL (SELECT P.Price FROM Products P WHERE P.CategoryID = 2)

/*
Prepare a complete report.

Display:
Customer Name
Number Of Orders
Total Amount
Average Amount
Biggest Order
Smallest Order
Last Order Date
First Order Date

Constraints:
Do NOT use JOIN (except for the initial connection to the Customers table if needed).
Do NOT use GROUP BY.
Do NOT use Window Functions.
All values must be calculated using Subqueries.
*/
SELECT
	CONCAT_WS(' ',C.FirstName,C.LastName) FullName,
	(SELECT COUNT(*) FROM Orders O  WHERE C.CustomerID = O.CustomerID) [Number Of Orders],
	(SELECT SUM(O.TotalAmount) FROM Orders O WHERE C.CustomerID = O.CustomerID) [Total Amount],
	(SELECT AVG(O.TotalAmount) FROM Orders O WHERE C.CustomerID = O.CustomerID) [Average Amount],
	(SELECT MAX(O.TotalAmount) FROM Orders O WHERE C.CustomerID = O.CustomerID) [Biggest Order],
	(SELECT MIN(O.TotalAmount) FROM Orders O WHERE C.CustomerID = O.CustomerID) [Smallest Order],
	(SELECT TOP 1 O.OrderDate FROM Orders O WHERE C.CustomerID = O.CustomerID ORDER BY O.OrderDate DESC) [Last Order Date],
	(SELECT TOP 1  O.OrderDate FROM Orders O WHERE C.CustomerID = O.CustomerID ORDER BY O.OrderDate ASC)  [First Order Date]
FROM Customers C
 