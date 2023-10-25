USE WideWorldImporters
GO
CREATE OR ALTER PROCEDURE Sales.GenerateOrder
	@CustomerID INT
AS

DECLARE
	@SalesPersonID INT = 13,
	@ContactPersonID INT = 1179,
	@OrderDate date = GETDATE(),
	@ExpectedDeliveryDate date = DATEADD(MONTH, 1, GETDATE()),
	@IsUndersupplyBackordered bit = 0,
	@LastEditedBy int = 20,
	@LastEditedWhen datetime2 = GETUTCDATE();

INSERT INTO Sales.Orders (
	CustomerID,
	SalespersonPersonID,
	ContactPersonID,
	OrderDate,
	ExpectedDeliveryDate,
	IsUndersupplyBackordered,
	LastEditedBy,
	LastEditedWhen)
VALUES(
	@CustomerID,
	@SalesPersonID,
	@ContactPersonID,
	@OrderDate,
	@ExpectedDeliveryDate,
	@IsUndersupplyBackordered,
	@LastEditedBy,
	@LastEditedWhen);
GO