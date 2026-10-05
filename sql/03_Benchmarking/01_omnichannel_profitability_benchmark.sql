USE ContosoRetailDW;
GO 



SELECT TOP 1 * FROM dbo.vw_FactUnifiedSales;

SELECT 
	channelName,
	YEAR(DateKey) AS YearO,
	SUM(SalesAmount) AS TotalNetRevenue,
	SUM(UnitCost*SalesQuantity) AS TotalCost,
	SUM(SalesAmount)-SUM(UnitCost*SalesQuantity) AS NetProfit, 
	(SUM(SalesAmount)-SUM(UnitCost*SalesQuantity))*100.0/SUM(SalesAmount) AS GrossProfit
FROM vw_FactUnifiedSales
GROUP BY channelName, YEAR(Datekey)
ORDER BY YEAR(Datekey); 
