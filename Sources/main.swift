import CommandLineKit
import Foundation

/// Sets up and returns a new options parser
/// 
/// - Returns: A Dictionary of Options, and a new CommandLineKit instance
func createParser() -> ([String:Option], CommandLineKit) {

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

        switch(type) {
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

func main() {

    let (flags, parser) = createParser()

    do {
        try parser.parse()
    }
    catch {
        parser.printUsage(error)
        exit(EX_USAGE)
    }

    if let helpFlag = flags["help"] as? BoolOption {
        if helpFlag.value == true {
            parser.printUsage()
            exit(0)
        }
    }

    if let versionFlag = flags["version"] as? BoolOption {
        if versionFlag.value == true {
            print(Lyricli.version)
            exit(0)
        }
    }

    if let listSourcesFlag = flags["listSources"] as? BoolOption {
        if listSourcesFlag.value == true {
            Lyricli.printSources()
            exit(0)
        }
    }

    if let enableSourceFlag = flags["enableSource"] as? StringOption {
        if let source = enableSourceFlag.value {
            Lyricli.enableSource(source)
            exit(0)
        }
    }

    if let disableSourceFlag = flags["disableSource"] as? StringOption {
        if let source = disableSourceFlag.value {
            Lyricli.disableSource(source)
            exit(0)
        }
    }

    if let resetSourceFlag = flags["resetSource"] as? StringOption {
        if let source = resetSourceFlag.value {
            Lyricli.resetSource(source)
            exit(0)
        }
    }

    if let titleFlag = flags["title"] as? BoolOption {
        if titleFlag.value == true {
            Lyricli.showTitle = true
        }
    }

    // Remove any flags so anyone after this gets the unprocessed values
    let programName: [String] = [CommandLine.arguments[0]]
    CommandLine.arguments = programName + parser.unparsedArguments

    Lyricli.printLyrics()
}

main()
