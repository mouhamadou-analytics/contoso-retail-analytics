USE ContosoRetailDW;
GO

CREATE OR ALTER VIEW dbo.vw_DimStore AS
SELECT
    StoreKey,
    GeographyKey,
    StoreManager,
    StoreType,
    StoreName,
    StoreDescription,
    Status,
    OpenDate,
    CloseDate,                                      -- Preserved as NULL for Date data typing
    COALESCE(CloseReason, 'Active Store') AS CloseReason, -- Text default replacing NULL
    ZipCode,
    EmployeeCount,
    SellingAreaSize
FROM dbo.DimStore;
GO
