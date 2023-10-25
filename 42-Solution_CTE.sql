USE WideWorldImporters
GO
WITH QueryList AS(
        SELECT
            ISNULL(qv.query_id, qsq.query_id) AS query_id,
            ISNULL(qvp.plan_id, qsp.plan_id) AS plan_id,
            ISNULL(qvp.query_plan, qsp.query_plan) AS query_plan,
            ISNULL(qv.query_text_id, qsq.query_text_id) AS query_text_id,
            ISNULL(qvp.plan_type_desc, qsp.plan_type_desc) AS plan_type_desc
        FROM sys.query_store_query qsq
        INNER JOIN sys.query_store_plan qsp
            ON qsp.query_id = qsq.query_id
        LEFT JOIN sys.query_store_query_variant vr
            ON vr.parent_query_id = qsq.query_id
            AND vr.dispatcher_plan_id = qsp.plan_id
        LEFT JOIN sys.query_store_query qv
            ON qv.query_id = vr.query_variant_query_id
        LEFT JOIN sys.query_store_plan qvp
            ON qvp.query_id = qv.query_id
        WHERE
            qsq.object_id = OBJECT_ID('Sales.GetOrders')
)
SELECT
    ql.query_id,
    ql.plan_id,
    CAST(ql.query_plan as XML) AS query_plan,
    qt.query_sql_text,
    rs.last_execution_time,
    (rs.avg_duration * rs.count_executions) as total_duration,
    rs.avg_duration,
    rs.count_executions,
    rs.avg_cpu_time,
    rs.avg_logical_io_reads,
    rs.avg_rowcount,
	rs.*
FROM QueryList ql
INNER JOIN sys.query_store_query_text qt
    ON qt.query_text_id = ql.query_text_id
INNER JOIN sys.query_store_runtime_stats rs
    ON rs.plan_id = ql.plan_id
WHERE
    rs.last_execution_time > DATEADD(DAY,-2, GETUTCDATE())
GO
