import requests
import datetime
from google.cloud import bigquery
from google.oauth2 import service_account
from census_data_key import census_key
import pandas as pd
import time
import json

# dictionaries/variables for looking up census data for each colorado city
city_fips_dict = {
    'Denver': '08031000',
    'Colorado Springs': '08050000',
    'Aurora': '08036000',
    'Fort Collins': '08031050',
    'Lakewood': '08041000',
    'Thornton': '08077000',
    'Arvada': '08026000',
    'Westminster': '08081200',
    'Pueblo': '08080000',
    'Centennial': '08014000',
    'Boulder': '08080020',
    'Greeley': '08078000',
    'Longmont': '08046000',
    'Grand Junction': '08056000',
    'Castle Rock': '08030000',
    'Commerce City': '08071000',
    'Parker': '08059600',
    'Littleton': '08044800',
    'Broomfield': '08008400',
    'Northglenn': '08054000',
    'Englewood': '08028200',
    'Greenwood Village': '08043200',
    'Lafayette': '08044000',
    'Lamar': '08043000',
    'Louisville': '08047000',
    'Loveland': '08051000',
    'Golden': '08031050',
    'Salida': '08069000',
    'Cañon City': '08070000',
    'Montrose': '08051050',
    'Steamboat Springs': '08074000',
    'Vail': '08076000',
    'Durango': '08027000',
    'Breckenridge': '08015000',
    'Aspen': '08021000',
    'Telluride': '08010000',
    'Frisco': '08042000',
    'Eagle': '08025000',
    'Alamosa': '08003000',
    'Wheat Ridge': '08003000',
    'La Junta': '08044000',
    'Elizabeth': '08053000',
    'Brush': '08030000',
    'Fort Morgan': '08051000',
    'Woodland Park': '08081000',
    'Pagosa Springs': '08067000',
    'Delta': '08067000',
    'Westcliffe': '08024000',
    'Silt': '08012000',
    'Glenwood Springs': '08041000'
}


# API endpoint for CitySDK
url = "https://api.citysdk.opendata.arcgis.com/api/v1/cities"

# Parameters for the API request
params = {
    'city': 'Denver',  # Change this to any city you'd like to query
    'state': 'Colorado'  # State name or abbreviation
}

# Make the request to the CitySDK API
response = requests.get(url, params=params)

# Check the response status
if response.status_code == 200:
    # Parse the JSON data
    data = response.json()
    print("Data for Denver:")
    print(json.dumps(data, indent=4))
else:
    print(f"Error: {response.status_code}")
