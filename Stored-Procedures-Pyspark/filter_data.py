import pandas as pd
from google.cloud import bigquery

def read_bq_df():
    client = bigquery.Client()
    sql = """
        SELECT country, region_code,name,province_code,confirmed_cases 
        FROM `bigquery-public-data.covid19_italy.data_by_province` LIMIT 1000
    """
    df = client.query(sql).to_dataframe()

    table_name_bq = 'friendly-plane-294914.test_table.covid19_italy'
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
    print(df.head())

if __name__ == '__main__':
    read_bq_df()
