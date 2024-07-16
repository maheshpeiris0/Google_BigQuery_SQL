bq show --format=prettyjson project_id:datataset.table

<br>

SELECT * FROM  project_id.dataset.INFORMATION_SCHEMA.TABLES WHERE table_name ='Table_Name'

<br>

SELECT *, TIMESTAMP_MILLIS(last_modified_time)
FROM `dataset.__TABLES__` where table_id = 'table_id'

<br>



SELECT *
FROM `project_id.dataset.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'Table_Name'
