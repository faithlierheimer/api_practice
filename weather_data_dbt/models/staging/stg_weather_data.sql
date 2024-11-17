select
    date as weather_date,
    last_updated,
    city_name,
    temperature,
    humidity,
    uv,
    concat(city_lat, ',', city_long) as city_lat_long
from
    {{ source('weather_data', 'weather_data') }}

