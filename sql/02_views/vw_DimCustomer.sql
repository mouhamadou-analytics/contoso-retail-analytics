USE ContosoRetailDW;
GO

CREATE OR ALTER VIEW dbo.vw_DimCustomer AS 
SELECT
	CustomerKey,
	GeographyKey,
	CustomerType,
	CONCAT(FirstName,' ',LastName) AS FullName,
	AddressLine1,
	COALESCE(AddressLine2, 'N/A') AS AddressLine2, 
	EmailAddress,
	Gender,
	MaritalStatus,
	Education,
	Occupation
FROM dbo.DimCustomer; 
GO
