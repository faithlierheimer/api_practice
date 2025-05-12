<!-- Table-level documentation -->
{% docs agg_top_3_albums_by_year %}

{% enddocs %}

<!-- Column-level documentation -->
{% docs year_played %}
This field is derived from the "ts" field on Spotify's raw listening history JSON dumps that you can request from [your Spotify account](https://support.spotify.com/us/article/data-rights-and-privacy-settings/). I split it out into years so I can see the evolution of my music taste. 

{% enddocs %}

{% docs album_name %}
This field corresponds to the master_metadata_album_album_name on Spotify's raw listening history JSON dumps that you can request from [your Spotify account](https://support.spotify.com/us/article/data-rights-and-privacy-settings/). Gotta love how much they overcomplicate the column name! I bet there's an internal reason for it though. 

{% enddocs %}

{% docs artist_name %}

This field corresponds to the master_metadata_album_artist_name on Spotify's raw listening history JSON dumps that you can request from [your Spotify account](https://support.spotify.com/us/article/data-rights-and-privacy-settings/). Gotta love how much they overcomplicate the column name! I bet there's an internal reason for it though. 

{% enddocs %}

{% docs track_name %}
This field corresponds to the master_metadata_track_name on Spotify's raw listening history JSON dumps that you can request from [your Spotify account](https://support.spotify.com/us/article/data-rights-and-privacy-settings/).

{% enddocs %}

{% docs times_played %}
I renamed the field master_metadata_track_name from Spotify's raw listening history JSON dumps that you can request from [your Spotify account](https://support.spotify.com/us/article/data-rights-and-privacy-settings/). Then, I counted the track name and grouped it by different fields depending on whether I was aggregating albums or artists or songs. No count distinct because we'd expect track names to appear multiple times because I played them multiple times. 
{% enddocs %}

{% docs rank %}
This is a derived field. I got it by partitioning my data based on year & times_played. A row will get ranked as 1 if it has the most times played out of that year. Depending on the table this is in, it'll also be grouped by album name, or artist, or song. 

{% enddocs %}