with skipped_songs as (
    select * from  {{ ref("stg_union_spotify_data_2012_2024") }} where skipped is true
)

select 
    track_name,
    artist_name,
    album_name,
    count(track_name) as times_skipped 
from 
    skipped_songs
group by
    track_name,
    artist_name,
    album_name
order by
    count(track_name) desc