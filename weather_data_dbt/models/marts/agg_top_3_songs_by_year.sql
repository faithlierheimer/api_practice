with ranked_songs as 
(select
    year_played,
    track_name,
    artist_name,
    album_name,
    count(track_name) as times_played,
    row_number() over (partition by year_played order by count(track_name) desc) as rank
from 
     {{ ref("stg_union_spotify_data_2012_2024") }}
group by
    track_name,
    artist_name,
    album_name,
    year_played)

select
    *
from
    ranked_songs
where
    rank <= 3
order by
    year_played,
    rank
