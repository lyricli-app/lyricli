import Foundation

/// Handles reading and writing the configuration
public class Configuration {

    let configurationPath = NSString(string: "~/.lyricli.conf").expandingTildeInPath

    // The defaults are added here

    private var configuration: [String: Any] =  [
        "enabled_sources": ["arguments"],
        "default": true
    ]

    static let sharedInstance: Configuration = Configuration()

    private init() {

        // Read the config file and attempt toset any of the values. Otherwise
        // Don't do anything.
        // IMPROVEMENT: Enable a debug mode

        if let data = try? NSData(contentsOfFile: configurationPath) as Data {
            if let parsedConfig = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                for (key, value) in parsedConfig {

                    if key == "enabled_sources" {
                        configuration[key] = value as! [String]
                    }
                    else {
                        configuration[key] = value as! String
                    }
                }
            }
        }

        writeConfiguration()
    }

    private func writeConfiguration() {

        var error: NSError?

        if let outputStream = OutputStream(toFileAtPath: configurationPath, append: false) {
            outputStream.open()
            JSONSerialization.writeJSONObject(configuration, to: outputStream, options: [JSONSerialization.WritingOptions.prettyPrinted], error: &error)
            outputStream.close()
        }
    }

    // Allow access as an object
    subscript(index: String) -> Any? {
        get {
            return configuration[index]
        }

        set(newValue) {
            configuration[index] = newValue
            writeConfiguration()
        }
    }
}
