/*
    -- This trigger automatically logs every new customer inserted into customers_large table
    -- Trigger type: AFTER INSERT (fires after successful insertion)
*/
CREATE TABLE CustomerLogs
(
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    FullName NVARCHAR(200),
    Email NVARCHAR(200),
    CreatedAt DATETIME DEFAULT GETDATE()
);


CREATE TRIGGER trg_Customers_Insert_Log
ON customers_large
AFTER INSERT
AS
BEGIN

SET NOCOUNT ON;

    -- Insert log record with customer details from the inserted virtual table
    INSERT INTO CustomerLogs(
        CustomerID,
        FullName,
        Email)
    SELECT
        i.CustomerID,
        CONCAT_WS(' ', i.FirstName, i.LastName),  -- Combines first and last name
        i.Email
    FROM inserted i;  -- 'inserted' virtual table contains the newly added rows

END
GO

/*
   -- This trigger prevents deletion of customers who have existing orders
   -- Trigger type: INSTEAD OF DELETE (replaces the DELETE operation)
*/

CREATE TRIGGER trg_PreventCustomerDelete
ON customers_large
INSTEAD OF DELETE
AS
BEGIN

SET NOCOUNT ON;

IF EXISTS(
     SELECT 1
     FROM deleted d
     JOIN orders o
     ON d.CustomerID = o.CustomerID)
    BEGIN
        THROW 50001, 'Cannot delete customer because they have orders.', 1;
    END

    DELETE FROM customers_large
    WHERE CustomerID IN
    (
        SELECT CustomerID
        FROM deleted
    );

END
GO

/*
   -- This trigger automatically logs any changes to customer Email or City fields
   -- Trigger type: AFTER UPDATE (fires after successful update operation)
*/

CREATE TABLE CustomerChangeLog
(
    ChangeID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    OldEmail NVARCHAR(200),
    NewEmail NVARCHAR(200),
    OldCity NVARCHAR(100),
    NewCity NVARCHAR(100),
    ChangedAt DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER trg_LogCustomerChanges
ON customers_large
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO CustomerChangeLog
    (
        CustomerID,
        OldEmail,
        NewEmail,
        OldCity,
        NewCity
    )
    SELECT
        d.CustomerID,
        d.Email,
        i.Email,
        d.City,
        i.City
    FROM deleted d
    JOIN inserted i
        ON d.CustomerID = i.CustomerID
    WHERE
        ISNULL(d.Email,'') <> ISNULL(i.Email,'')
        OR
        ISNULL(d.City,'') <> ISNULL(i.City,'');

END
GO


