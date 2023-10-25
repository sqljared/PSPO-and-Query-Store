USE WideWorldImporters
GO
SELECT
    qsq.query_id,
    qsp.plan_id,
    CAST(qsp.query_plan as XML) AS query_plan,
    qt.query_sql_text,
    rsi.end_time,
    (rs.avg_duration * rs.count_executions) as total_duration,
    rs.avg_duration,
    rs.count_executions,
    rs.avg_cpu_time,
    rs.avg_logical_io_reads,
    rs.avg_rowcount
FROM sys.query_store_query qsq
INNER JOIN sys.query_store_plan qsp
    ON qsp.query_id = qsq.query_id
INNER JOIN sys.query_store_query_text qt
    ON qt.query_text_id = qsq.query_text_id
INNER JOIN sys.query_store_runtime_stats rs
    ON rs.plan_id = qsp.plan_id
INNER JOIN sys.query_store_runtime_stats_interval rsi
    ON rsi.runtime_stats_interval_id = rs.runtime_stats_interval_id
WHERE
    (qsq.object_id = OBJECT_ID('Sales.GetOrders')
	OR 
		-- Include variants with object_id = 0, if query_store_query_variant exists and parent query matches object_id
		(qsq.object_id = 0
		AND EXISTS(SELECT 1
			FROM sys.query_store_query_variant vr
			INNER JOIN sys.query_store_query pqsq
				ON pqsq.query_id = vr.parent_query_id
			WHERE
				vr.query_variant_query_id = qsq.query_id
				AND pqsq.object_id = OBJECT_ID('Sales.GetOrders')
		)
	)
    AND rsi.end_time > DATEADD(DAY,-2, GETUTCDATE()))
GO
