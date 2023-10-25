USE WideWorldImporters
GO
SELECT
    qsq.query_id,
    qsp.plan_id,
    CAST(qsp.query_plan as XML) AS query_plan,
    qt.query_sql_text,
    rs.last_execution_time,
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
WHERE
    qsq.object_id = OBJECT_ID('Sales.GetOrders')
    AND rs.last_execution_time > DATEADD(DAY,-2, GETUTCDATE())
GO
