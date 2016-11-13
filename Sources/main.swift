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

    parser.addOptions(Array(flags.values))

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

}

main()
