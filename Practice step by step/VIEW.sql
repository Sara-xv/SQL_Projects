/*
1:Create a view named:

vw_AllProducts

Display:

ProductID
ProductName
Price
Stock
*/
CREATE VIEW vw_AllProducts AS
SELECT 
	P.ProductID,
	P.ProductName,
	P.Price,
	P.Stock
FROM Products P;

/*
2:Create a View called vw_ExpensiveProducts.

Only display products where:
Price > 40,000
*/
CREATE VIEW vw_ExpensiveProducts AS
SELECT
	P.ProductID,
	P.ProductName,
	P.Price
FROM Products P
WHERE P.Price > 40000;

/*
3:Create a View.

For each customer, display:

CustomerID
Number Of Orders
Total Purchase
*/
CREATE VIEW vw_customerorders AS
SELECT
	O.CustomerID,
	COUNT(*) [Number Of Orders],
	SUM(O.TotalAmount) [Total Purchase]
FROM Orders O;

/*
4:Create a View.

For each Product, display:

ProductName
Price
Price Level

Rules:

If Price >= 50,000 ? Premium
If Price >= 20,000 ? Standard
Otherwise ? Budget
*/
CREATE VIEW vw_ProductPriceLevel AS
SELECT 
    P.ProductName,
    P.Price,
    CASE 
        WHEN P.Price >= 50000 THEN 'Premium'
        WHEN P.Price >= 20000 THEN 'Standard'
        ELSE 'Budget'
    END AS PriceLevel
FROM Products P;

/*
6:Create a View.

Display:

Product Name
Category Average Price
Difference From Average
*/
CREATE VIEW vw_ProductCategoryDiff AS
SELECT
    P.ProductName,
    P.Price,
    AVG(P.Price) OVER(PARTITION BY P.CategoryID) AS [Category Average Price],
    P.Price - AVG(P.Price) OVER(PARTITION BY P.CategoryID) AS [Difference From Average]
FROM Products P;

/*
7:
Customer Name
Employee Name
Product Name
Category
Supplier
Order Date
Payment Method
Total Amount
*/
CREATE VIEW vw_ManagementReport AS
SELECT
    CONCAT_WS(' ', C.FirstName, C.LastName) AS [Customer Name],
    CONCAT_WS(' ', E.FirstName, E.LastName) AS [Employee Name],
    P.ProductName AS [Product Name],
    Cat.CategoryName AS [Category],
    S.SupplierName AS [Supplier],
    O.OrderDate AS [Order Date],
    Pay.PaymentMethod AS [Payment Method],
    O.TotalAmount AS [Total Amount]
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID
INNER JOIN Employees E ON O.EmployeeID = E.EmployeeID
INNER JOIN Payments Pay ON O.OrderID = Pay.OrderID
INNER JOIN OrderItems OI ON O.OrderID = OI.OrderID
INNER JOIN Products P ON  OI.ProductID = P.ProductID
INNER JOIN Suppliers S ON P.SupplierID= S.SupplierID
INNER JOIN Categories Cat ON P.CategoryID = Cat.CategoryID;

/*
8:Modify the following View:

vw_AllProducts

So that the column:

Category Name
is also added.
*/

ALTER VIEW vw_AllProducts AS
SELECT
    P.ProductID,
    P.ProductName,
    P.Price,
    P.Stock,
    C.CategoryName AS [Category Name] 
FROM Products P
INNER JOIN Categories C ON P.CategoryID = C.CategoryID;