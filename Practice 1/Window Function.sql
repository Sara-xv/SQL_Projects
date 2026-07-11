-- Window Functions

/*
1:Display:

ProductID
ProductName
Price
Row Number based on Price DESC
*/
SELECT
	P.ProductID,
	P.ProductName,
	P.Price,
	ROW_NUMBER() OVER(ORDER BY P.Price DESC) 
FROM Products P


/*2:Number the products.

Each category should have its own numbering (separate sequence per category)
*/
SELECT
	C.CategoryName,
	P.ProductName,
	ROW_NUMBER() OVER(PARTITION BY C.CategoryName ORDER BY P.Price)
FROM Products P
INNER JOIN Categories C
ON P.CategoryID = C.CategoryID

/*
3:Display:
ProductName
Price
Rank

If two products have the same price, they should receive the same rank.
*/
SELECT
	P.ProductName,
	P.Price,
	RANK() OVER(ORDER BY P.Price) Rank
FROM Products P
-- Without leaves a gap
SELECT
	P.ProductName,
	P.Price,
	DENSE_RANK() OVER(ORDER BY P.Price) Rank
FROM Products P

/*
4:Divide all products into four groups.

Display:

ProductName
Price
Quartile
*/
SELECT
	P.ProductName,
	P.Price,
	NTILE(4) OVER(ORDER BY P.Price) Quartile
FROM Products P

/*
5:For each order, display:

OrderID
CustomerID
OrderDate
TotalAmount
Customer's total purchase amount up to that order (cumulative sum per customer)
*/
SELECT
	O.OrderID,
	O.CustomerID,
	O.OrderDate,
	O.TotalAmount,
	SUM(O.TotalAmount) OVER(PARTITION BY O.CustomerID ORDER BY O.OrderDate, O.OrderID ASC) CumulativeSum
FROM Orders O

/*
6:For each order, display:

OrderID
CustomerID
OrderDate
TotalAmount
Customer's average purchase amount up to that order (cumulative average per customer)
*/
SELECT
	O.OrderID,
	O.CustomerID,
	O.OrderDate,
	O.TotalAmount,
	AVG(O.TotalAmount) OVER(PARTITION BY O.CustomerID ORDER BY O.OrderDate, O.OrderID ASC) CumulativeAverage
FROM Orders O

/*
7:For each order, display:

OrderID
CustomerID
TotalAmount
Company's total overall sales (grand total of all orders)
*/
SELECT
	O.OrderID,
	O.CustomerID,
	O.TotalAmount,
	SUM(O.TotalAmount) OVER() [Overall Sales]
FROM Orders O 

/*
8:For each order, display:

OrderID
CustomerID
TotalAmount
Percentage of this order out of total sales
*/
SELECT
	O.OrderID,
	O.CustomerID,
	O.TotalAmount,
	((O.TotalAmount / SUM(O.TotalAmount) OVER()) *  100) [Percentage Of Total Sales]
FROM Orders O

/*
9:For each order, display:

OrderID
CustomerID
OrderDate
TotalAmount
The previous order amount of the same customer
*/
SELECT
	O.OrderID,
	O.CustomerID,
	O.OrderDate,
	O.TotalAmount,
	LAG(O.TotalAmount) OVER(PARTITION BY O.CustomerID ORDER BY O.OrderDate) [Previous Amount]
FROM Orders O

/*
10:For each order, display:

OrderID
CustomerID
OrderDate
TotalAmount
The next order amount of the same customer
*/
SELECT
	O.OrderID,
	O.CustomerID,
	O.OrderDate,
	O.TotalAmount,
	LEAD(O.TotalAmount) OVER(PARTITION BY O.CustomerID ORDER BY O.OrderDate) [Next Amount]
FROM Orders O

/*
11:For each order, display:

OrderID
CustomerID
OrderDate
TotalAmount
Difference in amount from the previous order
*/
SELECT
	O.OrderID,
	O.CustomerID,
	O.OrderDate,
	O.TotalAmount,
	LAG(O.TotalAmount) OVER(PARTITION BY O.CustomerID ORDER BY O.OrderDate) [Previous Amount],
	O.TotalAmount - LAG(O.TotalAmount) OVER(PARTITION BY O.CustomerID ORDER BY O.OrderDate)
FROM Orders O

/*
12:For each customer, display:

First order
Last order
*/
SELECT
	O.CustomerID,
	FIRST_VALUE(O.OrderID) OVER(PARTITION BY O.CustomerID ORDER BY O.OrderID) FirstOrder,
	LAST_VALUE(O.OrderID) OVER(PARTITION BY O.CustomerID ORDER BY O.OrderID
					  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) LastOrder
FROM Orders O

/*
13:For each product, display:

ProductName
Price
Difference from Category Average
*/
SELECT
	P.ProductName,
	P.Price,
	P.Price - AVG(P.Price) OVER(PARTITION BY P.CategoryID) [Difference From Category Avg]
FROM Products P

/*
14:
For each category, display:

ProductName
Price
The most expensive product in that category
*/
SELECT
	P.ProductName,
	P.Price,
	MAX(P.Price) OVER(PARTITION BY P.CategoryID) [Most Expensive In Category]
FROM Products P

/*
Report:
Customer Name
Order Date
Total Amount
Row Number
Rank
Dense Rank
Running Total
Running Average
Previous Order Amount
Next Order Amount
Customer Total Purchase
Customer Average Purchase
Percentage of Total Sales
*/
SELECT
    CONCAT_WS(' ', C.FirstName, C.LastName)  FullName,
    O.OrderDate,
    O.TotalAmount,
    ROW_NUMBER() OVER(ORDER BY O.OrderDate, O.OrderID)  [Row Number],  
    RANK() OVER(ORDER BY O.OrderDate, O.OrderID)  Rank,                
    DENSE_RANK() OVER(ORDER BY O.OrderDate, O.OrderID)  [Dense Rank],  
    SUM(O.TotalAmount) OVER(ORDER BY O.OrderDate, O.OrderID) [Running Total],
    AVG(O.TotalAmount) OVER(ORDER BY O.OrderDate, O.OrderID)  [Running Average],
    LAG(O.TotalAmount) OVER(PARTITION BY C.CustomerID ORDER BY O.OrderDate)  [Previous Amount], 
    LEAD(O.TotalAmount) OVER(PARTITION BY C.CustomerID ORDER BY O.OrderDate)  [Next Amount], 
    SUM(O.TotalAmount) OVER(PARTITION BY C.CustomerID)  [Customer Total Purchase],
    AVG(O.TotalAmount) OVER(PARTITION BY C.CustomerID)  [Customer Average Purchase],
    ((O.TotalAmount / SUM(O.TotalAmount) OVER()) * 100)  [Percentage Of Total Sales]
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID

 