 working

<br>

CREATE OR REPLACE PROCEDURE `project`.test_table.spark_proc()
WITH CONNECTION `project.us.pyspark-connections` OPTIONS(engine="SPARK", runtime_version="1.1", main_file_uri="gs://project/Hello.py") LANGUAGE PYTHON



CREATE OR REPLACE PROCEDURE `project`.test_table.bigquery_data_query_proc()
WITH CONNECTION `project.us.pyspark-connections` OPTIONS(engine="SPARK", runtime_version="1.1") LANGUAGE PYTHON AS
R"""
import pandas as pd
from google.cloud import bigquery

def read_bq_df():
    client = bigquery.Client()
    sql = "SELECT country, region_code,name,province_code,confirmed_cases FROM `bigquery-public-data.covid19_italy.data_by_province` LIMIT 1000"
    df = client.query(sql).to_dataframe()

    table_name_bq = 'project.test_table.covid19_italy'
    job_config = bigquery.LoadJobConfig(
        schema=[
            bigquery.SchemaField("country", "STRING"),
            bigquery.SchemaField("region_code", "STRING"),
            bigquery.SchemaField("name", "STRING"),
            bigquery.SchemaField("province_code", "STRING"),
            bigquery.SchemaField("confirmed_cases", "INTEGER"),
        ],
        write_disposition="WRITE_TRUNCATE",
    )

    job = client.load_table_from_dataframe(df, table_name_bq, job_config=job_config)
    job.result()
    
    print('Loaded {} rows into {}.'.format(job.output_rows, table_name_bq))
