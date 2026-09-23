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
