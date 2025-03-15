-- i don't know if i really need this staging model, i'm just gonna have one in case i need it later. 
select *
from
    {{ source('prod_weather_data', 'city_ref') }}