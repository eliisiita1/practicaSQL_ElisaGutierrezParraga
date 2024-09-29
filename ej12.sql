WITH
  vdn_aggregation_table AS (
  SELECT
    ivr_id,
    CASE
      WHEN STARTS_WITH(vdn_label,'ATC') THEN 'FRONT'
      WHEN STARTS_WITH(vdn_label,'TECH') THEN 'TECH'
      WHEN vdn_label ='ABSORPTION' THEN 'ABSORPTION'
      ELSE 'RESTO'
  END
    AS vdn_aggregation
  FROM
    `keepcoding.ivr_calls`),
  document_number_table AS (
  SELECT
    ivr_id,
    document_identification
  FROM
    `keepcoding.ivr_steps`
  QUALIFY
    ROW_NUMBER() OVER (PARTITION BY CAST(ivr_id AS STRING)
    ORDER BY
      document_identification) = 1),
  document_type_table AS (
  SELECT
    ivr_id,
    document_type
  FROM
    `keepcoding.ivr_steps`
  QUALIFY
    ROW_NUMBER() OVER (PARTITION BY CAST(ivr_id AS STRING)
    ORDER BY
      document_type) = 1),
  customer_phone_table AS (
  SELECT
    calls_ivr_id AS ivr_id,
    calls_phone_number AS customer_phone
  FROM
    `keepcoding.ivr_detail`
  QUALIFY
    ROW_NUMBER() OVER (PARTITION BY CAST(calls_ivr_id AS STRING)
    ORDER BY
      calls_phone_number) = 1),
  billing_account_table AS (
  SELECT
    calls_ivr_id AS ivr_id,
    step_billing_account_id AS billing_account_step
  FROM
    keepcoding.ivr_detail
  QUALIFY
    ROW_NUMBER() OVER (PARTITION BY CAST(calls_ivr_id AS STRING)
    ORDER BY
      billing_account_step) = 1),
  averia_masiva_table AS (
  SELECT
    calls_ivr_id AS ivr_id,
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
    masiva_lg ASC),
  info_by_phone_lg_table AS (
  SELECT
    calls_ivr_id AS ivr_id,
    MAX(
    IF
      (step_name ='CUSTOMERINFOBYPHONE.TX'
        AND step_result ='OK', 1, 0)) AS info_by_phone_lg
  FROM
    keepcoding.ivr_detail
  GROUP BY
    calls_ivr_id
  ORDER BY
    info_by_phone_lg DESC),
  info_by_dni_lg_table AS (
  SELECT
    calls_ivr_id AS ivr_id,
    MAX(
    IF
      (step_name ='CUSTOMERINFOBYDNI.TX'
        AND step_result ='OK', 1, 0)) AS info_by_dni_lg
  FROM
    keepcoding.ivr_detail
  GROUP BY
    calls_ivr_id
  ORDER BY
    info_by_dni_lg ASC),
  dates_table AS (
  SELECT
    ivr_id,
    phone_number,
    start_date,
    LAG(start_date) OVER (PARTITION BY phone_number ORDER BY start_date) AS before_date,
    LEAD(start_date) OVER (PARTITION BY phone_number ORDER BY start_date) AS after_date
  FROM
    keepcoding.ivr_calls )
SELECT
  DISTINCT calls_ivr_id AS ivr_id,
  calls_phone_number AS phone_number,
  calls_ivr_result AS ivr_result,
  vdn_aggregation_table.vdn_aggregation AS vdn_aggregation,
  calls_start_date AS start_date,
  calls_end_date AS end_date,
  calls_total_duration AS total_duration,
  calls_customer_segment AS customer_segment,
  calls_ivr_language AS ivr_language,
  calls_steps_module AS steps_module,
  calls_module_aggregation AS module_aggregation,
IF
  (document_number_table.document_identification = 'UNKNOWN', 'DESCONOCIDO',document_number_table.document_identification),
IF
  (document_type_table.document_type = 'UNKNOWN', 'DESCONOCIDO',document_type_table.document_type),
  customer_phone_table.customer_phone AS customer_phone,
IF
  (SAFE_CAST(billing_account_step AS FLOAT64) IS NULL, 'DESCONOCIDO', billing_account_step) AS billing_account_id,
  averia_masiva_table.masiva_lg,
IF
  (TIMESTAMP_DIFF(start_date, before_date, HOUR) <= 24, 1, 0) AS repeated_phone_24H,
IF
  (TIMESTAMP_DIFF(after_date, start_date, HOUR) <= 24, 1, 0) AS cause_recall_phone_24H
FROM
  `keepcoding.ivr_detail`
INNER JOIN
  vdn_aggregation_table
ON
  vdn_aggregation_table.ivr_id = `keepcoding.ivr_detail`.calls_ivr_id
INNER JOIN
  document_number_table
ON
  document_number_table.ivr_id = `keepcoding.ivr_detail`.calls_ivr_id
INNER JOIN
  document_type_table
ON
  document_type_table.ivr_id = `keepcoding.ivr_detail`.calls_ivr_id
INNER JOIN
  customer_phone_table
ON
  customer_phone_table.ivr_id = `keepcoding.ivr_detail`.calls_ivr_id
INNER JOIN
  billing_account_table
ON
  billing_account_table.ivr_id = `keepcoding.ivr_detail`.calls_ivr_id
INNER JOIN
  averia_masiva_table
ON
  averia_masiva_table.ivr_id = `keepcoding.ivr_detail`.calls_ivr_id
INNER JOIN
  info_by_phone_lg_table
ON
  info_by_phone_lg_table.ivr_id = `keepcoding.ivr_detail`.calls_ivr_id
INNER JOIN
  info_by_dni_lg_table
ON
  info_by_dni_lg_table.ivr_id = `keepcoding.ivr_detail`.calls_ivr_id
INNER JOIN
  dates_table
ON
  dates_table.ivr_id = `keepcoding.ivr_detail`.calls_ivr_id