-- Report 

SELECT
	O.OrderID,
	C.FirstName + ' ' + C.LastName CustomerName,
	E.FirstName + ' ' + E.LastName EmployeeName,
	PR.ProductName,
	CA.CategoryName,
	S.SupplierName,
	OI.Quantity,
    OI.UnitPrice,
	O.TotalAmount,
	P.PaymentMethod,
	O.OrderDate
FROM Orders O 
INNER JOIN Customers C
ON O.CustomerID = C.CustomerID
INNER JOIN Payments P
ON O.OrderID = P.OrderID
INNER JOIN Employees E
ON O.EmployeeID = E.EmployeeID
INNER JOIN OrderItems OI
ON O.OrderID = OI.OrderID
INNER JOIN Products PR
ON OI.ProductID = PR.ProductID
INNER JOIN Suppliers S
ON PR.SupplierID = S.SupplierID
INNER JOIN Categories CA
ON PR.CategoryID = CA.CategoryID
