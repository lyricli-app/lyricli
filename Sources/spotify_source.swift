// Source that reads track artist and name from current spotify track
class SpotifySource: Source {

    // Calls the spotify API and returns the current track
    var currentTrack: Track? {

        return nil
    }

    // Initiate the enabling process
    func enable() {

        if !isConfigured() {
            createAuthToken()
        }
    }

    // returns whether or not this source has configuration
    private func isConfigured() -> Bool {
        if let spotifyConfig = Configuration.shared["spotify"] as? [String: String] {
            if spotifyConfig["auth_token"] != nil {
                return true
            }
        }

        return false
    }

    // Starts the oAuth process in order to obtain an auth token
    private func createAuthToken() {
        print("not yet implemented.")
    }
}
