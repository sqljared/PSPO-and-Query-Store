USE WideWorldImporters
GO
UPDATE STATISTICS Sales.Orders
	WITH FULLSCAN, ALL;
GO
DBCC SHOW_STATISTICS('Sales.Orders', FK_Sales_Orders_CustomerID);
GO
