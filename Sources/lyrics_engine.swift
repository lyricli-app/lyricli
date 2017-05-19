import Foundation
import HTMLEntities

/// Looks for lyrics on the internet
class LyricsEngine {

    private let apiURL = "https://lyrics.wikia.com/api.php?action=lyrics&func=getSong&fmt=realjson"
    private let apiMethod = "GET"
    private let lyricsMatcher = "class='lyricbox'>(.+)<div"

    private let track: Track

    // Fetches the lyrics and returns if found

    var lyrics: String? {
        get {

            var lyrics: String?

            if let artist = track.artist.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                if let name: String = track.name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                    if let url = URL(string: "\(apiURL)&artist=\(artist)&song=\(name)") {

                        // We'll lock until the async call is finished

                        var requestFinished = false
                        let asyncLock = NSCondition()
                        asyncLock.lock()

                        // Call the API and unlock when you're done

                        fetchLyricsFromAPI(withURL: url, completionHandler: {lyricsResult -> Void in
                            if let lyricsResult = lyricsResult {
                                lyrics = lyricsResult
                                requestFinished = true
                                asyncLock.signal()
                            }
                        })

                        while(!requestFinished) {
                            asyncLock.wait()
                        }
                        asyncLock.unlock()
                    }
                }
            }

            return lyrics
        }
    }

    init(withTrack targetTrack: Track) {

        track = targetTrack
    }

    // Fetch the lyrics from the API and request / parse the page

    private func fetchLyricsFromAPI(withURL url: URL, completionHandler: @escaping (String?) -> Void) {

        var apiRequest = URLRequest(url: url)
        apiRequest.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: apiRequest, completionHandler: {data, response, error -> Void in

            // If the response is parseable JSON, and has a url, we'll look for
            // the lyrics in there

            if let data = data {
                let jsonResponse = try? JSONSerialization.jsonObject(with: data) as! [String: Any]
                if let jsonResponse = jsonResponse {
                    if let lyricsUrlString = jsonResponse["url"] as? String {
                        if let lyricsUrl = URL(string: lyricsUrlString) {

                            // At this point we have a valid wiki url
                            self.fetchLyricsFromPage(withURL: lyricsUrl, completionHandler: completionHandler)
                            return
                        }
                    }
                }
            }

            completionHandler(nil)
        })
        task.resume()
    }

    // Fetch the lyrics from the page and parse the page

    private func fetchLyricsFromPage(withURL url: URL, completionHandler: @escaping (String?) -> Void) {

        var pageRequest = URLRequest(url: url)
        pageRequest.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: pageRequest, completionHandler: {data, response, error -> Void in

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

    // Parses the wiki to obtain the lyrics

    private func parseHtmlBody(_ body: String, completionHandler: @escaping (String?) -> Void) {

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
