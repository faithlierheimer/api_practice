{{ config(
    materialized='table'
) }}
select
    zillow.city_normalized as zillow_city,
    cities.city_name,
    zillow.month as month_recorded,
    zillow.value as no_houses_for_sale,
    cities.city_lat,
    cities.city_long,
    cities.city_key
from
    {{ref('int_pivot_zillow')}} as zillow
join
    {{ref('stg_cities')}} as cities
on
    zillow.city_normalized = cities.city_name