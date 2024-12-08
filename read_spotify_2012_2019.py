import pandas as pd
import json
from google.cloud import bigquery



# early data means 2012-2019
early_data = pd.read_json('../spotify/Streaming_History_Audio_2012-2019_0.json')

bq_creds_path = 'faith_bq_key.json'

# Initialize BQ clinet
client = bigquery.Client.from_service_account_json(bq_creds_path)

## Define dataset & table name
dataset_id = 'spotify'  # Name of your dataset
table_id = 'streaming_history_2012_2019'  # Desired table name
full_table_id = f'{client.project}.{dataset_id}.{table_id}'

# Upload DataFrame to BigQuery
try:
    early_data.to_gbq(destination_table=full_table_id,
              project_id=client.project,
              credentials=client._credentials,
              if_exists='replace')  # 'replace' will overwrite if the table already exists
    print("Data uploaded successfully to BigQuery!")
except Exception as e:
    print("Error uploading data to BigQuery:", e)
