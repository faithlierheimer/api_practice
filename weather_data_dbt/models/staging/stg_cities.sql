select
    *
from
    {{ source('prod_weather_data', 'city_ref') }}