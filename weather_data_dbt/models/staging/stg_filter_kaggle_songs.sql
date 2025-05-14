with source as (

    select * from {{ source('spotify', 'kaggle_track_features') }}

),

unioned_spotify_data as (
    select * from  {{ ref("stg_union_spotify_data_2012_2024") }}
),

renamed as (

    select

        `id` as spotify_id,
        `name` as track_name,
        `album` as album_name,
        `album_id` as album_id,
        `artists`as artist_name,
        `artist_ids`as artist_ids,
        `track_number` as track_number,
        `disc_number` as disc_number,
        `explicit` as is_explicit,
        `danceability` as danceability,
        `energy` as energy,
        `key` as track_key,
        `loudness` as loudness_decibels,
        `mode` as mode,
        `speechiness` as speechiness,
        `acousticness` as acousticness,
        `instrumentalness` as instrumentalness,
        `liveness` as liveness,
        `valence` as valence,
        `tempo` as tempo,
        `duration_ms` as duration_ms,
        `time_signature` as time_signature,
        `year` as year_released,
        `release_date` as release_date
    from source

),
filtered as (
    select
        union_data.*,

)

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