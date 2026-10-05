USE ContosoRetailDW;
GO

SELECT
	YEAR(DateKey) AS ReportYear, 
	StoreKey,
	COUNT(*) AS NumberOfStockouts,
	SUM(OnOrderQuantity) AS ReorderQuantities
FROM vw_FactInventory
	WHERE OnHandQuantity = 0 
GROUP BY YEAR(DateKey), StoreKey
ORDER BY ReportYear ASC, NumberOfStockouts DESC;
