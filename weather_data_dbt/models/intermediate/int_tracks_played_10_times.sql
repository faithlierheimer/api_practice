with track_play_counts_over_10 as (
select 
    track_name,
    artist_name,
    count(track_name) as track_play_count
from 
    {{ ref ('int_union_spotify_data_2012_2024')}}
where
    track_name is not null
group by
    track_name,
    artist_name
where
    track_play_count > 10)

select * from track_play_counts_over_10

    