-- String Function

-- 1:Display the customers' full names in uppercase.
SELECT
	UPPER(C.FirstName) + '  ' + UPPER(C.LastName) FullName
FROM Customers C

-- 2:Display each product name with its character length.
SELECT 
	P.ProductName,
	LEN(P.ProductName) Length
FROM Products P

-- 3:Display the first 3 characters of each product name.
SELECT
	LEFT(P.ProductName,3) [The first 3 characters]
FROM Products P

-- 4:Extract 5 characters from each product name starting at the third character.
SELECT
	SUBSTRING(P.ProductName, 3 ,5)
FROM Products P

-- 5:Display customers' full names using CONCAT() or another.
SELECT
	CONCAT_WS(' ' , C.FirstName,C.LastName)
FROM Customers C

-- 6:Replace Samsung with SAMSUNG in product names.
-- (Output only.)
SELECT
	P.ProductID,
	REPLACE(P.ProductName , 'Samsung', 'SAMSUNG') ProductName
FROM products P

-- 7:Display products whose names contain Galaxy.
-- Use CHARINDEX().
SELECT 
	 P.ProductID,
	 CHARINDEX('Galaxy', ProductName, 0)
FROM Products P
WHERE CHARINDEX('Galaxy', ProductName) > 0
/* 
8:Display the starting position of Pro in each product name.
If not found, display 0. 
*/
SELECT
	P.ProductName,
	CHARINDEX('Pro', P.ProductName) Position
FROM Products P

/*
9:For each customer display:

Full Name
Name Length
Uppercase Name
Reversed Name
*/
SELECT
	CONCAT_WS(' ' , C.FirstName,C.LastName) FullName,
	LEN(CONCAT_WS(' ', FirstName, LastName)) [Name Length],
	UPPER(CONCAT_WS(' ' , C.FirstName,C.LastName)) [Uppercase Name],
	REVERSE(CONCAT_WS(' ' , C.FirstName,C.LastName)) [Reversed Name]
FROM Customers C

/*
10:For each product display:

ProductName
First 3 characters
Last 3 characters
Length
Position of the word Galaxy
*/
SELECT
	LEFT(P.ProductName,3)  First3,
	RIGHT(P.ProductName,3) Last3,
	LEN(P.ProductName) Length,
	CHARINDEX('Galaxy', P.ProductName)  GalaxyPosition
FROM Products P

/*
11:For each customer display:

CustomerID
Full Name
First letter of First Name
First letter of Last Name
Length of Full Name
*/

SELECT
	C.CustomerID,
	CONCAT_WS(' ',C.FirstName , C.LastName) [Full Name],
	LEFT(C.FirstName,1)[First letter of First Name] ,
	LEFT(C.LastName,1)[First letter of Last Name],
	LEN(CONCAT_WS(' ',C.FirstName , C.LastName)) [Length of Full Name]

FROM Customers C

/*
12:Display:

ProductName
First word of the product name
*/
SELECT
	P.ProductName,
	LEFT(P.ProductName, CHARINDEX(' ', P.ProductName + ' ') - 1) FirstWord
FROM Products P

/*
13:Display all products whose names contain at least one digit.
*/
SELECT
    P.ProductName
FROM Products  P
WHERE PATINDEX('%[0-9]%', P.ProductName) > 0

/*
14:For each product display:

ProductName
Position of the first space
Number of words in ProductName
*/
SELECT
    P.ProductName,
    NULLIF(CHARINDEX(' ', P.ProductName), 0)  FirstSpacePosition,
    LEN(LTRIM(RTRIM(P.ProductName)))
      - LEN(REPLACE(LTRIM(RTRIM(P.ProductName)), ' ', ''))
      + 1  WordCount
FROM Products  P

/*
Report:
Full Name
Uppercase
Lowercase
Reverse
First 4 characters
Last 4 characters
Name Length
Position of first space
*/
SELECT
	CONCAT_WS(' ',C.FirstName , C.LastName) [Full Name],
	UPPER(CONCAT_WS(' ',C.FirstName , C.LastName)) Uppercase ,
	LOWER(CONCAT_WS(' ',C.FirstName , C.LastName)) Lowercase,
	REVERSE(CONCAT_WS(' ',C.FirstName , C.LastName)) Reverse,
	LEFT(CONCAT_WS(' ',C.FirstName , C.LastName),4) [First 4 characters],
	RIGHT(CONCAT_WS(' ',C.FirstName , C.LastName),4)[Last 4 characters] ,
	LEN(CONCAT_WS(' ',C.FirstName , C.LastName)) [Name Length],
	CHARINDEX(' ',CONCAT_WS(' ',C.FirstName , C.LastName))[Position of first space]
FROM Customers C
 
