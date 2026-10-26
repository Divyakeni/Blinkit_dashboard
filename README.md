# Blinkit Sales Analysis Dashboard | SQL Server + Power BI

## Contents
- `data/Blinkit_10000_Rows.csv` — 10,000-row, 12-column synthetic practice dataset.
- `sql/Blinkit_Sales_Analysis_SQL_Server.sql` — SQL Server schema, primary/foreign keys, data load, validation, and analysis queries.
- `sql/blinkit_original.sql` — original SQL file supplied by the project owner.
- `powerbi/Blinkit_Sales_Analysis_Template.pbit` — supplied Power BI template.
- `powerbi/Original_Project_Reference.pdf` — supplied PDF.
- `powerbi/DAX_Measures.md` — starter measures.
- `screenshots/Blinkit_Dashboard_Screenshot.png` — supplied dashboard screenshot.

## Dataset disclaimer
The included CSV is **synthetic practice data**, not official Blinkit company data. The screenshot shows example KPIs such as Average Sales 5.03K, Total Outlets 90, Total items 5993 and Total Sales 50.32M; these figures may come from a different dataset and will not necessarily match the CSV.

## Tools
SQL Server/SSMS, Power BI Desktop, Power Query, DAX.

## Run the project
1. In SSMS, create `BlinkitDB`.
2. Right-click the database → **Tasks → Import Flat File**. Import `data/Blinkit_10000_Rows.csv` as `Blinkit_Raw`.
3. Run `sql/Blinkit_Sales_Analysis_SQL_Server.sql` in `BlinkitDB`. It creates `Products`, `Outlets`, and `Sales`. It drops/recreates those three modeled tables if rerun; it does not drop `Blinkit_Raw`.
4. In Power BI Desktop, choose **Get Data → SQL Server**, enter your server and `BlinkitDB`, then load `Products`, `Outlets`, and `Sales`.
5. Confirm relationships: `Products[Item_Identifier]` 1-to-many `Sales[Item_Identifier]`; `Outlets[Outlet_Identifier]` 1-to-many `Sales[Outlet_Identifier]`.
6. Create measures from `powerbi/DAX_Measures.md`.

## Suggested dashboard
- KPI cards: Total Sales, Average Sales, Total Products, Total Outlets.
- Charts: Sales by Item Type, Outlet Type, Outlet Location Type, Outlet Size, and Fat Content.
- Slicers: Item Fat Content, Outlet Size, Outlet Type, Item Type.

## Resume bullets (adjust to match your actual work)
- Designed a 3-table SQL Server relational model with primary/foreign keys to analyze 10,000 synthetic sales records.
- Built a Power BI dashboard using SQL, Power Query and DAX to visualize sales by item type, outlet type, location, size and fat content.

## GitHub
Create a repository such as `blinkit-sales-analysis-sql-powerbi` and upload all folders/files while keeping this structure.
