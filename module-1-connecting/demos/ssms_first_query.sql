SELECT TOP (5) CustomerID, CustomerName, CreditLimit
FROM WideWorldImporters.Sales.Customers
ORDER BY CreditLimit DESC;