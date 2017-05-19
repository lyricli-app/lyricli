import CommandLineKit
import Foundation

func main() {
    let (flags, parser) = createParser()

    do {
        try parser.parse()
    } catch {
        parser.printUsage(error)
        exit(EX_USAGE)
    }

    // Boolean Options

    checkHelpFlag(flags["help"], withParser: parser)
    checkVersionFlag(flags["version"], withParser: parser)
    checkListSourcesFlag(flags["listSources"], withParser: parser)
    checkTitleFlag(flags["title"], withParser: parser)

    // String Options

    checkEnableSourceFlag(flags["enableSource"], withParser: parser)
    checkDisableSourceFlag(flags["disableSource"], withParser: parser)
    checkResetSourceFlag(flags["resetSource"], withParser: parser)

    // Remove any flags so anyone after this gets the unprocessed values

    let programName: [String] = [CommandLine.arguments[0]]
    CommandLine.arguments = programName + parser.unparsedArguments

    // Run Lyricli

    Lyricli.printLyrics()
}

/// Sets up and returns a new options parser
/// 
/// - Returns: A Dictionary of Options, and a new CommandLineKit instance
private func createParser() -> ([String:Option], CommandLineKit) {
    let parser = CommandLineKit()
    var flags: [String:Option] = [:]

    flags["help"] = BoolOption(shortFlag: "h", longFlag: "help", helpMessage: "Prints a help message.")
    flags["version"] = BoolOption(shortFlag: "v", longFlag: "version", helpMessage: "Prints the version.")

    flags["enableSource"] = StringOption(shortFlag: "e", longFlag: "enable-source", helpMessage: "Enables a source")
    flags["disableSource"] = StringOption(shortFlag: "d", longFlag: "disable-source", helpMessage: "Disables a source")
    flags["resetSource"] = StringOption(shortFlag: "r", longFlag: "reset-source", helpMessage: "Resets a source")
    flags["listSources"] = BoolOption(shortFlag: "l", longFlag: "list-sources", helpMessage: "Lists all sources")

    flags["title"] = BoolOption(shortFlag: "t", longFlag: "title", helpMessage: "Shows title of song if true")

    parser.addOptions(Array(flags.values))

    parser.formatOutput = {parseString, type in

        var formattedString: String

        switch type {
        case .About:
            formattedString = "\(parseString) [<artist_name> <song_name>]"
            break
        default:
            formattedString = parseString
        }

        return parser.defaultFormat(formattedString, type: type)
    }

    return (flags, parser)
}

// Handle the Help flag

private func checkHelpFlag(_ flag: Option?, withParser parser: CommandLineKit) {
    if let helpFlag = flag as? BoolOption {
        if helpFlag.value {
            parser.printUsage()
            exit(0)
        }
    }
}

// Handle the version flag

private func checkVersionFlag(_ flag: Option?, withParser parser: CommandLineKit) {
    if let versionFlag = flag as? BoolOption {
        if versionFlag.value {
            print(Lyricli.version)
            exit(0)
        }
    }
}

// Handle the list sources flag

private func checkListSourcesFlag(_ flag: Option?, withParser parser: CommandLineKit) {
    if let listSourcesFlag = flag as? BoolOption {
        if listSourcesFlag.value {
            Lyricli.printSources()
            exit(0)
        }
    }
}

// Handle the title flag

private func checkTitleFlag(_ flag: Option?, withParser parser: CommandLineKit) {
    if let titleFlag = flag as? BoolOption {
        if titleFlag.value {
            Lyricli.showTitle = true
        }
    }
}

// Handle the enable source flag

private func checkEnableSourceFlag(_ flag: Option?, withParser parser: CommandLineKit) {
    if let enableSourceFlag = flag as? StringOption {
        if let source = enableSourceFlag.value {
            Lyricli.enableSource(source)
            exit(0)
        }
    }
}

// Handle the disable source flag

private func checkDisableSourceFlag(_ flag: Option?, withParser parser: CommandLineKit) {
    if let disableSourceFlag = flag as? StringOption {
        if let source = disableSourceFlag.value {
            Lyricli.disableSource(source)
            exit(0)
        }
    }
}

// Handle the reset source flag

private func checkResetSourceFlag(_ flag: Option?, withParser parser: CommandLineKit) {
    if let resetSourceFlag = flag as? StringOption {
        if let source = resetSourceFlag.value {
            Lyricli.resetSource(source)
            exit(0)
        }
    }
}

main()
