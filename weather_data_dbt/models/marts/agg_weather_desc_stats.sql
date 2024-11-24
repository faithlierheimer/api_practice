with weather as (
select 
    * 
from
    {{ ref('int_weather_fact') }})

select 
    cities.city_name,
    cities.city_lat_long,
    cities.city_lat,
    cities.city_long,
    FORMAT_TIMESTAMP('%Y-%m-%d', weather_date) AS formatted_date,
    min(temperature) as min_temp,
    max(temperature) as max_temp,
    avg(temperature) as avg_temp,
    min(uv) as min_uv,
    max(uv) as max_uv,
    avg(uv) as avg_uv,
    min(humidity) as min_humidity,
    max(humidity) as max_humidity,
    avg(humidity) as avg_humidity
from 
    weather
join {{ ref('stg_cities')}} as cities
on weather.city_key = cities.city_key
group by
    city_name,
    city_lat_long,
    city_lat,
    city_long,
    FORMAT_TIMESTAMP('%Y-%m-%d', weather_date)
order by
    city_name,
    formatted_date