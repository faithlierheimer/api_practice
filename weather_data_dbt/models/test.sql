select 
    cities.city_name,
    weather.weather_date,
    weather.temperature
from
    {{ref('stg_cities')}} as cities
join
    {{ref('int_weather_fact')}} as weather
on
    cities.city_key = weather.city_key
where 
    cities.city_name = 'Denver'
