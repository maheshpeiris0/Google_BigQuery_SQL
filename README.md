
query_papams = [
    bigquery.ScalarQueryParameter("subscriber_type", "STRING", "Customer"),
]
job_config = bigquery.QueryJobConfig()
job_config.query_parameters = query_papams

sql = """ SELECT * FROM `bigquery-public-data.san_francisco.bikeshare_trips` 
WHERE subscriber_type = @subscriber_type
  """

query_job = client.query(sql, job_config=job_config)
query_job.result()
df_result = query_job.to_dataframe()
print(" query results loaded to the table")


<br>
table infromation

https://cloud.google.com/bigquery/docs/information-schema-tables

<br>

bq show --format=prettyjson [PROJECT_ID]:[DATASET].[TABLE]

<br>
project level dataset detail sql
<br>
[PROJECT_ID.]`region-REGION`.INFORMATION_SCHEMA.TABLES
<br>
TABLE level
<br>
SELECT * FROM project.dataset.INFORMATION_SCHEMA.COLUMNS


