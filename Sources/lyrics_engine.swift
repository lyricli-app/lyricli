import Foundation
import HTMLEntities

// Given a track, attempts to fetch the lyrics from lyricswiki
class LyricsEngine {

    // URL of the API endpoint to use
    private let apiURL = "https://lyrics.wikia.com/api.php?action=lyrics&func=getSong&fmt=realjson"

    // Method used to call the API
    private let apiMethod = "GET"

    // Regular expxression used to find the lyrics in the lyricswiki HTML
    private let lyricsMatcher = "class='lyricbox'>(.+)<div"

    // The track we'll be looking for
    private let track: Track

    // Fetches the lyrics and returns if found
    var lyrics: String? {

        var lyrics: String?

        // Encode the track artist and name and finish building the API call URL

        if let artist = track.artist.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let name: String = track.name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                if let url = URL(string: "\(apiURL)&artist=\(artist)&song=\(name)") {

                    // We'll lock until the async call is finished

                    var requestFinished = false
                    let asyncLock = NSCondition()
                    asyncLock.lock()

                    // Call the API and unlock when you're done

                    fetchLyricsFromAPI(withURL: url, completionHandler: {lyricsResult -> Void in
                        lyrics = lyricsResult
                        requestFinished = true
                        asyncLock.signal()
                    })

                    while !requestFinished {
                        asyncLock.wait()
                    }
                    asyncLock.unlock()
                }
            }
        }

        return lyrics
    }

    // Initializes with a track
    init(withTrack targetTrack: Track) {

        track = targetTrack
    }

    // Fetch the lyrics URL from the API, triggers the request to fetch the
    // lyrics page
    private func fetchLyricsFromAPI(withURL url: URL, completionHandler: @escaping (String?) -> Void) {

        var apiRequest = URLRequest(url: url)
        apiRequest.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: apiRequest, completionHandler: {data, _, _ -> Void in

            // If the response is parseable JSON, and has a url, we'll look for
            // the lyrics in there

            if let data = data {
                if let jsonResponse = try? JSONSerialization.jsonObject(with: data) {
                    if let jsonResponse = jsonResponse as? [String: Any] {
                        if let lyricsUrlString = jsonResponse["url"] as? String {
                            if let lyricsUrl = URL(string: lyricsUrlString) {

                                // At this point we have a valid wiki url
                                self.fetchLyricsFromPage(withURL: lyricsUrl, completionHandler: completionHandler)
                                return
                            }
                        }
                    }
                }
            }

            completionHandler(nil)
        })
        task.resume()
    }

    // Fetch the lyrics from the page and send it to the parser
    private func fetchLyricsFromPage(withURL url: URL, completionHandler: @escaping (String?) -> Void) {

        var pageRequest = URLRequest(url: url)
        pageRequest.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: pageRequest, completionHandler: {data, _, _ -> Void in

            // If the response is parseable JSON, and has a url, we'll look for
            // the lyrics in there

            if let data = data {
                if let htmlBody = String(data: data, encoding: String.Encoding.utf8) {
                    self.parseHtmlBody(htmlBody, completionHandler: completionHandler)
                    return
                }
            }

            completionHandler(nil)
        })
        task.resume()
    }

    // Parses the wiki to find the lyrics, decodes the lyrics object
    private func parseHtmlBody(_ body: String, completionHandler: @escaping (String?) -> Void) {

        // Look for the lyrics lightbox

        if let regex = try? NSRegularExpression(pattern: lyricsMatcher) {
            let matches = regex.matches(in: body, range: NSRange(location: 0, length: body.characters.count))

            for match in matches {

                let nsBody = body as NSString
                let range = match.rangeAt(1)
                let encodedLyrics = nsBody.substring(with: range)

                let decodedLyrics = decodeLyrics(encodedLyrics)

                completionHandler(decodedLyrics)
                return
            }
        }

        completionHandler(nil)
    }

    // Escapes the HTML entities
    private func decodeLyrics(_ lyrics: String) -> String {

        let unescapedLyrics = lyrics.htmlUnescape()
        return unescapedLyrics.replacingOccurrences(of: "<br />", with: "\n")
    }
}
