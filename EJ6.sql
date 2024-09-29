WITH
  customer_phone_table AS (
  SELECT
    calls_ivr_id,
    calls_phone_number AS customer_phone
  FROM
    `keepcoding.ivr_detail`
  QUALIFY
    ROW_NUMBER() OVER (PARTITION BY CAST(calls_ivr_id AS STRING)
    ORDER BY
      calls_phone_number) = 1)
SELECT
  *
FROM
  customer_phone_table