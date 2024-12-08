{{ config(
    materialized='table'
) }}
--grab all distinct city lats/longs ()
with distinct_cities as (
select
    city_name,
    city_lat,
    city_long,
    concat(city_lat, ',', city_long) as city_lat_long 
from 
    {{ source('weather_data', 'weather_data') }}
group by
    city_name,
    city_lat,
    city_long
order by
    city_name
),

final as (
select
    {{ dbt_utils.generate_surrogate_key(['city_name', 'city_lat_long']) }} as city_key,
    *
from
    distinct_cities

)

select * from final


