# T-SQL Views & Enterprise Data Transformations

## 1. Architectural Philosophy: Roche's Maxim
All data cleaning, surrogate key formatting, data type casting, and calendar logic are pushed **upstream into T-SQL database views**. This minimizes Power Query overhead, eliminates M-code complexity, and optimizes Power BI's VertiPaq engine performance.

---

## 2. View Catalog Overview

| View Name | Entity Type | Grain | Key Logic / Transformations |
| :--- | :--- | :--- | :--- |
| `dbo.vw_DimGeography` | Dimension | 1 Row per Geography/Location | Cleans city/state labels, standardizes country codes |
| `dbo.vw_DimStore` | Dimension | 1 Row per Physical Store | Merges store location keys, formats selling area metrics |
| `dbo.vw_DimProduct` | Dimension | 1 Row per SKU/Product | Denormalizes Subcategory & Category hierarchies |
| `dbo.vw_DimCustomer` | Dimension | 1 Row per Customer | Concatenates full names, standardizes demographic keys |
| `dbo.vw_FactUnifiedSales` | Fact | 1 Row per Line Item Sale | Combines store/online channels into a unified schema |
| `dbo.vw_FactInventory` | Fact | 1 Row per Store / SKU / Date | Tracks on-hand, on-order, and stockout safety limits |
| `dbo.vw_DimDate` | Dimension | 1 Row per Calendar Day | Materialized static table (`DimDate_Static`) to fix `MAXRECURSION` |

---

## 3. Detailed View Specifications

### 3.1 `dbo.vw_DimGeography`
* **Purpose:** Provides conformed geographical attributes for store locations and customer demographic analysis.
* **Role-Playing Note:** Joined to `vw_DimCustomer` via an **Inactive Relationship** in Power BI to prevent ambiguity with store locations. Activates via DAX `USERELATIONSHIP()`.

### 3.2 `dbo.vw_DimStore`
* **Purpose:** Attributes store operational data, retail channel details, and store dimensions.
* **Transformations:** Formats `StoreKey` surrogate integer, standardizes opening/closing dates, and formats physical selling square footage.

### 3.3 `dbo.vw_DimProduct`
* **Purpose:** Standardizes product catalog details for profitability and category analysis.
* **Transformations:**
  * Flattens `DimProduct`, `DimProductSubcategory`, and `DimProductCategory` into a single conformed view.
  * Formats `UnitCost` and `UnitPrice` for accurate downstream margin modeling.

### 3.4 `dbo.vw_DimCustomer`
* **Purpose:** Contains customer profile metrics for omnichannel analysis.
* **Transformations:**
  * Standardizes surrogate keys (`CustomerKey`, `GeographyKey`).
  * Creates clean concatenated display attributes (`FullName = FirstName + ' ' + LastName`).

### 3.5 `dbo.vw_FactUnifiedSales`
* **Purpose:** The core financial fact table capturing sales transactions across physical and digital storefronts.
* **Transformations:**
  * Unifies historical sales records into a standardized schema.
  * Standardizes date surrogate keys to integer `YYYYMMDD` (`DateKey`).
  * Exposes explicit measure bases: `SalesAmount`, `SalesQuantity`, `ReturnAmount`, `ReturnQuantity`, `DiscountAmount`.

### 3.6 `dbo.vw_FactInventory`
* **Purpose:** Tracks inventory balances, supply chain flow, and stockout vulnerability.
* **Transformations:**
  * Maps daily snapshot levels (`OnHandQuantity`, `OnOrderQuantity`, `SafetyStockQuantity`).
  * Aligns `DateKey` and `StoreKey` to enable joint time-series filtering with sales facts.

### 3.7 `dbo.vw_DimDate`
* **Architectural Decision Record (ADR):** High-frequency refreshes against a recursive T-SQL CTE hit SQL Server's 100-iteration limit, causing a Power BI import `MAXRECURSION` error.
* **Resolution:** 
  1. Materialized CTE calendar records (2005–2011) into a static physical table: `dbo.DimDate_Static` using `OPTION (MAXRECURSION 0)`.
  2. Created presentation view `dbo.vw_DimDate` as `SELECT * FROM dbo.DimDate_Static`.

| Column Name | Data Type | Logic / Description |
| :--- | :--- | :--- |
| `DateKey` | `INT` | Surrogate key (`YYYYMMDD`) for 1:* model joins |
| `Date` | `DATE` | Native date column tagged as official Date Table |
| `DayLabel` | `VARCHAR(30)` | Day of the week display label |
| `MonthNumberLabel` | `INT` | Sorting helper for `MonthNameLabel` |
| `MonthNameLabel` | `VARCHAR(30)` | Calendar month name |
| `YearLabel` | `INT` | Calendar year |
| `WeekLabel` | `INT` | Week number of the year |
| `QuarterLabel` | `INT` | Quarter index (1–4) |
| `ISWEEKEND` | `BIT` | Hardcoded string check (`Saturday`/`Sunday`) immune to regional server culture settings |
