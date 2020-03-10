import ScriptingBridge
import Foundation

// Protocol to obtain the track from iTunes
@objc protocol iTunesTrack {
    @objc optional var name: String {get}
    @objc optional var artist: String {get}
}

// Protocol to interact with iTunes
@objc protocol iTunesApplication {
    @objc optional var currentTrack: iTunesTrack? {get}
    @objc optional var currentStreamTitle: String? {get}
}

extension SBApplication: iTunesApplication {}

// Source that reads track artist and name from current itunes track
class ItunesSource: Source {

    // Calls the spotify API and returns the current track
    var currentTrack: Track? {

        if let iTunes: iTunesApplication = SBApplication(bundleIdentifier: bundleIdentifier) {
            if let application = iTunes as? SBApplication {
              if !application.isRunning {
                return nil
              }
            }

            // Attempt to fetch the title from a stream
            if let currentStreamTitle = iTunes.currentStreamTitle {
                if let track = currentStreamTitle {

                    let trackComponents = track.split(separator: "-").map(String.init)

                    if trackComponents.count == 2 {
                        let artist = trackComponents[0].trimmingCharacters(in: .whitespaces)
                        let name = trackComponents[1].trimmingCharacters(in: .whitespaces)

                        return Track(withName: name, andArtist: artist)
                    }

                }
            }

            // Attempt to fetch the title from a song
            if let currentTrack = iTunes.currentTrack {
                if let track = currentTrack {
                    if let name = track.name {
                        if let artist = track.artist {

                            // track properties are empty strings if itunes is closed
                            if name == "" || artist == "" {
                                return nil
                            }
                            return Track(withName: name, andArtist: artist)
                        }
                    }
                }
            }
        }

        return nil
    }

    private var bundleIdentifier: String {
        if ProcessInfo().isOperatingSystemAtLeast(
          OperatingSystemVersion(majorVersion: 10, minorVersion: 15, patchVersion: 0)
          ) {
          return "com.apple.Music"
        }

        return "com.apple.iTunes"
    }

}
