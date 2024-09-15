--Creating database
CREATE DATABASE DatabaseName;

--Using the database
USE SalesAnalysis;

--Creating the table to import data
CREATE TABLE SalesData (
    RowID NVARCHAR(50),
    OrderID NVARCHAR(50),
    OrderDate DATE,
    ShipDate DATE,
    ShipMode NVARCHAR(50),
    CustomerID NVARCHAR(50),
    CustomerName NVARCHAR(255),
    Segment NVARCHAR(50),
    Country NVARCHAR(50),
    City NVARCHAR(100),
    State NVARCHAR(100),
    PostalCode NVARCHAR(20),
    Region NVARCHAR(50),
    ProductID NVARCHAR(50),
    Category NVARCHAR(50),
    SubCategory NVARCHAR(50),
    ProductName NVARCHAR(255),
    Sales DECIMAL(18, 2),  
    Quantity INT,          
    Discount DECIMAL(18, 2),  
    Profit DECIMAL(18, 2)  
);

--Importing data
BULK INSERT SalesData_Staging
FROM 'C:\Users\sk\Downloads\SQLinternship\File.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);


--Verifying the data is imported correctly or not 
SELECT TOP 10 * FROM SalesData;


--Top Sales per customer
SELECT
    CustomerID,
    CustomerName,
    MAX(Sales) AS TopSales
FROM SalesData
GROUP BY CustomerID, CustomerName;


--Average Discount by Product Category
SELECT
    Category,
    AVG(CAST(Discount AS DECIMAL(18, 2))) AS AvgDiscount
FROM SalesData
GROUP BY Category;


--Top 5 Cities by Total Sales
SELECT
    City,
    SUM(CAST(Sales AS DECIMAL(18, 2))) AS TotalSales
FROM SalesData
GROUP BY City
ORDER BY TotalSales DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;


--Products with Sales Greater than $5000
SELECT
    ProductName,
    Sales
FROM SalesData
WHERE CAST(Sales AS DECIMAL(18, 2)) > 5000;


--Number of Orders per Shipping Mode
SELECT
    ShipMode,
    COUNT(OrderID) AS NumberOfOrders
FROM SalesData
GROUP BY ShipMode;
