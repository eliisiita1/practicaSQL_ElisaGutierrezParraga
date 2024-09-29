WITH
  info_by_dni_lg_table AS (
  SELECT
    calls_ivr_id,
    MAX(
    IF
      (step_name ='CUSTOMERINFOBYDNI.TX'
        AND step_result ='OK', 1, 0)) AS info_by_dni_lg
  FROM
    keepcoding.ivr_detail
  GROUP BY
    calls_ivr_id
  ORDER BY
    info_by_dni_lg ASC)
SELECT
  *
FROM
  info_by_dni_lg_table