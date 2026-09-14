# Enterprise Bus Matrix Specification
**Project:** Contoso Retail Market & Inventory Analytics  
**Methodology:** Kimball Dimensional Modeling & T-SQL Transformation  
**Governance Standard:** Version 1.0 (Approved)  

---

## 1. Enterprise Bus Matrix

| Business Question / Process | Target Unified Table / View | Grain Level | DimDate | DimProduct | DimGeography | DimStore | DimPromotion |
| :--- | :--- | :--- | :---: | :---: | :---: | :---: | :---: |
| **Q1: Market Profit** | `vw_FactUnifiedSales` | Line Item Transaction | X | X | X | X | |
| **Q2: Inventory Alignment** | `vw_FactInventory` | Daily Store SKU Snapshot | X | X | X | X | |
| **Q3: Diagnostics** | `vw_FactUnifiedSales` | Line Item Transaction | X | X | X | X | X |
| **Q4: Promo Elasticity** | `vw_FactUnifiedSales` | Line Item Transaction | X | X | X | X | X |

---

## 2. Source-to-View Architecture

* **`vw_FactUnifiedSales`:** Unifies POS (`FactSales`) and E-Commerce (`FactOnlineSales`) transactions into a single reporting grain.
* **`vw_FactInventory`:** Aggregates snapshot records (`FactInventory`) to monitor stockout risks alongside sales velocity.

---

## 3. Conformed Dimension Definitions

* **`DimDate`:** Standard calendar table supporting time intelligence calculations.
* **`DimProduct`:** Conformed hierarchy (`Category` -> `Subcategory` -> `Product`).
* **`DimGeography`:** Zip code and regional coordinate mappings for 15-mile spatial catchments.
* **`DimStore`:** Physical retail locations and digital fulfillment channels.
* **`DimPromotion`:** Campaign and discount classifications for elasticity analysis.
