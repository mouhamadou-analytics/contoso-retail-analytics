# Source-to-Target Mapping (STM): `vw_FactUnifiedSales`

## 1. Metadata & Grain Overview
* **Target View Name:** `vw_FactUnifiedSales`
* **Target Grain:** One record per line item on a sales transaction or order across all sales channels.
* **Source Systems:** 
  * `FactSales` (Physical POS Stores)
  * `FactOnlineSales` (E-Commerce Platform)
* **Architecture Standard:** Kimball Star Schema (Unified Fact Table)
