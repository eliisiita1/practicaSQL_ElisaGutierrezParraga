WITH
  averia_masiva_table AS (
  SELECT
    calls_ivr_id,
    MAX(CASE
        WHEN CONTAINS_SUBSTR(calls_module_aggregation, 'AVERIA_MASIVA') THEN 1
        ELSE 0
    END
      ) AS masiva_lg
  FROM
    keepcoding.ivr_detail
  GROUP BY
    calls_ivr_id
  ORDER BY
    masiva_lg ASC)
SELECT
  *
FROM
  averia_masiva_table