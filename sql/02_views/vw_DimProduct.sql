USE ContosoRetailDW;
GO

CREATE OR ALTER VIEW dbo.vw_DimProduct AS
SELECT 
    DP.ProductKey,
    DP.ProductName,
    DP.ProductDescription, 
    COALESCE(DPS.ProductSubcategoryName,'Uncategorize') AS ProductSubcategoryName,
    COALESCE(DPC.ProductCategoryName,'Uncategorize') AS ProductCategoryName,  
    DP.UnitCost, 
    DP.UnitPrice,
    DP.ClassName,
    DP.StyleName,
    DP.Status

FROM dbo.DimProduct AS DP
LEFT JOIN dbo.DimProductSubcategory AS DPS
ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey

LEFT JOIN dbo.DimProductCategory AS DPC
ON DPS.ProductCategoryKey = DPC.ProductCategoryKey; 
GO 
