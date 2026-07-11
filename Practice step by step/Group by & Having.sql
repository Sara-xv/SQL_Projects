-- Group by & Having 
-- 1:Display the number of customers in each city.
SELECT
	C.City,
	COUNT(C.CustomerID) [The Number Of Customers]
FROM Customers C
GROUP BY C.City

-- 2:Display the average salary of employees in each department.
SELECT
	E.Department,
	AVG(E.Salary) [The Average Of Salary]
FROM Employees E
GROUP BY E.Department

-- 3:Display the highest product price in each category.
SELECT
	P.CategoryID,
	MAX(P.Price) [The Highest Product Price]
FROM Products P
GROUP BY P.CategoryID

-- 4:Display the total order amount for each customer.
   --(Use the Orders table.)
SELECT
	O.CustomerID,
	SUM(O.TotalAmount) [Total Amount Per Customer]
FROM Orders O
GROUP BY O.CustomerID

-- 5:Display the number of orders handled by each employee.
SELECT 
	O.EmployeeID,
	COUNT(O.OrderID) [Orders Hnadled]
FROM Orders O
GROUP BY O.EmployeeID

-- 6:Display the average product price for each supplier.
SELECT 
	P.SupplierID,
	AVG(P.Price) [AVG Produnct Price]
FROM Products P
GROUP BY P.SupplierID

-- 7:Display cities that have more than 3 customers.
SELECT 
	C.City,
	COUNT(C.CustomerID) TotalCustomers
FROM Customers C
GROUP BY C.City
HAVING COUNT(C.CustomerID)  > 3

-- 8:Display departments whose average employee salary is greater than 3000.
SELECT  
	E.Department,
	AVG(E.Salary) [AVG Salary]
FROM Employees E
GROUP BY E.Department
HAVING AVG(E.Salary) > 3000

-- 9:Display payment methods that have more than 5 transactions.
SELECT 
	P.PaymentMethod,
	COUNT(*) Total
FROM Payments P
GROUP BY P.PaymentMethod
HAVING COUNT(P.OrderID) > 5

-- 10:Display suppliers whose average product price is between 20000 and 40000.
SELECT
	P.SupplierID,
	AVG(P.Price) [AVG Price]
FROM Products P
GROUP BY P.SupplierID
HAVING AVG(P.Price) BETWEEN 20000 AND 40000

-- 11:
/*
	For each customer, display:

	Customer ID
	Number of orders
	Total order amount
	Average order amount

	Then return only customers who:

	Have placed at least 3 orders.
	And whose total order amount is greater than 60000.
*/
SELECT
    O.CustomerID,
    COUNT(O.OrderID) AS TotalOrders,
    SUM(O.TotalAmount) AS TotalAmount,
    AVG(O.TotalAmount) AS AverageOrderAmount
FROM Orders O
GROUP BY O.CustomerID
HAVING COUNT(O.OrderID) >= 3
   AND SUM(O.TotalAmount) > 60000;
