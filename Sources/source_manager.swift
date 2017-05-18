/// Manages the different sources. Keeps track of them, lists and toggles
class SourceManager {

    private var availableSources: [String: Source] = [
        "arguments": ArgumentsSource()
    ]

    var currentTrack: Track? {
        get {

            for source in enabledSources {
                if let currentTrack = source.currentTrack {
                    return currentTrack
                }
            }

            return nil
        }
    }

    var enabledSources: [Source] {

        // Checks the config and returns an array of sources based on the
        // enabled and available ones

        get {
            var sources = [Source]()

            if let sourceNames = Configuration.sharedInstance["enabled_sources"] as? [String]{
                for sourceName in sourceNames {
                    if let source = availableSources[sourceName] {
                        sources.append(source)
                    }
                }
            }

            return sources
        }
    }

    func enable(sourceName: String) {
    }

    func disable(sourceName: String) {
    }

    func reset(sourceName: String) {
    }

    func getSources(sourceName: String) {
    }
}
