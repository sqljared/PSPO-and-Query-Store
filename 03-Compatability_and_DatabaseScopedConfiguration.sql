USE WideWorldImporters
GO
-- Example query to return the compatibility_level.
-- SQL Server 2022 compatibility_level is 160
SELECT 
	db.compatibility_level  
FROM sys.databases db
WHERE db.database_id = DB_ID();
GO
-- Example script to check whether PARAMETER_SENSITIVE_PLAN_OPTIMIZATION is enabled
-- Will return 0 rows if on < SQL Server 2022
SELECT
	CONVERT(bit,dsc.value)
FROM sys.database_scoped_configurations dsc
WHERE dsc.name = 'PARAMETER_SENSITIVE_PLAN_OPTIMIZATION';
GO
