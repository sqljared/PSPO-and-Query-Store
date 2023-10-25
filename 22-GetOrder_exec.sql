USE WideWorldImporters
GO
SET NOCOUNT OFF;

--DECLARE 
--	@OrderID int,
--	@CustomerID int;

--SET @OrderID = RAND()*80000;

--SELECT 
--	@CustomerID = so.CustomerID
--FROM Sales.Orders so
--WHERE
--	so.OrderID = @OrderID;4
--GO

EXEC Sales.GetOrders @CustomerID = 13; -- 13,90,1061, 901
GO 
EXEC Sales.GetOrders @CustomerID = 90; -- 13,90,1061, 901
GO 
EXEC Sales.GetOrders @CustomerID = 901; -- 13,90,1061, 901
GO 
EXEC Sales.GetOrders @CustomerID = 1061; -- 13,90,1061, 901
GO 
