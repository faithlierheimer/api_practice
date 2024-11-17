--create a view that just has city key & temp/weather/humidity
select
    cities.city_key,
    weather.weather_date,
    weather.temperature,
    weather.uv,
    weather.humidity
from
    {{ ref('stg_weather_data') }} as weather
inner join
    {{ ref('stg_cities') }} as cities
    on weather.city_lat_long = cities.city_lat_long