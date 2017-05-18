/// The main Lyricli interface
public class Lyricli {
    public static var version = "0.0.0-feature/option-parsing"

    public static func printLyrics() {

        let sourceManager = SourceManager()

        if let currentTrack = sourceManager.currentTrack {
            print(currentTrack.artist)
            print(currentTrack.name)
        }
        else {
            print("Current track not found")
        }
    }

    public static func printTitle() {
        print("Getting Song Title: Not yet implemented")
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
}
