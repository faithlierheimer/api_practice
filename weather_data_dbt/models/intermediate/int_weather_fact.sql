select
  cities.city_key,
  weather.weather_date,
  weather.temperature,
  weather.uv,
  weather.humidity
FROM
  {{ ref('stg_weather_data') }} AS weather
JOIN
  {{ ref('stg_cities') }} AS cities
  ON weather.city_lat_long = cities.city_lat_long