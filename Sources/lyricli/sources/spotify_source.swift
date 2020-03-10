import ScriptingBridge

// Protocol to obtain the track from Spotify
@objc protocol SpotifyTrack {
    @objc optional var name: String {get}
    @objc optional var artist: String {get}
}

// Protocol to interact with Spotify
@objc protocol SpotifyApplication {
    @objc optional var currentTrack: SpotifyTrack? {get}
}

extension SBApplication: SpotifyApplication {}

// Source that reads track artist and name from current Spotify track
class SpotifySource: Source {

    // Calls the spotify API and returns the current track
    var currentTrack: Track? {

        if let spotify: SpotifyApplication = SBApplication(bundleIdentifier: "com.spotify.client") {
            if let application = spotify as? SBApplication {
              if !application.isRunning {
                return nil
              }
            }

            // Attempt to fetch the title from a song

            if let currentTrack = spotify.currentTrack {
                if let track = currentTrack {
                    if let name = track.name {
                        if let artist = track.artist {

                            return Track(withName: name, andArtist: artist)
                        }
                    }
                }
            }
        }

        return nil
    }

}
