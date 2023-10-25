USE WideWorldImporters
GO
SELECT *
FROM sys.query_store_query_variant vr
GO
SELECT 
	-- Details for the parent query and dispatcher plan
	qsq.query_id,
	qsp.plan_id,
	qsq.query_text_id,
	qsp.plan_type,
	qsp.plan_type_desc,
	OBJECT_NAME(qsq.object_id),
	CAST(qsp.query_plan AS XML),
	-- Details for the variant query and variant plan
	qv.query_id,
	qv.object_id,
	qvp.plan_id,
	CAST(qvp.query_plan AS XML),
	qv.query_text_id,
	qvt.query_sql_text,
	qvp.plan_type,
	qvp.plan_type_desc
FROM sys.query_store_query qsq
INNER JOIN sys.query_store_plan qsp
	ON qsp.query_id = qsq.query_id
LEFT JOIN sys.query_store_query_variant vr
	ON vr.parent_query_id = qsq.query_id
	AND vr.dispatcher_plan_id = qsp.plan_id
LEFT JOIN sys.query_store_query qv
	ON qv.query_id = vr.query_variant_query_id
LEFT JOIN sys.query_store_query_text qvt
	ON qvt.query_text_id = qv.query_text_id
LEFT JOIN sys.query_store_plan qvp
	ON qvp.query_id = qv.query_id
WHERE
	qsq.object_id = OBJECT_ID('Sales.GetOrders')
ORDER BY
	qsq.query_id,
	qsp.plan_id,
	qv.query_id,
	qvp.plan_id;
GO
