select 
    album_name,
    artist_name,
    count(track_name) as times_played 
from 
    {{ ref("int_union_spotify_data_2012_2024") }}
group by
    album_name,
    artist_name
order by
    count(track_name) desc