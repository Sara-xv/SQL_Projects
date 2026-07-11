-- Case

/*1:For each product display:

ProductName
Price
PriceLevel

Rules:

Price >= 50000 ? Expensive
Price >= 20000 ? Medium
Otherwise ? Cheap
*/

SELECT
	P.ProductName,
	P.Price,
	CASE 
		WHEN P.Price >= 50000 THEN 'Expensive'
		WHEN P.Price >= 20000 THEN 'Medium'
		ELSE 'Cheap'
	END PriceLevel
FROM Products P

/* 2:Display:

Full Name
Salary
SalaryLevel

Salary >= 5000 ? High
Salary >= 3000 ? Medium
Otherwise ? Low
*/
SELECT
	CONCAT_WS(' ',E.FirstName , E.LastName) FullName,
	E.Salary,
	CASE 
		WHEN E.Salary >= 5000 THEN 'High'
		WHEN E.Salary >= 3000 THEN 'Medium'
		ELSE 'Low'
	END SalaryLevel
FROM Employees E

/* 3:Display:

PaymentMethod
PaymentCategory
Cash ? Offline
Card ? Electronic
Transfer ? Bank Transfer
Otherwise ? Other
*/
SELECT
	P.PaymentMethod,
	CASE 
		WHEN P.PaymentMethod = 'Cash' THEN 'Offline'
		WHEN P.PaymentMethod = 'Card' THEN 'Electronic'
		WHEN P.PaymentMethod = 'Transfer' THEN 'Bank Transfer'
		ELSE 'Other'
	END PaymentCategory
FROM Payments P

/*
4:Display for each product:

ProductName
Price
Stock
ProductStatus

Rules:
If Price > 50,000 AND Stock > 20 ? Premium
If Price > 50,000 AND Stock <= 20 ? Limited Premium
If Price <= 50,000 AND Stock > 20 ? Standard
Otherwise ? Budget

*/
SELECT
	P.ProductName,
	P.Price,
	P.Stock,
	CASE 
		WHEN P.Price > 50000 AND P.Stock > 20 THEN 'Premium'
		WHEN P.Price > 50000 AND P.Stock <= 20 THEN 'Limited Premium'
		WHEN P.Price <= 50000 AND P.Stock > 20 THEN 'Standard'
		ELSE 'Budget'
	END ProductStatus
FROM Products P

/*
5: Prepare a report that displays the following columns for each order:

- OrderID
- Customer Name
- Order Date
- Total Amount
- Month Name
- Season
- Order Size
- Discount
- Payment Category

**Order Size:**
- If Total Amount >= 50,000 ? Large
- If Total Amount >= 20,000 ? Medium
- Otherwise ? Small

**Discount:**
- If Total Amount >= 50,000 ? 20%
- If Total Amount >= 30,000 ? 10%
- If Total Amount >= 10,000 ? 5%
- Otherwise ? 0%

**Payment Category:**
- Cash ? Offline
- Card ? Electronic
- Transfer ? Bank Transfer
- Otherwise ? Other
*/
SELECT 
	O.OrderID,
	CONCAT_WS(' ', C.LastName , C.LastName) CustomerName,
	O.OrderDate,
	O.TotalAmount,
	DATENAME(MONTH, O.OrderDate) [Month Name],
	CASE 
        WHEN DATEPART(QUARTER, O.OrderDate) = 1 THEN 'Spring'
        WHEN DATEPART(QUARTER, O.OrderDate) = 2 THEN 'Summer'
        WHEN DATEPART(QUARTER, O.OrderDate) = 3 THEN 'Autumn'
        ELSE 'Winter'
    END Season,
	CASE 
		WHEN O.TotalAmount >= 50000 THEN 'Large'
		WHEN O.TotalAmount >= 20000 THEN 'Medium' 
		ELSE 'Small'
	END [Order Size],
	CASE 
		WHEN O.TotalAmount >= 50000 THEN '20%'
		WHEN O.TotalAmount >= 30000 THEN '10%'
		WHEN O.TotalAmount >= 10000 THEN '5%'
		ELSE '0%'
	END Discount,
	CASE 
		WHEN P.PaymentMethod = 'Cash' THEN 'Offline'
		WHEN P.PaymentMethod = 'Card' THEN 'Electronic'
		WHEN P.PaymentMethod = 'Transfer' THEN 'Bank Transfer'
		ELSE 'Other'
	END PaymentCategory
FROM Customers C
INNER JOIN Orders O
ON C.CustomerID = O.CustomerID
INNER JOIN Payments P
ON O.OrderID = P.OrderID
 
