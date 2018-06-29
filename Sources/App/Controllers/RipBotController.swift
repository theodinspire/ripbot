//
//  RipBotController.swift
//  App
//
//  Created by Eric Cormack on 6/18/18.
//

import Vapor

import Regex

class RipBotController {
    private let matchTable: [Regex: String] = [
        Regex("Build .*\\d+.* failed") : "rip",
        Regex("sandwich", options: .ignoreCase) : "sandwich"
    ]

    func handle(_ request: Request, from slack: Slack) throws -> HTTPResponse {
        guard slack.isCanonical else {
            throw Abort(.forbidden)
        }

        switch slack.type {
        case .challenge:
            guard let challenge = slack.challenge else {
                throw Abort(.badRequest)
            }
            return HTTPResponse(status: .ok, body: challenge)
        case .event:
            let wrapper = try request.content.decode(EventWrapper.self)
            let _ = wrapper.map { self.react(to: $0.event, with: request) }
        }

        return HTTPResponse(status: .ok)
    }

    private func react(to event: Event, with request: Request) {
        guard let channel = event.channel else {
            return
        }

        var reactions = Set<String>()
        let texts = event.allTexts

        reactions: for (regex, emote) in matchTable {
            texts: for text in texts {
                guard regex.matches(text) else {
                    continue texts
                }

                reactions.insert(emote)
                continue reactions
            }
        }

        for name in reactions {
            let reaction = Reaction(channel: channel, timestamp: event.event_ts, name: name)

            do {
                let _ = try request.client().post("https://slack.com/api/reactions.add", headers: ["Authorization": "Bearer \(KeyChain.botToken)"]) { try $0.content.encode(reaction) }
            } catch {
                print(error)
            }
        }
    }
}
