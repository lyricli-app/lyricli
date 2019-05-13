import Bariloche

class LyricliCommand: Command {
    let usage: String? = "Fetch the lyrics for current playing track or the one specified via arguments"

    // Flags
    let version = Flag(short: "v", long: "version", help: "Prints the version.")
    let showTitle = Flag(short: "t", long: "title", help: "Shows title of song if true")
    let listSources = Flag(short: "l", long: "list", help: "Lists all sources")

    // Named Arguments
    let enableSource = Argument<String>(name: "source",
        kind: .named(short: "e", long: "enable"),
        optional: true,
        help: "Enables a source")
    let disableSource = Argument<String>(name: "source",
        kind: .named(short: "d", long: "disable"),
        optional: true,
        help: "Disables a source")
    let resetSource = Argument<String>(name: "source",
        kind: .named(short: "r", long: "reset"),
        optional: true,
        help: "Resets a source")

    // Positional Arguments
    let artist = Argument<String>(name: "artist",
        kind: .positional,
        optional: true,
        help: "The name of the artist")
    let trackName = Argument<String>(name: "trackName",
        kind: .positional,
        optional: true,
        help: "The name of the track")

    func run() -> Bool {
        return true
    }
}
