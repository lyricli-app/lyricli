/// Contains the artist and name of a track
public class Track {
    public let name: String
    public let artist: String

    init(withName trackName: String, andArtist trackArtist: String) {

        name = trackName
        artist = trackArtist
    }
}
