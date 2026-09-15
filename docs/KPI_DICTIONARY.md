# Enterprise KPI Dictionary Specification
**Project:** Contoso Retail Market & Inventory Analytics  
**Governance Standard:** Version 1.0 (Approved)  

---

## 1. Core Financial & Sales Velocity Metrics

### KPI-01: Net Sales Revenue
* **Business Definition:** Total revenue realized from POS and e-commerce transactions after subtracting returns.
* **Mathematical Formula:** $$\sum (\text{SalesAmount} - \text{ReturnAmount})$$
* **Source Location & Grain:** `vw_FactUnifiedSales[SalesAmount]`, `vw_FactUnifiedSales[ReturnAmount]`
* **Metric Owner:** VP of Sales
* **Operational Action Trigger:** If weekly net sales drop $>5\%$ WoW in any region, initiate store operations review.
* **Profiling Note:** Verified across $3,406,089$ unified records; `SalesAmount` natively accounts for promotional discounts.

---

### KPI-02: Market Contribution Margin ($)
* **Business Definition:** Catchment-level profit remaining after deducting product costs, allocated store overhead, and fulfillment fees from net sales.
* **Mathematical Formula:** $$\text{Net Revenue} - (\text{TotalCost} + \text{Allocated Store OPEX} + \text{Fulfillment Cost})$$
* **Source Location & Grain:** `vw_FactUnifiedSales[SalesAmount]`, `vw_FactUnifiedSales[TotalCost]`, `DimStore[StoreOpex]`
* **Metric Owner:** CFO / VP of Sales / Supply Chain Director
* **Operational Action Trigger:** If catchment contribution margin falls below $10\%$ (or becomes negative), reallocate high-margin inventory to high-demand catchments and evaluate underperforming trade areas for closure or downsizing.
* **Profiling Note:** Combines physical store performance with 15-mile e-commerce radius halo.

---

## 2. Supply Chain & Inventory Alignment Metrics

### KPI-03: Stock-to-Sales Ratio (Days of Supply)
* **Business Definition:** Measures inventory coverage by comparing current on-hand stock against recent weekly sales velocity.
* **Mathematical Formula:** $$\frac{\text{OnHandQuantity}_{\text{Weekly Snapshot}}}{\sum(\text{Weekly SalesQuantity})}$$
* **Source Location & Grain:** `vw_FactInventory[OnHandQuantity]`, `vw_FactUnifiedSales[SalesQuantity]`
* **Metric Owner:** Supply Chain Director / Merchandise Planner
* **Operational Action Trigger:** 
  * **Stockout Risk:** If ratio $< 1.0$ week of supply, trigger Distribution Center (DC) stock replenishment.
  * **Overstock Risk:** If ratio $> 4.0$ weeks of supply, trigger promotional markdown or inventory reallocation.
* **Profiling Note:** Uses 4 weeks of supply as baseline due to missing target thresholds in raw tables.

---

## 3. Diagnostic & Return Metrics

### KPI-04: Return Rate (%)
* **Business Definition:** Percentage of gross sales value returned by customers across POS and online channels.
* **Mathematical Formula:** $$\frac{\sum \text{ReturnAmount}}{\sum (\text{SalesAmount} + \text{ReturnAmount})} \times 100$$
* **Source Location & Grain:** `vw_FactUnifiedSales[ReturnAmount]`, `vw_FactUnifiedSales[SalesAmount]`
* **Metric Owner:** VP of Merchandising / Store Operations
* **Operational Action Trigger:** If return rate exceeds $3.5\%$ for any product subcategory or channel, initiate vendor quality audit or review online sizing specifications.
* **Profiling Note:** Evaluates revenue leakage differences between in-store purchases and online orders.

---

## 4. Promotional Elasticity & Discount Metrics

### KPI-05: Discount Depth (%)
* **Business Definition:** Average percentage markdown applied across promotional sales transactions.
* **Mathematical Formula:** $$\frac{\sum \text{DiscountAmount}}{\sum (\text{SalesAmount} + \text{DiscountAmount})} \times 100$$
* **Source Location & Grain:** `vw_FactUnifiedSales[DiscountAmount]`, `vw_FactUnifiedSales[SalesAmount]`
* **Metric Owner:** Marketing Director / Pricing Lead
* **Operational Action Trigger:** If discount depth exceeds $20\%$ on a product line without generating a corresponding volume lift, flag promotion as margin-dilutive.
* **Profiling Note:** Isolates gross markdown margin loss per transaction.

---


* ### KPI-06: Promotional Elasticity ($E_p$)
* **Business Definition:** Sensitivity of unit sales volume relative to changes in discount depth.
* **Mathematical Formula:**

$$
E_p = \frac{\% \Delta \text{ Sales Quantity}}{\% \Delta \text{ Discount Depth}} = \frac{(\text{Qty}_{\text{Promo}} - \text{Qty}_{\text{Base}}) / \text{Qty}_{\text{Base}}}{\text{DiscountAmount} / \text{GrossSales}}
$$

* **Source Location & Grain:** `vw_FactUnifiedSales[SalesQuantity]`, `vw_FactUnifiedSales[SalesAmount]`, `vw_FactUnifiedSales[DiscountAmount]`, `vw_FactUnifiedSales[TotalCost]`, `vw_FactUnifiedSales[PromotionKey]`
* **Metric Owner:** Marketing Director / Pricing Manager
* **Operational Action Trigger:** 
  * **Excessive Margin Erosion ($E_p < 1.0$):** If volume lift is positive but net profit lift is negative, terminate campaign.
  * **High Efficiency ($E_p > 1.5$):** If volume lift and net profit lift are both positive, extend campaign duration.
* **Profiling Note:** Baseline ($\text{Qty}_{\text{Base}}$) uses a 30-day moving average of daily units sold when `PromotionKey = 1` (No Discount).
