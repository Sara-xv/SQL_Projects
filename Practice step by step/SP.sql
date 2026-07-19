-- SP (Stored Procedures)

/*
Create a stored procedure named

sp_AllProducts

that displays all products.
*/
CREATE PROCEDURE sp_AllProducts AS
SET NOCOUNT ON;
BEGIN
	SELECT 
        P.ProductID, 
        P.ProductName, 
        P.Price, 
        P.Stock 
    FROM Products P;
END;
GO

/*
Create

sp_ProductByID

Input:

@ProductID

Return the selected product.
*/

CREATE PROCEDURE sp_ProductByID  
    @ProductID INT AS
BEGIN
	SELECT *
	FROM Products P
	WHERE  P.ProductID = @ProductID
END;
GO

/*
Write a Procedure.

If the product is found:

Print Product Found

If not found:

Print Product Not Found
*/
CREATE PROCEDURE usp_FoundProduct 
    @ProductID INT 
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS(SELECT 1 FROM Products P WHERE P.ProductID = @ProductID)
    BEGIN
        PRINT 'Product Found.';

        SELECT 
            P.ProductID,
            P.ProductName,
            P.Price
        FROM Products P
        WHERE P.ProductID = @ProductID;
    END
    ELSE
    BEGIN
        PRINT 'Product Not Found.';
    END;
END;
GO


/*
Customer Name
Number Of Orders
Total Purchase
Average Purchase
Biggest Order
*/

CREATE PROCEDURE usp_CustomerReport 
    @CustomerID INT 
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        CONCAT_WS(' ', C.FirstName, C.LastName) AS CustomerName,
        COUNT(O.OrderID) AS NumberOfOrders,
        ISNULL(SUM(O.TotalAmount), 0) AS TotalPurchase,
        ISNULL(AVG(O.TotalAmount), 0) AS AveragePurchase,
        ISNULL(MAX(O.TotalAmount), 0) AS BiggestOrder
    FROM Customers C
    LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
    WHERE C.CustomerID = @CustomerID
    GROUP BY C.FirstName, C.LastName;
END;
GO


/*
OrderID

If Total Amount > 50,000 ? print Large Order

If Total Amount > 20,000 ? print Medium Order

Otherwise ? print Small Order
*/

CREATE PROCEDURE usp_OrderSize 
    @OrderID INT 
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @Amount MONEY;

    SELECT @Amount = TotalAmount FROM Orders WHERE OrderID = @OrderID;

    IF @Amount IS NULL
    BEGIN
        PRINT 'Order Not Found';
        RETURN;
    END;

    IF @Amount > 50000
    BEGIN
        PRINT 'Large Order';
    END
    ELSE IF @Amount > 20000
    BEGIN
        PRINT 'Medium Order';
    END
    ELSE
    BEGIN
        PRINT 'Small Order';
    END;
END;
GO

/*
First:

Update the Price.

Then:

Update the Stock.

If either operation fails (has an error):

Rollback the transaction.
*/

CREATE PROCEDURE usp_UpdateProduct
    @ProductID INT,
    @NewPrice MONEY,
    @NewStock INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Products WHERE ProductID = @ProductID)
    BEGIN
        PRINT 'Product Not Found';
        RETURN;
    END;

    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE Products
        SET Price = @NewPrice
        WHERE ProductID = @ProductID;

        UPDATE Products
        SET Stock = @NewStock
        WHERE ProductID = @ProductID;

        COMMIT TRANSACTION;
        PRINT 'Product Updated Successfully';
    END TRY
    
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        PRINT 'Update Failed';
        PRINT ERROR_MESSAGE();
    END CATCH;
END;