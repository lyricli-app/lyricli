import CommandLineKit
import Foundation

/// Sets up and returns a new options parser
/// 
/// - Returns: A new OptionParser instance
func createParser() -> ([String:Option], CommandLineKit) {

    let parser = CommandLineKit()
    var flags: [String:Option] = [:]

    flags["help"] = BoolOption(shortFlag: "h", longFlag: "help", helpMessage: "Prints a help message.")

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

}

main()
