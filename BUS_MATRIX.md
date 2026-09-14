# Enterprise Bus Matrix Specification
**Project:** Contoso Retail Market & Inventory Analytics  
**Methodology:** Kimball Dimensional Modeling  
**Governance Standard:** Version 1.0 (Approved)  

---

## 1. Enterprise Bus Matrix

| Business Process (Fact Table) | Grain / Event Level | Date (`DimDate`) | Store (`DimStore`) | Product (`DimProduct`) | Customer (`DimCustomer`) | Geography (`DimGeography`) | Promotion (`DimPromotion`) |
| :--- | :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **POS Store Sales** (`FactSales`) | Line item per physical POS transaction | X | X | X | | X *(via Store)* | X |
| **Online E-Commerce Sales** (`FactOnlineSales`) | Line item per online order transaction | X | X *(Store 306)* | X | X | X *(via Customer)* | X |
| **Weekly Inventory Snapshot** (`FactInventory`) | Weekly snapshot per SKU per store location | X *(Weekly)* | X | X | | | |

---

## 2. Conformed Dimension Definitions

* **`DimDate`:** Standardized calendar table enabling cross-fact time intelligence (YoY, YTD, rolling averages).
* **`DimStore`:** Master entity for physical retail locations and online fulfillment centers.
* **`DimProduct`:** Conformed product hierarchy (`Category` -> `Subcategory` -> `Product`).
* **`DimCustomer`:** Individual and corporate buyers (used directly for online orders; anonymized for POS).
* **`DimGeography`:** Standardized spatial entity linking zip codes, cities, states, and coordinates to support catchment boundary calculations.
* **`DimPromotion`:** Discount and marketing campaign attributes.

---

## 3. Dimensional Design Decisions

* **Conformed Dimensions:** `DimDate`, `DimStore`, and `DimProduct` are shared across both Sales and Inventory facts to enable cross-process analysis (e.g., comparing weekly sales velocity against weekly inventory stock levels).
* **Geography Bridging:** POS sales map to spatial catchment locations using `DimStore.GeographyKey`, while Online sales map to delivery catchments using `DimCustomer.GeographyKey`.
