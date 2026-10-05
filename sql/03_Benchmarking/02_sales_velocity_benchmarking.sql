USE ContosoRetailDW;
GO


WITH DailyRev_CTE AS ( 
SELECT
	Datekey,
	ProductKey,
	SUM(SalesAmount) AS DailyNetRevenue
FROM vw_FactUnifiedSales
GROUP BY Datekey, Productkey)

SELECT
	DateKey,
	ProductKey,
	SUM(DailyNetRevenue) OVER( PARTITION BY ProductKey ORDER BY DateKey ROWS BETWEEN 29 PRECEDING AND CURRENT ROW) AS Rolling_30_Days_Sales
FROM DailyRev_CTE;
