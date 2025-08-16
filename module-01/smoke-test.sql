-- Smoke test: environment + database + quick data peek
SELECT @@VERSION AS SqlServerVersion; 
SELECT DB_NAME()  AS CurrentDb;

USE [WideWorldImporters];
GO

-- WWI: confirm basic rows exist
SELECT TOP (5) CustomerID, CustomerName
FROM Sales.Customers
ORDER BY CustomerID;