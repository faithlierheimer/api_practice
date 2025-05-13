with union_data as (
{{ dbt_utils.union_relations(
    relations=[ref('stg_streaming_2012_2019'), ref('stg_streaming_2019_2020'),ref('stg_streaming_2020_2022'),ref('stg_streaming_2022_2024')]
) }}),
genres as (
    select * from {{ ref('stg_genres') }}
),
audio_features as (
    select * from {{ ref('stg_kaggle_audio_features') }}
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
        union_data.artist_name = genres.artist_name),
add_audio_features as (
    select
        add_genres.*,
        audio_features.is_explicit,
        audio_features.danceability,
        audio_features.energy,
        audio_features.track_key,
        audio_features.loudness_decibels,
        audio_features.mode,
        audio_features.speechiness,
        audio_features.acousticness,
        audio_features.instrumentalness,
        audio_features.liveness,
        audio_features.valence,
        audio_features.tempo,
        audio_features.time_signature,
        audio_features.year_released,
        audio_features.release_date
    from
        add_genres
    join
        audio_features
    on
        add_genres.track_name = audio_features.track_name

)

select * from add_audio_features
