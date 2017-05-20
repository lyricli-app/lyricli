// Source that reads track artist and name from the command line
class ArgumentsSource: Source {

    // Returns a track based on the arguments. It assumes the track artist
    // will be the first argument, and the name will be the second, excluding
    // any flags.
    var currentTrack: Track? {

        if CommandLine.arguments.count >= 3 {
            // expected usage: $ ./lyricli <artist> <name>
            let trackName: String = CommandLine.arguments[2]
            let trackArtist: String = CommandLine.arguments[1]

            return Track(withName: trackName, andArtist: trackArtist)
        }
        return nil
    }
}
