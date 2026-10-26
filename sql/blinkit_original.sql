use blinkitdb;

CREATE TABLE Products(
    ItemIdentifier VARCHAR(20) PRIMARY KEY,
    ItemType VARCHAR(100),
    ItemFatContent VARCHAR(50),
    ItemWeight FLOAT,
    ItemVisibility FLOAT
);

CREATE TABLE Outlets(
    OutletIdentifier VARCHAR(20) PRIMARY KEY,
    OutletType VARCHAR(100),
    OutletSize VARCHAR(20),
    OutletLocationType VARCHAR(50),
    OutletEstablishmentYear INT
);

CREATE TABLE Sales (
    SaleID INT AUTO_INCREMENT PRIMARY KEY,
    ItemIdentifier VARCHAR(20),
    OutletIdentifier VARCHAR(20),
    ItemMRP FLOAT,
    SalesAmount FLOAT,

    FOREIGN KEY (ItemIdentifier)
        REFERENCES Products(ItemIdentifier),

    FOREIGN KEY (OutletIdentifier)
        REFERENCES Outlets(OutletIdentifier)
);

SELECT *
FROM Blinkit_Raw;

INSERT INTO Products
SELECT DISTINCT
Item_Identifier,
Item_Type,
Item_Fat_Content,
Item_Weight,
Item_Visibility
FROM Blinkit_Raw;

INSERT INTO Outlets
SELECT DISTINCT
Outlet_Identifier,
Outlet_Type,
Outlet_Size,
Outlet_Location_Type,
Outlet_Establishment_Year
FROM Blinkit_Raw;

INSERT INTO Sales(
ItemIdentifier,
OutletIdentifier,
ItemMRP,
SalesAmount
)
SELECT
Item_Identifier,
Outlet_Identifier,
Item_MRP,
Item_Outlet_Sales
FROM Blinkit_Raw;

SELECT *
FROM Products;

SELECT *
FROM Outlets;

SELECT *
FROM Sales;

# SQL Analysis Queries:

SELECT
SUM(SalesAmount) AS TotalSales
FROM Sales;

SELECT TOP 10
p.ItemType,
SUM(s.SalesAmount) AS Sales
FROM Sales s
JOIN Products p
ON s.ItemIdentifier = p.ItemIdentifier
GROUP BY p.ItemType
ORDER BY Sales DESC;

SELECT
o.OutletType,
SUM(s.SalesAmount) AS Sales
FROM Sales s
JOIN Outlets o
ON s.OutletIdentifier=o.OutletIdentifier
GROUP BY o.OutletType
ORDER BY Sales DESC;

SELECT
AVG(ItemMRP) AS AvgPrice
FROM Sales;

SELECT
OutletIdentifier,
SUM(SalesAmount) AS TotalSales
FROM Sales
GROUP BY OutletIdentifier
ORDER BY TotalSales DESC;

SELECT
p.ItemFatContent,
SUM(s.SalesAmount) AS Sales
FROM Sales s
JOIN Products p
ON s.ItemIdentifier=p.ItemIdentifier
GROUP BY p.ItemFatContent;

