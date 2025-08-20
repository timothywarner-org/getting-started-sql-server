-- test_customers_to_csv.sql
-- Purpose: Simple query used for csv export demos
SET NOCOUNT ON;
USE [WideWorldImporters];
SELECT TOP (5) CustomerID, CustomerName
FROM Sales.Customers
ORDER BY CustomerID;
