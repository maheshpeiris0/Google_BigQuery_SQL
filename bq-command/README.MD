bq show --format=prettyjson project_id:datataset.table

<br>

SELECT *, TIMESTAMP_MILLIS(last_modified_time)
FROM `dataset.__TABLES__` where table_id = 'table_id'

