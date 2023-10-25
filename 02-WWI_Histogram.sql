USE WideWorldImporters
GO
-- Returns some properties for each statistic on Sales.Orders
SELECT 
 sp.stats_id as StatisticsID, 
 s.name as StatisticsName, 
 sp.last_updated, 
 sp.rows as TotalRows, 
 sp.rows_sampled, 
 sp.steps, 
 sp.unfiltered_rows
FROM sys.stats AS s 
 CROSS APPLY sys.dm_db_stats_properties(s.object_id, s.stats_id) AS sp
WHERE s.object_id = OBJECT_ID('Sales.Orders')
ORDER BY s.[name];

-- Returns any histogram values over 10,000 for equal_row
SELECT 
	hist.step_number, 
	hist.range_high_key, 
	hist.range_rows, 
    hist.equal_rows, 
	hist.distinct_range_rows, 
	hist.average_range_rows,
	object_name(hist.object_id), 
	s.name
FROM sys.stats AS s
CROSS APPLY sys.dm_db_stats_histogram(s.[object_id], s.stats_id) AS hist
WHERE
	s.object_id = OBJECT_ID('Sales.Orders')
	AND hist.equal_rows > 10000;
	--AND hist.range_rows > 10000;
