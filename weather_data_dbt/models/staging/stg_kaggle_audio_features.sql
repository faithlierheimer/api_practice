with source as (

    select * from {{ source('spotify', 'kaggle_track_features') }}

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

)

select * from renamed