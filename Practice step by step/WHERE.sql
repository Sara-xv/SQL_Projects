-- WHERE 
-- 1:Display all products whose price is greater than 40000.
SELECT 
	P.ProductID,
	P.ProductName,
	P.Price
FROM Products P
WHERE P.Price > 40000

-- 2:Display all customers who live in Tehran.
SELECT 
	C.CustomerID,
	C.FirstName,
	C.LastName,
	C.City
FROM Customers C
WHERE C.City = 'Tehran'

-- 3:Display all employees whose salary is less than 2000.
SELECT 
	E.EmployeeID,
	E.LastName,
	E.Salary
FROM Employees E
WHERE E.Salary  < 2000

-- 4:Display all orders whose total amount is greater than 30000.
SELECT 
	O.OrderID,
	O.OrderDate,
	O.TotalAmount
FROM Orders O
WHERE O.TotalAmount > 30000

-- 5:Display all products whose stock is less than 15.
SELECT
	P.ProductID,
	P.ProductName,
	P.Stock
FROM Products P
WHERE P.Stock < 15

-- 6:Display all suppliers located in Shiraz.
SELECT 
	S.SupplierID,
	S.SupplierName,
	S.City
FROM Suppliers S
WHERE S.City = 'Shiraz'

-- 7:Display all orders placed after 2024-02-01.
SELECT 
	O.OrderID,
	O.OrderDate
FROM Orders O
WHERE O.OrderDate > '2024-02-01'

-- 8:Display all payments whose payment method is Cash.
SELECT
	P.PaymentID,
	P.PaymentDate,
	P.PaymentMethod
FROM Payments P
WHERE P.PaymentMethod  = 'Cash'

-- 9:Display all products where:
   --Price is greater than 30000
   --AND stock is less than 20
SELECT
	P.ProductID,
	P.ProductName,
	P.Price,
	P.Stock
FROM Products P
WHERE (P.Price > 30000) AND (P.Stock < 20)

-- 10:Display all customers who live in one of the following cities:
   -- Tehran , Shiraz , Mashhad
SELECT 
	C.CustomerID,
	C.FirstName,
	C.LastName,
	C.City
FROM Customers C
WHERE C.City IN ('Mashhad' , 'Shiraz' , 'Tehran')

-- 11:Display all orders whose total amount is between 10000 and 30000.
SELECT
	O.OrderID,
	O.TotalAmount
FROM Orders O
WHERE O.TotalAmount BETWEEN 10000 AND 30000

-- 12:Display all products whose names start with Samsung.
SELECT
	P.ProductID,
	P.ProductName
FROM Products P
WHERE P.ProductName LIKE 'Samsung%'

-- 13:Display all customers whose first name starts with the letter M.
SELECT 
	C.CustomerID,
	C.FirstName,
	C.LastName
FROM Customers C
WHERE C.FirstName LIKE 'M%'

-- 14:Display all orders whose total amount is less than 5000 OR greater than 40000.
SELECT
O.OrderID,
O.TotalAmount
FROM Orders O
WHERE (O.TotalAmount < 5000) OR (O.TotalAmount > 40000)

-- 15:Display all products that:
    --Have a price between 10000 and 40000
	--Have stock greater than 15
	--And contain the word Galaxy in the product name.
SELECT
	P.ProductID,
	P.ProductName,
	P.Stock,
	P.Price
FROM Products P
WHERE P.Price BETWEEN 10000 AND 40000 AND 
	  P.Stock > 15 AND 
	  P.ProductName LIKE '%Galaxy%'