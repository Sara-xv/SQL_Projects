-- Join 

/*
1:Display all orders with the customer's full name.

Show:

OrderID
OrderDate
Customer Full Name
TotalAmount

Sort by OrderDate descending.
*/

SELECT 
	O.OrderID,
	O.OrderDate,
	C.FirstName + ' ' + C.LastName FullName,
	O.TotalAmount
FROM Orders O
INNER JOIN Customers C
ON O.CustomerID = C.CustomerID

/*
2:Display all orders.

Show:

OrderID
Customer Name
Employee Name
TotalAmount

Sort by TotalAmount descending.
*/
SELECT
	O.OrderID,
	C.FirstName + ' ' + C.LastName CustomerName,
	E.FirstName + ' ' + E.LastName EmployeeName,
	o.TotalAmount
FROM Orders O 
LEFT JOIN Customers C
ON O.CustomerID = C.CustomerID
LEFT JOIN Employees E
ON O.EmployeeID = E.EmployeeID

/*
3:For each customer display:

Customer Name
Number of Orders
Total Purchases

Only customers with more than 2 orders.

Sort by total purchases descending.
*/
SELECT
	C.CustomerID,
	C.FirstName + ' ' + C.LastName CustomerName,
	COUNT(*)[Number of Orders],
	SUM(O.TotalAmount)[Total Purchases]
FROM Customers C
INNER JOIN Orders O 
ON C.CustomerID = O.CustomerID
GROUP BY
C.CustomerID,
C.FirstName,
C.LastName
HAVING COUNT(*) > 2
ORDER BY [Total Purchases] DESC


/*
4:For each supplier display:

Supplier Name
Number of Products
Average Price
Maximum Price
Minimum Price

Only suppliers that:

Have more than 2 products
Have an average product price greater than 25000

Sort by average price descending.
*/
SELECT
	S.SupplierName,
	COUNT(*)[Number of Products],
	AVG(P.Price)[Average Price],
	MAX(P.Price)[Maximum Price],
	MIN(P.Price)[Minimum Price]
FROM Suppliers S
LEFT JOIN Products P
ON S.SupplierID = P.SupplierID
GROUP BY S.SupplierName
HAVING COUNT(*) > 2 AND
	   AVG(P.Price) > 25000
ORDER BY [Average Price] DESC

/*
5:For each order display:

OrderID
Customer Full Name
Employee Full Name
Payment Method
Payment Date
Total Amount

Sort by TotalAmount descending.
*/
SELECT
	O.OrderID,
	C.FirstName + ' ' + C.LastName CustomerName,
	E.FirstName + ' ' + E.LastName EmployeeName,
	P.PaymentMethod,
	P.PaymentDate,
	O.TotalAmount
FROM Customers C
INNER JOIN Orders  O
ON C.CustomerID = O.CustomerID
INNER JOIN Payments P
ON O.OrderID = P.OrderID
INNER JOIN Employees E
ON O.EmployeeID = E.EmployeeID
ORDER BY O.TotalAmount DESC