/// Looks for lyrics on the internet
class LyricsEngine {

    let track: Track

    var lyrics: String? {
        get {
            if track.artist == "test" && track.name == "test" {
                return "Doo doo doo"
            }

            return nil
        }
    }

    init(withTrack targetTrack: Track) {

        track = targetTrack
    }
}
