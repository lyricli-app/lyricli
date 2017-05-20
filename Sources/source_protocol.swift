// All sources should comply with this protocol. The currentTrack computed
// property will return a track if the conditions are met
protocol Source {
    var currentTrack: Track? { get }
}
