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

url = f'http://api.weatherapi.com/v1/current.json?key={api_key}&q={region}'

# BQ service account json key
key_path = 'faith_bq_key.json'


# Initialize BQ client
credentials = service_account.Credentials.from_service_account_file(key_path)
client = bigquery.Client(credentials=credentials, project=credentials.project_id)

# Initialize empty df
weather_data = []

# weather api call
response = requests.get(url)


if response.status_code == 200:
    data = response.json()  # Convert the response to a Python dictionary
    # grab some key data pieces
    current_weather = data['current']
    city_name = data['location']['name']
    date = data['location']['localtime']
    last_updated = data['current']['last_updated']
    temperature = current_weather['temp_c']
    humidity = current_weather['humidity']
    uv = current_weather['uv']

    data_entry = {
        'date': date,
        'last_updated': last_updated,
        'city_name': city_name,
        'temperature': temperature,
        'humidity': humidity,
        'uv': uv
    }

    #add data entry to df
    weather_data.append(data_entry)
else:
    print('Error:', response.status_code)

print(weather_data)