USE WideWorldImporters
GO
CREATE OR ALTER PROCEDURE Sales.GetOrders_PastDate
	@CustomerID INT,
	@ContactPersonID INT,
	@OrderID INT
AS

	SELECT 
		so.ContactPersonID,
		so.OrderDate,
		so.OrderID,
		so.CustomerPurchaseOrderNumber,
		so.ExpectedDeliveryDate,
		inv.InvoiceID,
		inv.InvoiceDate,
		inv.ContactPersonID,
		inv.PackedByPersonID, 
		inv.CustomerPurchaseOrderNumber
	FROM Sales.Orders so
	LEFT JOIN Sales.Invoices inv
		ON inv.OrderID = so.OrderID
	WHERE
		so.CustomerID = @CustomerID
		AND so.OrderID = @OrderID
		AND so.ExpectedDeliveryDate < GETUTCDATE()
		AND inv.ContactPersonID = @ContactPersonID
GO


EXEC Sales.GetOrders_PastDate
	@CustomerID = 90,
	@ContactPersonID = 1179,
	@OrderID = 36079;
GO
