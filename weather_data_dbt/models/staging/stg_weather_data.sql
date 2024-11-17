select
  date as weather_date,
  last_updated,
  city_name,
  concat(city_lat, ',', city_long) as city_lat_long,
  temperature,
  humidity,
  uv
from
  {{ source('weather_data', 'weather_data') }} as weather  

