-- Set operator

-- 1:Display a combined list of all customers and employees full names without duplicates.
SELECT
    FirstName + ' ' + LastName FullName
FROM Customers
UNION
SELECT
    FirstName + ' ' + LastName
FROM Employees

-- 2:Display all unique cities where either customers or suppliers exist.
SELECT 
	C.City
FROM Customers C
UNION 
SELECT 
	S.City
FROM Suppliers S

-- 3:Display all people (customers + employees) with a column indicating their type.
SELECT
    FirstName + ' ' + LastName  Name,
    'Customer'  PersonType
FROM Customers
UNION
SELECT
    FirstName + ' ' + LastName,
    'Employee'
FROM Employees

-- 4:Display cities that have both customers and suppliers.
SELECT 
	C.City
FROM Customers C
INTERSECT 
SELECT 
	S.City
FROM Suppliers S

-- 5:Display products that have never been ordered.
SELECT
	O.ProductID
FROM OrderItems O
EXCEPT
SELECT
	P.ProductID
FROM Products P

/*
6:Display all customers and suppliers in a single list:

Columns:

Name
Type (Customer / Supplier)
City

Sort by name.
*/
SELECT
    FirstName + ' ' + LastName  Name,
    'Customer' Type,
    City
FROM Customers
UNION
SELECT
    SupplierName,
    'Supplier',
    City
FROM Suppliers

ORDER BY Name

 