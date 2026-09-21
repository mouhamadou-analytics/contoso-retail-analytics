# Source-to-Target Mapping (STM): `vw_FactUnifiedSales`

## 1. Metadata & Grain Overview
* **Target View Name:** `vw_FactUnifiedSales`
* **Target Grain:** One record per line item on a sales transaction or order across all sales channels.
* **Source Systems:** 
  * `FactSales` (Physical POS Stores)
  * `FactOnlineSales` (E-Commerce Platform)
* **Architecture Standard:** Kimball Star Schema (Unified Fact Table)
## 2. Target Field Mapping Matrix

| Target Column Name | Target Data Type | Key Type | Source System / Table | Source Column Name | Transforming Logic | Default / NULL Logic |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **DateKey** | `INT` | FK | `FactSales` / `FactOnlineSales` | `DateKey` | Passthrough | `N/A` |
| **ProductKey** | `INT` | FK | `FactSales` / `FactOnlineSales` | `ProductKey` | Passthrough | `N/A` |
| **ChannelKey** | `INT` | FK | `FactSales` / `FactOnlineSales` | `ChannelKey` / `N/A` | `FactSales`: Passthrough<br>`FactOnlineSales`: `2 AS ChannelKey` | `2` for Online |
| **CustomerKey** | `INT` | FK | `FactSales` / `FactOnlineSales` | `N/A` / `CustomerKey` | `FactSales`: `-1 AS CustomerKey`<br>`FactOnlineSales`: Passthrough | `COALESCE(CustomerKey, -1)` |
| **StoreKey** | `INT` | FK | `FactSales` / `FactOnlineSales` | `StoreKey` | Passthrough | `N/A` |
| **PromotionKey** | `INT` | FK | `FactSales` / `FactOnlineSales` | `PromotionKey` | Passthrough | `COALESCE(PromotionKey, -1)` |
| **OrderQuantity** | `INT` | MEASURE | `FactSales` / `FactOnlineSales` | `SalesQuantity` / `SalesQuantity` | `SalesQuantity AS OrderQuantity` | `0` |
| **SalesAmount** | `DECIMAL(18,2)` | MEASURE | `FactSales` / `FactOnlineSales` | `SalesAmount` | Passthrough | `0.00` |
| **TotalCost** | `DECIMAL(18,2)` | MEASURE | `FactSales` / `FactOnlineSales` | `TotalCost` | Passthrough | `0.00` |
| **ReturnQuantity** | `INT` | MEASURE | `FactSales` / `FactOnlineSales` | `ReturnQuantity` | Passthrough | `0` |
| **ReturnAmount** | `DECIMAL(18,2)` | MEASURE | `FactSales` / `FactOnlineSales` | `ReturnAmount` | Passthrough | `0.00` |
| **DiscountQuantity** | `INT` | MEASURE | `FactSales` / `FactOnlineSales` | `DiscountQuantity` | Passthrough | `0` |
| **DiscountAmount** | `DECIMAL(18,2)` | MEASURE | `FactSales` / `FactOnlineSales` | `DiscountAmount` | Passthrough | `0.00` |
| **SalesOrderNumber** | `NVARCHAR(50)` | DEGENERATE | `FactSales` / `FactOnlineSales` | `SalesKey` / `SalesOrderNumber` | `FactSales`: `CONCAT('POS-', SalesKey)`<br>`FactOnlineSales`: Passthrough | `N/A` |
| **SalesLineNumber** | `INT` | DEGENERATE | `FactSales` / `FactOnlineSales` | `N/A` / `SalesLineNumber` | `FactSales`: `1 AS SalesLineNumber`<br>`FactOnlineSales`: Passthrough | `COALESCE(SalesLineNumber, 1)` |
