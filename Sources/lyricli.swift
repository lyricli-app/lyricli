/// The main Lyricli interface
public class Lyricli {
    public static var version = "0.0.0"

    public static var showTitle = false

    public static func printLyrics() {

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

    public static func printSources() {
        print("Listing Sources: Not yet implemented")
    }

    public static func enableSource(_ sourceName: String) {
        print("Enable source \(sourceName): Not yet implemented")
    }

    public static func disableSource(_ sourceName: String) {
        print("Disable source \(sourceName): Not yet implemented")
    }

    public static func resetSource(_ sourceName: String) {
        print("Reset source \(sourceName): Not yet implemented")
    }

    private static func printTitle(_ track: Track) {
        print("\(track.artist) - \(track.name)")
    }
}
