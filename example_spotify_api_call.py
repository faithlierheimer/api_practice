from spotipy import Spotify
from spotipy.oauth2 import SpotifyClientCredentials
import spotify_key 
import pandas as pd 
import time
from spotipy.exceptions import SpotifyException
import requests


# Set up authentication
auth_manager = SpotifyClientCredentials(
    client_id=spotify_key.SPOTIFY_CLIENT_ID,
    client_secret=spotify_key.SPOTIFY_CLIENT_SECRET
)

# Initialize the Spotify client
sp = Spotify(auth_manager=auth_manager)

# Read in my artists 
faith_spotify_artists = pd.read_csv('faith_spotify_artists.csv')

#convert to list
faith_spotify_artists = faith_spotify_artists['artist_name'].dropna().tolist()

#list too long! try first 100

faith_spotify_artists_first_100 = faith_spotify_artists[:100]

results = []
artist_progress = 1

for artist_name in faith_spotify_artists:
    try:
        result = sp.search(q=artist_name, type="artist", limit=1)
        items = result['artists']['items']
        if items:
            artist = items[0]
            results.append({
                "input_name": artist_name,
                "matched_name": artist["name"],
                "spotify_id": artist["id"],
                "genres": ", ".join(artist["genres"])
            })
        else:
            results.append({
                "input_name": artist_name,
                "matched_name": None,
                "spotify_id": None,
                "genres": None
            })
        print(f'Appended {artist_name} to dataframe. Record {artist_progress}')

        time.sleep(1)  
        artist_progress = artist_progress + 1

    except SpotifyException as e:
        if e.http_status == 429:
            retry_after = int(e.headers.get("Retry-After", 10))
            print(f"Rate limited. Sleeping for {retry_after} seconds...")
            time.sleep(retry_after + 1)
        else:
            print(f"Spotify error: {e}")
            time.sleep(5)
    except requests.exceptions.RequestException as e:
        print(f"Request error: {e}")
        time.sleep(10)

df_results = pd.DataFrame(results)

df_results.to_csv("spotify_artist_genres.csv", index=False)


