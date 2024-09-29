WITH dates_table AS
(select ivr_id,phone_number, start_date,
  LAG(start_date) OVER (PARTITION BY phone_number ORDER BY start_date) AS before_date,
  LEAD(start_date) OVER (PARTITION BY phone_number ORDER BY start_date) AS after_date
    FROM
        keepcoding.ivr_calls
)
SELECT
    ivr_id,
    phone_number,
    if(TIMESTAMP_DIFF(start_date, before_date, HOUR) <= 24, 1, 0) AS repeated_phone_24H,
    if(TIMESTAMP_DIFF(after_date, start_date, HOUR) <= 24, 1, 0) AS cause_recall_phone_24H
FROM
    dates_table
ORDER BY phone_number