/// Source that deals with command line
class ArgumentsSource: Source {
    public var currentTrack: Track? {
        get {
            if CommandLine.arguments.count >= 3 {

                // expected usage: $ ./lyricli <artist> <name>

                let trackName: String = CommandLine.arguments[2]
                let trackArtist: String = CommandLine.arguments[1]

                return Track(withName: trackName, andArtist: trackArtist)
            }
            return nil
        }
    }
}
