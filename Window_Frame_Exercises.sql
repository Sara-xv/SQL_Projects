--  Dataset

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    SalesPerson NVARCHAR(50),
    SaleDate DATE,
    Amount INT
);

INSERT INTO Sales VALUES
(1, 'Ali',  '2026-01-01', 100),
(2, 'Ali',  '2026-01-03', 200),
(3, 'Ali',  '2026-01-05', 150),
(4, 'Ali',  '2026-01-10', 300),
(5, 'Sara', '2026-01-02', 400),
(6, 'Sara', '2026-01-04', 250),
(7, 'Sara', '2026-01-06', 100),
(8, 'Sara', '2026-01-08', 500);


--1
/* 
    Aggregate the sales for each seller in chronological order.
*/
SELECT
    S.SalesPerson,
    S.SaleDate,
    SUM(S.Amount) OVER(PARTITION BY S.SalesPerson ORDER BY S.SaleDate) RunningTotal
FROM Sales S

--2
/*
For each seller, calculate the average sales of:
the previous row
the current row
the next row
*/
SELECT
    S.SalesPerson,
    AVG(S.Amount) OVER(PARTITION BY S.SalesPerson ORDER BY S.SaleDate
                        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) MovingAvg
FROM Sales S

--3
/*
Only the sum of the two most recent sales for each seller.  
*/
SELECT
    S.SalesPerson,
    SUM(S.Amount) OVER(PARTITION BY S.SalesPerson ORDER BY S.SaleDate 
                         ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) LastTwoSum
FROM Sales S


--4
/*
The total sales from this date to the end.
*/
SELECT 
    S.SalesPerson,
    SUM(S.Amount) OVER(PARTITION BY S.SalesPerson ORDER BY S.SaleDate 
                        ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM Sales S


--5
-- Add 2 rows
INSERT INTO Sales VALUES
(9, 'Ali', '2026-01-12', 150),
(10,'Ali', '2026-01-15', 150);

SELECT
    S.SaleDate,
    S.Amount,
    SUM(Amount) OVER (ORDER BY Amount
                       RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) RangeSum
FROM Sales S

--6
/*
The sum of the three most recent sales for each seller.
*/
SELECT
    S.SalesPerson,
    SUM(S.Amount) OVER(PARTITION BY S.SalesPerson ORDER BY S.SaleDate 
                        ROWS BETWEEN 2 PRECEDING  AND CURRENT ROW) LastThreeSales
FROM Sales S