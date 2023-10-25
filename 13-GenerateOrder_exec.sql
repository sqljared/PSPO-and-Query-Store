USE WideWorldImporters
GO
SET NOCOUNT ON;

--EXEC Sales.GenerateOrder @CustomerID = 901;
--GO 500000 -- 203 seconds

--EXEC Sales.GenerateOrder @CustomerID = 90;
--GO 1100000

EXEC Sales.GenerateOrder_10k @CustomerID = 901;
GO 50 -- 8 seconds

EXEC Sales.GenerateOrder_10k @CustomerID = 90;
GO 110 -- 19 seconds
