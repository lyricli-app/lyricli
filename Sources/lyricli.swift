// The main class, handles all the actions that the executable will call
class Lyricli {

    // Version of the application
    static var version = "0.3.0"

    // Flag that controls whether we should show the track artist and name before
    // the lyrics
    static var showTitle = false

    // Obtains the name of the current track from a source, fetches the lyrics
    // from an engine and prints them
    static func printLyrics() {

        let sourceManager = SourceManager()

        if let currentTrack = sourceManager.currentTrack {
            let engine = LyricsEngine(withTrack: currentTrack)

            if let lyrics = engine.lyrics {
                if showTitle {
                    printTitle(currentTrack)
                }

                print(lyrics)
            } else {
                print("Lyrics not found :(")
            }

        } else {
            print("No Artist/Song could be found :(")
        }
    }

    // Print the currently available sources
    static func printSources() {
        print("Listing Sources: Not yet implemented")
    }

    // Runs the enable method of a source and writes the configuration to set it
    // as enabled
    static func enableSource(_ sourceName: String) {
        print("Enable source \(sourceName): Not yet implemented")
    }

    // Remove a source from the enabled sources configuration
    static func disableSource(_ sourceName: String) {
        print("Disable source \(sourceName): Not yet implemented")
    }

    // Removes any configuration for a source, and disables it
    static func resetSource(_ sourceName: String) {
        print("Reset source \(sourceName): Not yet implemented")
    }

    // Prints the track artist and name
    private static func printTitle(_ track: Track) {
        print("\(track.artist) - \(track.name)")
    }
}
