-- SELECT Quary

/*
1:
Display the top 5 most expensive products.

Output:

ProductID
ProductName
Price

Sort them from highest to lowest price
*/
SELECT TOP 5
	P.ProductID,
	P.ProductName,
	P.Price
FROM Products P
ORDER BY P.Price DESC

-- 2:Display all cities that have customers, without duplicates.
SELECT DISTINCT
	 C.City
FROM Customers C

/*
3:Display all orders whose:

Total amount is between 10000 and 30000
Order date is after 2024-02-01

Sort by total amount in descending order.
*/
SELECT 
	O.OrderID,
	O.OrderDate,
	O.TotalAmount
FROM Orders O
WHERE (O.TotalAmount BETWEEN 10000 AND 30000) AND
	  (O.OrderDate > '2024-02-01')
ORDER BY O.TotalAmount DESC

/*
4:For each department display:

Average salary
Maximum salary
Minimum salary

Sort by average salary descending.
*/

SELECT 
	E.Department,
	MIN(E.Salary) [Minimum Salary],
	AVG(E.Salary) [Average Salary],
	MAX(E.Salary) [Maximum Salary]
FROM Employees E 
GROUP BY E.Department
ORDER BY AVG(E.Salary) DESC

/*
5:Display the top 10 orders with the highest total amount.

Only include orders whose total amount is greater than 15000.
*/
SELECT TOP 10
    O.OrderID,
	O.TotalAmount
FROM Orders O
WHERE O.TotalAmount > 15000
ORDER BY O.TotalAmount DESC

/*
6:For each payment method display:

Number of transactions
Total payment amount
Average payment amount

Only include methods that:

Have more than 3 transactions.
Have an average payment amount greater than 10000.

Sort by total payment amount descending.
*/

SELECT 
	P.PaymentMethod,
	COUNT(*) [Number of transactions],
	SUM(P.Amount)[Total payment amount],
	AVG(P.Amount)[Average payment amount]
FROM Payments P
GROUP BY P.PaymentMethod
HAVING COUNT(*) > 3 AND
	   AVG(P.Amount) > 10000
ORDER BY SUM(P.Amount) DESC

/*
7:For each customer display:

Customer ID
Number of orders
Total order amount
Average order amount
Highest order amount

Only include customers who:

Have placed at least 2 orders.
Have a total purchase amount between 30000 and 90000.
Have an average purchase amount greater than 15000.

Sort by total purchase amount descending.
*/

SELECT
	O.CustomerID,
	COUNT(*)[Number of orders],
	SUM(O.TotalAmount)[Total order amount],
	AVG(O.TotalAmount)[Average order amount],
	MAX(O.TotalAmount)[Highest order amount]
FROM Orders O
GROUP BY O.CustomerID
HAVING (COUNT(*) >= 2) AND
	   (SUM(O.TotalAmount) BETWEEN 30000 AND 90000) AND
	   (AVG(O.TotalAmount) > 15000) 
ORDER BY [Total order amount] DESC


/* 8:From the Products table:

Display only the top 5 products.
Price must be between 10000 and 50000.
Stock must be greater than 10.
Product name must contain the letter a.
Sort by price descending.

Display only:

ProductID
ProductName
Price
Stock
*/
SELECT TOP 5
	P.ProductID,
	P.ProductName,
	P.Price,
	P.Stock
FROM Products P
WHERE (P.Price BETWEEN 10000 AND 50000) AND 
	  (P.Stock > 10) AND
	  (P.ProductName LIKE '%a%') 
ORDER BY P.Price DESC