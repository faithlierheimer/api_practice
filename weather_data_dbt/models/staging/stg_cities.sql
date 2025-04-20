-- i don't know if i really need this staging model, i'm just gonna have one in case i need it later. 
select *
from
    {{ source('weather_data', 'city_ref') }}