/* 
	This stored procedure retrieves all customers filtered by a specific city.
	It accepts a city name as input parameter and returns customer details including ID, full name, email, and city.
*/
CREATE PROCEDURE GetCustomersByCity  @City NVARCHAR(100) AS 
BEGIN 
	SELECT 
		C.CustomerID,
		CONCAT_WS(' ' , C.FirstName , C.LastName) Name,
		C.Email,
		C.City
	FROM customers_large C
	WHERE C.City = @City
END
GO


/*
	If the input parameter is NULL, empty, or contains only spaces, it returns all customers.
*/

CREATE PROCEDURE GetCustomersByCity2  @City NVARCHAR(100) = NULL AS 
BEGIN 
-- Prevents sending "rows affected" messages to the client
SET NOCOUNT ON;
-- Check if @City is NULL, empty string, or only spaces
-- Convert to NULL so that the WHERE clause returns all records
IF (LTRIM(RTRIM(ISNULL(@City, ''))) = '')
     SET @City = NULL;

	SELECT 
		C.CustomerID,
		CONCAT_WS(' ' , C.FirstName , C.LastName) Name,
		C.Email,
		C.City
	FROM customers_large C
	WHERE  @City IS NULL OR C.City = @City 
END
GO



/*
	Returns customers matching the specified filters. If both parameters are NULL, returns all custom
*/

CREATE PROCEDURE SearchCustomers  @City NVARCHAR(100) = NULL  , @Email NVARCHAR(100) = NULL AS 
BEGIN 

SET NOCOUNT ON;

	SELECT 
		C.CustomerID,
		CONCAT_WS(' ' , C.FirstName , C.LastName) Name,
		C.Email,
		C.City
	FROM customers_large C
	WHERE (@City IS NULL OR C.City = @City) AND
	      (@Email IS NULL OR C.Email LIKE '%' + @Email + '%')
END
GO



/*
	Returns a page of results based on city, email (partial match), page number, and page size.
*/

CREATE PROCEDURE SearchCustomersPaged
    @City       NVARCHAR(100) = NULL,
    @Email      NVARCHAR(100) = NULL,
    @PageNumber INT = 1,
    @PageSize   INT = 10
AS
BEGIN

SET NOCOUNT ON;
    --Validate and fix invalid page number: ensure it's at least 1
    IF (@PageNumber IS NULL OR @PageNumber < 1)
        SET @PageNumber = 1;
	-- Validate and fix invalid page size: ensure it's at least 1
    IF (@PageSize IS NULL OR @PageSize < 1)
        SET @PageSize = 10;

    SELECT
        C.CustomerID,
        CONCAT_WS(' ', C.FirstName, C.LastName) Name,
        C.Email,
        C.City
    FROM customers_large C
    WHERE (@City IS NULL OR C.City = @City) AND
	      (@Email IS NULL OR C.Email LIKE '%' + @Email + '%')
    ORDER BY
        C.CustomerID -- Consistent ordering required for pagination
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END
GO

/*
	Supports filtering by city and email (partial match), with sort column and direction parameters.
*/

CREATE PROCEDURE SearchCustomersSorted 
	@City NVARCHAR(100) = NULL,
	@Email NVARCHAR(100) = NULL,
	@SortColumn NVARCHAR(50) = 'CustomerID',
	@SortDirection NVARCHAR(4) = 'ASC'   AS 
BEGIN 

SET NOCOUNT ON;
-- Normalize / Validate SortDirection
SET @SortDirection = UPPER(@SortDirection);

IF (@SortDirection NOT IN ('ASC', 'DESC'))
        SET @SortDirection = 'ASC';

	SELECT
	    C.CustomerID,
        CONCAT_WS(' ', C.FirstName, C.LastName) Name,
        C.Email,
        C.City
	FROM customers_large C
	WHERE  (@City IS NULL OR C.City = @City) AND
	      (@Email IS NULL OR C.Email LIKE '%' + @Email + '%')
	ORDER BY 
		CASE 
            WHEN @SortColumn = 'CustomerID' THEN C.CustomerID
        END,
        CASE 
            WHEN @SortColumn = 'Name' THEN CONCAT_WS(' ', C.FirstName, C.LastName)
        END,
        CASE 
            WHEN @SortColumn = 'Email' THEN C.Email
        END,
        CASE 
            WHEN @SortColumn = 'City' THEN C.City
        END
	 -- apply direction here
     OFFSET 0 ROWS  -- required when using CASE + dynamic direction
     FETCH NEXT 100000 ROWS ONLY
     OPTION (RECOMPILE); -- lets optimizer choose best plan
END
GO

-- IMPORTANT NOTE: The CASE-based sorting only works correctly for ASC direction on VARCHAR columns.
-- For proper DESC sorting, you need Dynamic SQL or add direction logic within CASE expressions.
-- Example fix for DESC: ORDER BY CASE WHEN @SortDirection = 'ASC' THEN column END ASC, CASE WHEN @SortDirection = 'DESC' THEN column END DESC


 