import requests
from nrel_key import nrel_key

# Define the API endpoint and parameters
url = "https://developer.nrel.gov/api/solar/solar_resource/v1.json"
params = {
    "lat": 39.7392,  # Latitude for Denver
    "lon": -104.9903,  # Longitude for Denver
    "api_key": nrel_key
}

# Make the request to the API
response = requests.get(url, params=params)

# Check if the request was successful
if response.status_code == 200:
    data = response.json()
    # Print the results
    print("Solar Resource Data for Denver:")
    print("Annual Direct Normal Irradiance (DNI):", data['outputs']['avg_dni']['annual'])
    print("Monthly DNI:", data['outputs']['avg_dni']['monthly'])
    print("Annual Global Horizontal Irradiance (GHI):", data['outputs']['avg_ghi']['annual'])
    print("Monthly GHI:", data['outputs']['avg_ghi']['monthly'])
else:
    print("Failed to retrieve data:", response.status_code, response.text)
