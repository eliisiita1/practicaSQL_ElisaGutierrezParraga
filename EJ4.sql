WITH vdn_aggregation_table as
(SELECT ivr_id,
CASE
WHEN  STARTS_WITH(vdn_label,'ATC') then 'FRONT'
WHEN  STARTS_WITH(vdn_label,'TECH') then 'TECH'
WHEN  vdn_label ='ABSORPTION' then 'ABSORPTION'
ELSE 'RESTO'
END AS vdn_aggregation
 FROM `keepcoding.ivr_calls`)

 SELECT * FROM vdn_aggregation_table