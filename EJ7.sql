WITH
  billing_account_table AS (
  SELECT
    calls_ivr_id,
    step_billing_account_id AS billing_account_step
  FROM
    keepcoding.ivr_detail
  QUALIFY
    ROW_NUMBER() OVER (PARTITION BY CAST(calls_ivr_id AS STRING)
    ORDER BY
      billing_account_step) = 1)
SELECT
  calls_ivr_id,
IF
  (SAFE_CAST(billing_account_step AS FLOAT64) IS NULL, 'DESCONOCIDO', billing_account_step) AS billing_account_id
FROM
  billing_account_table