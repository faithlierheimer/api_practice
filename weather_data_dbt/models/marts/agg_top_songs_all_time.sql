select 
    track_name,
    artist_name,
    album_name,
    count(track_name) as times_played 
from 
     {{ ref("stg_union_spotify_data_2012_2024") }}
group by
    track_name,
    artist_name,
    album_name
order by
    count(track_name) desc