/*
Blinkit Sales Analysis - SQL Server
Import data/Blinkit_10000_Rows.csv into BlinkitDB as dbo.Blinkit_Raw before running.
Dataset is synthetic practice data, not official Blinkit data.
*/
IF DB_ID('BlinkitDB') IS NULL CREATE DATABASE BlinkitDB;
GO
USE BlinkitDB;
GO
IF OBJECT_ID('dbo.Sales','U') IS NOT NULL DROP TABLE dbo.Sales;
IF OBJECT_ID('dbo.Products','U') IS NOT NULL DROP TABLE dbo.Products;
IF OBJECT_ID('dbo.Outlets','U') IS NOT NULL DROP TABLE dbo.Outlets;
GO
CREATE TABLE dbo.Products(
 Item_Identifier VARCHAR(20) PRIMARY KEY, Item_Weight DECIMAL(8,2),
 Item_Fat_Content VARCHAR(30), Item_Visibility DECIMAL(10,6),
 Item_Type VARCHAR(100), Item_MRP DECIMAL(10,2));
CREATE TABLE dbo.Outlets(
 Outlet_Identifier VARCHAR(20) PRIMARY KEY, Outlet_Establishment_Year INT,
 Outlet_Size VARCHAR(20), Outlet_Location_Type VARCHAR(30), Outlet_Type VARCHAR(50));
CREATE TABLE dbo.Sales(
 SaleID INT IDENTITY(1,1) PRIMARY KEY, Item_Identifier VARCHAR(20) NOT NULL,
 Outlet_Identifier VARCHAR(20) NOT NULL, Item_MRP DECIMAL(10,2), Item_Outlet_Sales DECIMAL(12,2),
 FOREIGN KEY(Item_Identifier) REFERENCES dbo.Products(Item_Identifier),
 FOREIGN KEY(Outlet_Identifier) REFERENCES dbo.Outlets(Outlet_Identifier));
GO
INSERT INTO dbo.Products
SELECT Item_Identifier,MAX(Item_Weight),MAX(Item_Fat_Content),MAX(Item_Visibility),MAX(Item_Type),MAX(Item_MRP)
FROM dbo.Blinkit_Raw WHERE Item_Identifier IS NOT NULL GROUP BY Item_Identifier;
INSERT INTO dbo.Outlets
SELECT Outlet_Identifier,MAX(Outlet_Establishment_Year),MAX(Outlet_Size),MAX(Outlet_Location_Type),MAX(Outlet_Type)
FROM dbo.Blinkit_Raw WHERE Outlet_Identifier IS NOT NULL GROUP BY Outlet_Identifier;
INSERT INTO dbo.Sales(Item_Identifier,Outlet_Identifier,Item_MRP,Item_Outlet_Sales)
SELECT r.Item_Identifier,r.Outlet_Identifier,r.Item_MRP,r.Item_Outlet_Sales FROM dbo.Blinkit_Raw r
JOIN dbo.Products p ON p.Item_Identifier=r.Item_Identifier
JOIN dbo.Outlets o ON o.Outlet_Identifier=r.Outlet_Identifier;
GO
-- Row counts
SELECT 'Blinkit_Raw' TableName,COUNT_BIG(*) RowCount FROM dbo.Blinkit_Raw
UNION ALL SELECT 'Products',COUNT_BIG(*) FROM dbo.Products
UNION ALL SELECT 'Outlets',COUNT_BIG(*) FROM dbo.Outlets
UNION ALL SELECT 'Sales',COUNT_BIG(*) FROM dbo.Sales;
-- Analysis
SELECT SUM(Item_Outlet_Sales) Total_Sales FROM dbo.Sales;
SELECT AVG(Item_Outlet_Sales) Average_Sales FROM dbo.Sales;
SELECT p.Item_Type,SUM(s.Item_Outlet_Sales) Total_Sales FROM dbo.Sales s JOIN dbo.Products p ON p.Item_Identifier=s.Item_Identifier GROUP BY p.Item_Type ORDER BY Total_Sales DESC;
SELECT o.Outlet_Type,SUM(s.Item_Outlet_Sales) Total_Sales FROM dbo.Sales s JOIN dbo.Outlets o ON o.Outlet_Identifier=s.Outlet_Identifier GROUP BY o.Outlet_Type ORDER BY Total_Sales DESC;
SELECT o.Outlet_Location_Type,SUM(s.Item_Outlet_Sales) Total_Sales FROM dbo.Sales s JOIN dbo.Outlets o ON o.Outlet_Identifier=s.Outlet_Identifier GROUP BY o.Outlet_Location_Type ORDER BY Total_Sales DESC;
SELECT o.Outlet_Size,SUM(s.Item_Outlet_Sales) Total_Sales FROM dbo.Sales s JOIN dbo.Outlets o ON o.Outlet_Identifier=s.Outlet_Identifier GROUP BY o.Outlet_Size ORDER BY Total_Sales DESC;
SELECT p.Item_Fat_Content,SUM(s.Item_Outlet_Sales) Total_Sales FROM dbo.Sales s JOIN dbo.Products p ON p.Item_Identifier=s.Item_Identifier GROUP BY p.Item_Fat_Content ORDER BY Total_Sales DESC;
SELECT TOP 10 p.Item_Type,SUM(s.Item_Outlet_Sales) Total_Sales FROM dbo.Sales s JOIN dbo.Products p ON p.Item_Identifier=s.Item_Identifier GROUP BY p.Item_Type ORDER BY Total_Sales DESC;
SELECT o.Outlet_Establishment_Year,SUM(s.Item_Outlet_Sales) Total_Sales FROM dbo.Sales s JOIN dbo.Outlets o ON o.Outlet_Identifier=s.Outlet_Identifier GROUP BY o.Outlet_Establishment_Year ORDER BY o.Outlet_Establishment_Year;
