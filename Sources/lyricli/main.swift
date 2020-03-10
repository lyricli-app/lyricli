import Foundation
import Bariloche

// Entry point of the application. This is the main executable
private func main() {

    // Bariloche assumes at least one argument, so bypass
    // if that's the case.
    if CommandLine.arguments.count > 1 {
        let parser = Bariloche(command: LyricliCommand())
        let result = parser.parse()

        if result.count == 0 {
            exit(EX_USAGE)
        }

        if let lyricliCommand = result[0] as? LyricliCommand {
            // Flags
            checkVersionFlag(lyricliCommand)
            checkListSourcesFlag(lyricliCommand)
            checkTitleFlag(lyricliCommand)

            // String Options

            checkEnableSourceFlag(lyricliCommand)
            checkDisableSourceFlag(lyricliCommand)
            checkResetSourceFlag(lyricliCommand)

            checkPositionalArguments(lyricliCommand)

        }
    }

    // Run Lyricli
    Lyricli.printLyrics()
}

// Handle the version flag

private func checkVersionFlag(_ command: LyricliCommand) {
    if command.version.value {
        print(Lyricli.version)
        exit(0)
    }
}

// Handle the list sources flag

private func checkListSourcesFlag(_ command: LyricliCommand) {
    if command.listSources.value {
        Lyricli.printSources()
        exit(0)
    }
}

// Handle the title flag

private func checkTitleFlag(_ command: LyricliCommand) {
    Lyricli.showTitle = command.showTitle.value
}

// Handle the enable source flag

private func checkEnableSourceFlag(_ command: LyricliCommand) {
    if let source = command.enableSource.value {
        Lyricli.enableSource(source)
        exit(0)
    }
}

// Handle the disable source flag

private func checkDisableSourceFlag(_ command: LyricliCommand) {
    if let source = command.disableSource.value {
        Lyricli.disableSource(source)
        exit(0)
    }
}

// Handle the reset source flag

private func checkResetSourceFlag(_ command: LyricliCommand) {
    if let source = command.resetSource.value {
        Lyricli.resetSource(source)
        exit(0)
    }
}

// Handle the positional arguments

private func checkPositionalArguments(_ command: LyricliCommand) {
    if let artist = command.artist.value {

        let currentTrack: Track

        if let trackName = command.trackName.value {
            currentTrack = Track(withName: trackName, andArtist: artist)
        } else {
            currentTrack = Track(withName: "", andArtist: artist)
        }

        Lyricli.printLyrics(currentTrack)
        exit(0)
    }
}

main()
