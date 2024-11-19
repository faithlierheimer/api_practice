select
    PARSE_TIMESTAMP('%Y-%m-%d %H:%M', date) as weather_date,
    PARSE_TIMESTAMP('%Y-%m-%d %H:%M', last_updated) as last_updated,
    city_name,
    temperature,
    humidity,
    uv,
    concat(city_lat, ',', city_long) as city_lat_long
from
    {{ source('weather_data', 'weather_data') }}

