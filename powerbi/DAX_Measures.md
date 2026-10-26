# Power BI DAX Measures

Use exact table names from the Power BI Data pane. If your table is named `blinkitdb sales`, use that name instead of `Sales`.

```DAX
Total Sales = SUM(Sales[Item_Outlet_Sales])
Average Sales = AVERAGE(Sales[Item_Outlet_Sales])
Sales Records = COUNTROWS(Sales)
Total Products = DISTINCTCOUNT(Products[Item_Identifier])
Total Outlets = DISTINCTCOUNT(Outlets[Outlet_Identifier])
Average Item MRP = AVERAGE(Sales[Item_MRP])
```

Suggested visuals: KPI cards; Sales by Item Type; Sales by Outlet Type; Sales by Outlet Location Type; Sales by Outlet Size; Sales by Fat Content; slicers for Item Fat Content, Outlet Size, Outlet Type and Item Type.
