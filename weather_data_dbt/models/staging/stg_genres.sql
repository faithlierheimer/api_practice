with matched_artists_only as (
    select
        *
    from 
        {{ ref('spotify_artist_genres') }} where input_name = matched_name
),

dedupe_artists as (
    select
        matched_name as artist_name,
        spotify_id as spotify_id,
        genres 
    from
        matched_artists_only
),

handle_multiple_genres as (
    select
        artist_name,
        spotify_id,
        SPLIT(genres, ', ')[SAFE_OFFSET(0)] AS genre_1,
        SPLIT(genres, ', ')[SAFE_OFFSET(1)] AS genre_2,
        SPLIT(genres, ', ')[SAFE_OFFSET(2)] AS genre_3
    from
        dedupe_artists
)

select * from handle_multiple_genres