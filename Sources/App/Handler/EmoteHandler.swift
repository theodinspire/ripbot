//
//  EmoteHandler.swift
//  App
//
//  Created by Eric Cormack on 12/13/19.
//

import Foundation
import Regex

class EmoteHandler : Handler {
    static let address = "https://slack.com/api/reactions.add"
//        "https://www.mocky.io/v2/5185415ba171ea3a00704eed"

    let pattern: Regex
    let emote: String

    init(_ emote: String, on pattern: StaticString) {
        self.emote = emote
        self.pattern = Regex(pattern)
    }

    func act(on event: Event) {
        guard event.allTexts.allSatisfy(pattern.matches(_:)) else {
            return
        }

        guard let channel = event.channel,
            let url = URL(string: EmoteHandler.address) else {
                return
        }

        let reaction = Reaction(
            channel: channel, timestamp: event.event_ts, name: emote)
        var request = URLRequest(url: url)

        request.setValue(
            "Bearer \(KeyChain.botToken)", forHTTPHeaderField: "Authorization")

        do {
            request.httpBody = try JSONEncoder().encode(reaction)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error:", error)
                    return
                }

                guard let data = data,
                    let response = response as? HTTPURLResponse else {
                    print ("Error parsing data or response")
                    return
                }

                print(String(data: data, encoding: .utf8) ?? "What string")
                print("Status code:", response.statusCode)
            }
        } catch {
            print(error)
        }
    }
}