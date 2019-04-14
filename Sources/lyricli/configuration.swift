import Foundation

// Reads and writes the configuration. Config keys are accessed as a dictionary.
class Configuration {
    // Location of the global configuration file
    private let configurationPath = NSString(string: "~/.lyricli.conf").expandingTildeInPath

    // Default options, will be automatically written to the global config if
    // not found.
    private var configuration: [String: Any] =  [
        "enabled_sources": ["itunes", "spotify"]
    ]

    // The shared instance of the object
    static let shared: Configuration = Configuration()

    private init() {

        // Read the config file and attempt to set any of the values. Otherwise
        // don't do anything.

        if let data = try? NSData(contentsOfFile: configurationPath) as Data {
            if let parsedConfig = try? JSONSerialization.jsonObject(with: data) {
                if let parsedConfig = parsedConfig as? [String: Any] {
                    for (key, value) in parsedConfig {

                        if key == "enabled_sources" {
                            if let value = value as? [String] {
                                configuration[key] = value
                            }
                        } else {
                            if let value = value as? String {
                                configuration[key] = value
                            }
                        }
                    }
                }
            }
        }

        writeConfiguration()
    }

    // Write the configuration back to the file
    private func writeConfiguration() {

        var error: NSError?

        if let outputStream = OutputStream(toFileAtPath: configurationPath, append: false) {
            outputStream.open()
            JSONSerialization.writeJSONObject(configuration,
                    to: outputStream,
                    options: [JSONSerialization.WritingOptions.prettyPrinted],
                    error: &error)
            outputStream.close()
        }
    }

    // Allow access to the config properties as a dictionary
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
