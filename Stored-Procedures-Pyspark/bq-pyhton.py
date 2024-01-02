import pandas as pd
from google.cloud import bigquery

def upload_to_bq():
    df = pd.read_csv('gs://spothero-mp/MSFT.csv')
    df['Date'] = pd.to_datetime(df['Date'])
    df.rename(columns={'Adj Close': 'Adj_Close'}, inplace=True)
    client = bigquery.Client()

    table_name_bq = 'project.test_table.MSFT_Price_Table'
    job_config = bigquery.LoadJobConfig(
        schema=[
            bigquery.SchemaField("Date", "DATE"),
            bigquery.SchemaField("Open", "FLOAT"),
            bigquery.SchemaField("High", "FLOAT"),
            bigquery.SchemaField("Low", "FLOAT"),
            bigquery.SchemaField("Close", "FLOAT"),
            bigquery.SchemaField("Adj_Close", "FLOAT"),
            bigquery.SchemaField("Volume", "INTEGER"),
        ],
        write_disposition="WRITE_TRUNCATE",
    )

    job = client.load_table_from_dataframe(df, table_name_bq, job_config=job_config)
    job.result()
    
    print('Loaded {} rows into {}.'.format(job.output_rows, table_name_bq))


if __name__ == '__main__':
    upload_to_bq()
