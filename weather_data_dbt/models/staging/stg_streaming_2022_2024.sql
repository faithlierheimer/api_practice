with source as (

    select * from {{ source('spotify', 'streaming_history_2022_2024') }}

),

renamed as (

    select
           TIMESTAMP(`ts`) as timestamp_played
        ,
            REGEXP_EXTRACT(`platform`, r'\(([^)]+)\)') AS listened_on
        ,
            (`ms_played`/1000) as seconds_played
        ,
            (`ms_played`/60000) as minutes_played
        ,
            `conn_country` as country_listened_in
        ,
            `ip_addr` as ip_address
        ,
            `master_metadata_track_name` as track_name
        ,
            `master_metadata_album_artist_name` as artist_name
        ,
            `master_metadata_album_album_name` as album_name
        ,
            `episode_name` as podcast_episode_name
        ,
            `episode_show_name` as podcast_show_name
        ,
            `reason_start`
        ,
            `reason_end`
        ,
            `shuffle`
        ,
            `skipped`
        ,
            `offline`
        ,
            `offline_timestamp`
    from source

),
breakout_timestamps as (
    select
        DATETIME(timestamp_played, 'America/Denver') AS timestamp_played,
        listened_on,
        seconds_played,
        minutes_played,
        country_listened_in,
        ip_address,
        track_name,
        artist_name,
        album_name,
        podcast_episode_name,
        podcast_show_name,
        reason_start,
        reason_end,
        shuffle,
        skipped,
        offline,
        offline_timestamp

    from
        renamed
),
timestamps_converted as (
    select
        date(timestamp_played) as date_played,
        FORMAT_TIMESTAMP('%Y-%m', timestamp_played) AS year_month_played,
        FORMAT_TIMESTAMP('%H:%M:%S', timestamp_played) AS time_played,
        CASE
            WHEN EXTRACT(HOUR FROM timestamp_played) >= 6 AND EXTRACT(HOUR FROM timestamp_played) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM timestamp_played) >= 12 AND EXTRACT(HOUR FROM timestamp_played) < 18 THEN 'Afternoon'
            WHEN EXTRACT(HOUR FROM timestamp_played) >= 18 AND EXTRACT(HOUR FROM timestamp_played) < 21 THEN 'Evening'
        ELSE 'Night'
        END AS time_of_day,
        listened_on,
        seconds_played,
        minutes_played,
        country_listened_in,
        ip_address,
        track_name,
        artist_name,
        album_name,
        podcast_episode_name,
        podcast_show_name,
        reason_start,
        reason_end,
        shuffle,
        skipped,
        offline,
        offline_timestamp
    from
        breakout_timestamps
)

select * from timestamps_converted