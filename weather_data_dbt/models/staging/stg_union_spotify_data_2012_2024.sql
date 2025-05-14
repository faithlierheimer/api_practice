with union_data as (
{{ dbt_utils.union_relations(
    relations=[ref('stg_streaming_2012_2019'), ref('stg_streaming_2019_2020'),ref('stg_streaming_2020_2022'),ref('stg_streaming_2022_2024')]
) }}),
genres as (
    select * from {{ ref('stg_genres') }}
),

add_genres as (
    select
        union_data.*,
        genres.spotify_id,
        genres.genre_1,
        genres.genre_2,
        genres.genre_3
    from
        union_data
    left join
        genres
    on 
        union_data.artist_name = genres.artist_name)

select * from add_genres
