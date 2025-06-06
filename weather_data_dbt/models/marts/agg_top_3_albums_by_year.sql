with ranked_albums as 
(select
    year_played,
    album_name,
    artist_name,
    count(track_name) as times_played,
    row_number() over (partition by year_played order by count(track_name) desc) as rank
from 
    {{ ref("int_union_spotify_data_2012_2024") }}
group by
    album_name,
    artist_name,
    year_played)

select
    *
from
    ranked_albums
where
    rank <= 3
order by
    year_played,
    rank
