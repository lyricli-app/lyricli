// Collect and manage the available and enabled source
class SourceManager {

    // List of sources enabled for the crurent platform
    private var availableSources: [String: Source] = [
        "arguments": ArgumentsSource(),
        "itunes": ItunesSource()
    ]

    // Iterate over the sources until we find a track or run out of sources
    var currentTrack: Track? {
        for source in enabledSources {
            if let currentTrack = source.currentTrack {
                return currentTrack
            }
        }

        return nil
    }

    // Return the list of enabled sources based on the configuration
    var enabledSources: [Source] {

        // Checks the config and returns an array of sources based on the
        // enabled and available ones

        var sources = [Source]()

        if let sourceNames = Configuration.shared["enabled_sources"] as? [String] {
            for sourceName in sourceNames {
                if let source = availableSources[sourceName] {
                    sources.append(source)
                }
            }
        }

        return sources
    }

    // Given a source name, it will enable it and add it to the enabled sources config
    func enable(sourceName: String) {
    }

    // Given a source name, it will remove it from the enabled sources config
    func disable(sourceName: String) {
    }

    // Given a source name, it removes any stored configuration and disables it
    func reset(sourceName: String) {
    }
}
