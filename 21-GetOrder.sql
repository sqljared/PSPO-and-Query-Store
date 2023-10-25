USE WideWorldImporters
GO
CREATE OR ALTER PROCEDURE Sales.GetOrders
	@CustomerID INT
AS

	SELECT 
		so.ContactPersonID,
		so.OrderDate,
		so.OrderID,
		so.CustomerPurchaseOrderNumber,
		so.ExpectedDeliveryDate
	FROM Sales.Orders so
	WHERE
		so.CustomerID = @CustomerID;
GO