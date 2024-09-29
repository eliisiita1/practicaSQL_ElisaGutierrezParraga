 WITH info_by_phone_lg_table AS
 (SELECT calls_ivr_id,
  MAX(if(step_name ='CUSTOMERINFOBYPHONE.TX' AND step_result ='OK', 1, 0)) AS info_by_phone_lg
FROM
    keepcoding.ivr_detail
GROUP BY
    calls_ivr_id
ORDER BY info_by_phone_lg DESC)

SELECT *
FROM info_by_phone_lg_table