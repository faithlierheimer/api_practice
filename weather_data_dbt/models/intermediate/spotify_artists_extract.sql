with all_artists as (
    select 
        distinct artist_name
    from
        {{ ref ('int_union_spotify_data_2012_2024') }}
)

select * from all_artists