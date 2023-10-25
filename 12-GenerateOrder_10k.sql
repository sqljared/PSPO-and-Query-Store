USE WideWorldImporters
GO
CREATE OR ALTER PROCEDURE Sales.GenerateOrder_10k
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

WITH tally1 AS(
	SELECT 
		tally_val
	FROM (values(1),(2),(3),(4),(5),(6),(7),(8),(9),(10)) AS val(tally_val)
),
tally2 AS(
	SELECT
		ROW_NUMBER() OVER(ORDER BY t1.tally_val) AS tally_val
	FROM tally1 t1
	CROSS JOIN tally1 t2
),
tally3 AS(
	SELECT
		ROW_NUMBER() OVER(ORDER BY t1.tally_val) AS tally_val
	FROM tally2 t1
	CROSS JOIN tally2 t2
)
INSERT INTO Sales.Orders (
	CustomerID,
	SalespersonPersonID,
	ContactPersonID,
	OrderDate,
	ExpectedDeliveryDate,
	IsUndersupplyBackordered,
	LastEditedBy,
	LastEditedWhen)
SELECT
	@CustomerID,
	@SalesPersonID,
	@ContactPersonID,
	@OrderDate,
	@ExpectedDeliveryDate,
	@IsUndersupplyBackordered,
	@LastEditedBy,
	@LastEditedWhen
FROM tally3 t3;
GO