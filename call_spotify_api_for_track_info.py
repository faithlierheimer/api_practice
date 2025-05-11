from spotipy import Spotify
import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
from spotipy.oauth2 import SpotifyOAuth
import spotify_key 
import pandas as pd 
import time
from spotipy.exceptions import SpotifyException
import requests



# User-authenticated client (for search)
sp = spotipy.Spotify(auth_manager=SpotifyOAuth(
    client_id=spotify_key.SPOTIFY_CLIENT_ID,
    client_secret=spotify_key.SPOTIFY_CLIENT_SECRET,
    redirect_uri="http://127.0.0.1:8888/callback",
    scope="user-library-read"
))

# App-authenticated client (for audio features)
# app_sp = spotipy.Spotify(auth_manager=SpotifyClientCredentials(
#     client_id=spotify_key.SPOTIFY_CLIENT_ID,
#     client_secret=spotify_key.SPOTIFY_CLIENT_SECRET,
# ))

# Read in my tracks that i've played at least 10x 
faith_spotify_tracks = pd.read_csv('tracks_played_at_least_10_times.csv')

#convert to list
faith_spotify_tracks_names = faith_spotify_tracks['track_name'].dropna().tolist()

#grab 10 items to test call
faith_spotify_tracks_names_first_1 = faith_spotify_tracks_names[:1]


results = []
track_progress = 1

for track_name in faith_spotify_tracks_names_first_1:
    try:
        # 1. Search for the track name
        result = sp.search(q=track_name, type="track", limit=1)
        if not result["tracks"]["items"]:
            print(f"No track found for {track_name}")
            continue

        # 2. Extract the track ID
        track = result["tracks"]["items"][0]
        track_id = track["id"]
        print(track_id)
        # 3. Get audio features for that track ID
        audio_features = sp.audio_features([track_id])[0]
        print(audio_features)

        if audio_features is None:
            print(f"No audio features returned for {track_name} (ID: {track_id})")
            continue

        # 4. Save to results
        results.append({
            "input_name": track_name,
            "spotify_id": track_id,
            "acousticness": audio_features["acousticness"],
            "danceability": audio_features["danceability"],
            "energy": audio_features["energy"],
            "tempo": audio_features["tempo"],
            "valence": audio_features["valence"]
        })

        print(f"Appended {track_name} to dataframe. Record {track_progress}")
        track_progress += 1
        time.sleep(1)  # to respect rate limits

    except SpotifyException as e:
        print(f"Spotify API error: {e}")
        time.sleep(5)
    except Exception as e:
        print(f"General error: {e}")
        time.sleep(5)

# Save final results
df_results = pd.DataFrame(results)
df_results.to_csv("spotify_track_characteristics.csv", index=False)

