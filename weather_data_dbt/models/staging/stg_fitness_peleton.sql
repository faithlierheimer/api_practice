with source as (
        select * from {{ source('fitness', 'peleton') }}
  ),
  renamed as (
      select
        {{ adapter.quote("Timestamp") }} as class_taken_at,
        {{ adapter.quote("class_type") }},
        {{ adapter.quote("instructor_name") }},
        {{ adapter.quote("length_min") }},
        {{ adapter.quote("fitness_discipline") }},
        {{ adapter.quote("fitness_subtype") }},
        {{ adapter.quote("class_title") }},
        {{ adapter.quote("class_timestamp") }} as class_published_at,
        {{ adapter.quote("total_output") }},
        {{ adapter.quote("avg_watts") }},
        {{ adapter.quote("avg_resistance") }},
        {{ adapter.quote("avg_cadence") }},
        {{ adapter.quote("avg_speed") }},
        {{ adapter.quote("distance_mi") }},
        {{ adapter.quote("cals_burned") }},
        {{ adapter.quote("avg_hr") }},
        {{ adapter.quote("avg_incline") }},
        {{ adapter.quote("avg_pace_min_mi") }}

      from source
  )
  select * from renamed
    