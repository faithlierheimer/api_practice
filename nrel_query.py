import requests
import datetime
from google.cloud import bigquery
from google.oauth2 import service_account
from nrel_key import nrel_key
import pandas as pd
import time

# Path to your service account JSON key
key_path = 'faith_bq_key.json'

# Initialize BQ client
credentials = service_account.Credentials.from_service_account_file(key_path)
client = bigquery.Client(credentials=credentials, project=credentials.project_id)

# Define NREL API URL and parames
nrel_url = "https://developer.nrel.gov/api/solar/solar_resource/v1.json"
lat, lon = 39.7392, -104.9903  # Coordinates for Denver
api_key = nrel_key  

# Generate a list of dates for the past week
end_date = datetime.datetime.today()
start_date = end_date - datetime.timedelta(days=100)
print(f"Starting on {start_date}, ending on {end_date}")

date_range = [start_date + datetime.timedelta(days=x) for x in range(100)]

# Prepare to collect data
solar_data = []

# Loop over each day and fetch the data from NREL API
for date in date_range:
    # Format the date as YYYY-MM-DD
    formatted_date = date.strftime('%Y-%m-%d')
    
    # NREL API request parameters
    params = {
        'lat': lat,
        'lon': lon,
        'api_key': api_key,
        'date': formatted_date
    }

    # Make the API request
    response = requests.get(nrel_url, params=params)
    
    if response.status_code == 200:
        response_data = response.json()
        
        if 'outputs' in response_data:
            # Add the date field to the response data
            data_entry = {
                'date': formatted_date,
                'avg_dni_annual': response_data['outputs'].get('avg_dni', {}).get('annual', None),
                'avg_ghi_annual': response_data['outputs'].get('avg_ghi', {}).get('annual', None)
            }
            # Append the data for BigQuery
            solar_data.append(data_entry)
            print(f"Successfully appended data.")
    else:
        print(f"Failed to retrieve data for {formatted_date}: {response.status_code}")
    time.sleep(5)
# Define bq dataset and table
dataset_id = 'faith-personal.solar_data'  
table_id = f'{dataset_id}.daily_solar_data'  

# Convert solar data to pandas df
df = pd.DataFrame(solar_data)

# Upload the data to BigQuery
try:
    # Use BigQuery client to upload DataFrame
    job = client.load_table_from_dataframe(df, table_id)
    job.result()  # Wait for the job to complete
    print(f"Data successfully loaded into {table_id}")
except Exception as e:
    print(f"Failed to upload data: {e}")
