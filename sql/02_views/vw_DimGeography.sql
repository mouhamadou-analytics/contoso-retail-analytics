USE ContosoRetailDW;
GO

-- Null replacement in DimGeography to avoid blank. Geometry is a sql server spatial type that we need to exclude for Power BI reporting. 

CREATE OR ALTER VIEW dbo.vw_DimGeography AS

SELECT 
	GeographyKey,
	GeographyType,
	ContinentName,
	COALESCE(CityName, 'N/A') AS CityName,
	COALESCE(StateProvinceName,'N/A') AS StateProvinceName, 
	COALESCE(RegionCountryName,'N/A') AS RegionCountryName
FROM dbo.DimGeography;
GO

-- We also need to exclude geolocation and geometry



