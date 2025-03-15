with source as (

    select * from {{ source('spotify', 'streaming_history_2020_2022') }}

),

renamed as (

    select
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
        ,
        TIMESTAMP(`ts`) as timestamp_played
        ,
        REGEXP_EXTRACT(`platform`, r'\(([^)]+)\)') as listened_on
        ,
        (`ms_played` / 1000) as seconds_played
        ,
        (`ms_played` / 60000) as minutes_played
    from source

),

breakout_timestamps as (
    select
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
        offline_timestamp,
        DATETIME(timestamp_played, 'America/Denver') as timestamp_played

    from
        renamed
),

timestamps_converted as (
    select
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
        offline_timestamp,
        DATE(timestamp_played) as date_played,
        FORMAT_TIMESTAMP('%Y', timestamp_played) as year_played,
        FORMAT_TIMESTAMP('%Y-%m', timestamp_played) as year_month_played,
        FORMAT_TIMESTAMP('%H:%M:%S', timestamp_played) as time_played,
        case
            when EXTRACT(hour from timestamp_played) >= 6 and EXTRACT(hour from timestamp_played) < 12 then 'Morning'
            when EXTRACT(hour from timestamp_played) >= 12 and EXTRACT(hour from timestamp_played) < 18 then 'Afternoon'
            when EXTRACT(hour from timestamp_played) >= 18 and EXTRACT(hour from timestamp_played) < 21 then 'Evening'
            else 'Night'
        end as time_of_day
    from
        breakout_timestamps
)

select * from timestamps_converted