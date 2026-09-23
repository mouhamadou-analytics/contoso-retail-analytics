# Omnichannel Star Schema Data Architecture

```mermaid
erDiagram
    DimDate ||--o{ vw_FactUnifiedSales : "DateKey"
    DimDate ||--o{ vw_FactInventory : "DateKey"
    
    DimProduct ||--o{ vw_FactUnifiedSales : "ProductKey"
    DimProduct ||--o{ vw_FactInventory : "ProductKey"
    
    DimStore ||--o{ vw_FactUnifiedSales : "StoreKey"
    DimStore ||--o{ vw_FactInventory : "StoreKey"
    
    DimCustomer ||--o{ vw_FactUnifiedSales : "CustomerKey"
    DimGeography ||--o{ DimStore : "GeographyKey"
    DimGeography ||--o{ DimCustomer : "GeographyKey"
    
    vw_FactUnifiedSales {
        int DateKey FK
        int ProductKey FK
        int ChannelKey FK
        int CustomerKey FK
        int StoreKey FK
        int PromotionKey FK
        int OrderQuantity
        decimal SalesAmount
        decimal TotalCost
        string SalesOrderNumber
    }

    vw_FactInventory {
        int DateKey FK
        int StoreKey FK
        int ProductKey FK
        int CurrencyKey FK
        int OnHandQuantity
        int OnOrderQuantity
        int SafetyStockQuantity
        decimal UnitCost
    }
<Steps>
  <Step subtitle="1 min" title="Open Edit Mode">
    On the GitHub page shown in your screenshot, click the pencil icon (or click the three dots `...` on the top right of the file container) to edit `schema.md`.
  </Step>
  <Step subtitle="1 min" title="Replace File Content">
    Delete the `git add...` text entirely, and paste the code block above into the file editor.
  </Step>
  <Step subtitle="1 min" title="Commit Changes">
    Click the green **Commit changes...** button at the top right, enter the commit message `docs: update schema with mermaid diagram`, and click **Commit changes**.
  </Step>
</Steps>

To verify the step was successful, look at the **Preview** tab of `schema.md` on GitHub: you should see an interactive, visual diagram with connected boxes instead of plain text lines.

<Elicitations message="What would you like to do next?">
  <Elicitation label="Close Issue #4 on GitHub" query="Issue #4 schema diagram is updated and rendered on GitHub. How do I close Issue #4 and update the Kanban board?"/>
  <Elicitation label="Start Issue #5 (T-SQL Views)" query="The star schema diagram is complete. Let's move on to Issue #5 and build the conformed dimension T-SQL views."/>
</Elicitations>
