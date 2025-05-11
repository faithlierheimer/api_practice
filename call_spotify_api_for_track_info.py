from spotipy import Spotify
from spotipy.oauth2 import SpotifyClientCredentials
from spotipy.oauth2 import SpotifyOAuth
import spotify_key 
import pandas as pd 
import time
from spotipy.exceptions import SpotifyException
import requests


# Set up authentication--change it up so i can access track info
auth_manager = SpotifyOAuth(
    client_id=spotify_key.SPOTIFY_CLIENT_ID,
    client_secret=spotify_key.SPOTIFY_CLIENT_SECRET,
    redirect_uri="http://127.0.0.1:8888/callback",
    scope="user-library-read user-read-private playlist-read-private"
)


# Initialize the Spotify client
sp = Spotify(auth_manager=auth_manager)

# Read in my tracks that i've played at least 10x 
faith_spotify_tracks = pd.read_csv('tracks_played_at_least_10_times.csv')

#convert to list
faith_spotify_tracks_names = faith_spotify_tracks['track_name'].dropna().tolist()

#grab 10 items to test call
faith_spotify_tracks_names_first_10 = faith_spotify_tracks_names[:10]


results = []
track_progress = 1

for track_name in faith_spotify_tracks_names_first_10:
    try:
        # Search for the track by name
        result = sp.search(q=track_name, type="track", limit=1)
        print(f"Search result for {track_name}: {result}")

        
        # Extract the track ID from the search results
        track = result['tracks']['items'][0]
        track_id = track['id']
        print(f"Track found: {track['name']} with ID: {track_id}")
        
        # Now get audio features for the track
        audio_features = sp.audio_features([track_id])[0]  # single track, so we use index 0
        
        # Append the results to the list
        results.append({
            "input_name": track_name,
            "spotify_id": track_id,
            "acousticness": audio_features['acousticness'],
            "danceability": audio_features['danceability'],
            "energy": audio_features['energy'],
            "tempo": audio_features['tempo'],
            "valence": audio_features['valence']
        })

        print(f"Appended {track_name} to dataframe. Record {track_progress}")
        time.sleep(1)
        track_progress += 1

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

# Convert results to DataFrame and save as CSV
df_results = pd.DataFrame(results)
df_results.to_csv("spotify_track_characteristics.csv", index=False)


