import requests
import datetime
from google.cloud import bigquery
from google.oauth2 import service_account
from weather_key import weather_key
import pandas as pd
import time

# stuff for api call
api_key = weather_key
region = 'Colorado'

# Cities in colorado 
cities = [
    'Denver', 'Colorado Springs', 'Aurora', 'Fort Collins', 'Lakewood', 
    'Thornton', 'Arvada', 'Westminster', 'Pueblo', 'Centennial', 
    'Boulder', 'Greeley', 'Longmont', 'Grand Junction', 'Castle Rock',
    'Commerce City', 'Parker', 'Littleton', 'Broomfield', 'Northglenn', 
    'Englewood', 'Greenwood Village', 'Lafayette', 'Lamar', 'Louisville', 
    'Loveland', 'Golden', 'Salida', 'Cañon City', 'Montrose', 
    'Steamboat Springs', 'Vail', 'Durango', 'Breckenridge', 'Aspen', 
    'Telluride', 'Frisco', 'Eagle', 'Alamosa', 'Wheat Ridge', 
    'La Junta', 'Elizabeth', 'Brush', 'Fort Morgan', 'Woodland Park',
    'Pagosa Springs', 'Delta', 'Westcliffe', 'Silt', 'Glenwood Springs'
]

# BQ service account json key
key_path = 'faith_bq_key.json'


# Initialize BQ client
credentials = service_account.Credentials.from_service_account_file(key_path)
client = bigquery.Client(credentials=credentials, project=credentials.project_id)


# Initialize empty df to collect weather data
weather_data = []


# Loop through each city in the list
for city in cities:
    # Construct the API URL for each city
    url = f'http://api.weatherapi.com/v1/current.json?key={api_key}&q={city}'

    # Make the API call
    response = requests.get(url)

    if response.status_code == 200:
        data = response.json()  
        current_weather = data['current']
        city_name = data['location']['name']
        city_lat = data['location']['lat']
        city_long = data['location']['lon']
        date = data['location']['localtime']
        last_updated = data['current']['last_updated']
        temperature = current_weather['temp_c']
        humidity = current_weather['humidity']
        uv = current_weather['uv']

        data_entry = {
            'date': date,
            'last_updated': last_updated,
            'city_name': city_name,
            'city_lat': city_lat,
            'city_long': city_long,
            'temperature': temperature,
            'humidity': humidity,
            'uv': uv
        }

        # Add data entry to weather_data list
        weather_data.append(data_entry)
    else:
        print(f"Error fetching data for {city}: {response.status_code}")

# Print the collected weather data for all cities
print(weather_data)

# Define the BigQuery dataset and table
dataset_id = 'faith-personal.weather_data'  # Replace with your dataset
table_id = f'{dataset_id}.weather_data'  # Replace with your table name

# Convert the weather data to a pandas DataFrame
df = pd.DataFrame(weather_data)

# Define BigQuery schema 
schema = [
    bigquery.SchemaField('date', 'STRING'),
    bigquery.SchemaField('last_updated', 'STRING'),
    bigquery.SchemaField('city_name', 'STRING'),
    bigquery.SchemaField('city_lat', 'FLOAT'),
    bigquery.SchemaField('city_long', 'FLOAT'),
    bigquery.SchemaField('temperature', 'FLOAT'),
    bigquery.SchemaField('humidity', 'INTEGER'),
    bigquery.SchemaField('uv', 'FLOAT')
]

# Upload the data to BigQuery
try:
    job = client.load_table_from_dataframe(df, table_id, job_config=bigquery.LoadJobConfig(schema=schema))
    job.result()  # Wait for the job to complete
    print(f"Data successfully loaded into {table_id}")
except Exception as e:
    print(f"Failed to upload data: {e}")

