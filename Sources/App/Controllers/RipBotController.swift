//
//  RipBotController.swift
//  App
//
//  Created by Eric Cormack on 6/18/18.
//

import Vapor

import Regex

class RipBotController {
    func accept(_ request: Request, threat challenge: Challenge) throws -> HTTPResponse {
        guard challenge.isCanonical else {
            return HTTPResponse(status: .init(statusCode: 418, reasonPhrase: "I am a teapot"), body: "How appropriate, you fight like a cow!")
        }

        return HTTPResponse(status: .ok, body: challenge.challenge)
    }

    func handle(_ request: Request, event wrapper: EventWrapper) throws -> HTTPResponse {
        guard wrapper.isCanonical else {
            return HTTPResponse(status: .init(statusCode: 418, reasonPhrase: "I am a teapot"), body: "How appropriate, you fight like a cow!")
        }

        try react(to: wrapper.event, with: request)

        return HTTPResponse(status: .ok)
    }

    private func react(to event: Event, with request: Request) throws {
        let buildFailureMatch = Regex("Build .*\\d+.* failed")

        guard let attachments = event.attachments,
            attachments.contains(where: { attachment in
                guard let text = attachment.text else { return false }
                return buildFailureMatch.matches(text)
            }),
            let channel = event.channel,
            let accessToken = ProcessInfo.processInfo.environment["ACCESS_TOKEN"] else { return }

        let rip = Reaction(channel: channel, timestamp: event.eventTs, name: "rip")

        let _ = try request.client().post("https://slack.com/api/reactions.add", headers: ["Authorization": "Bearer \(accessToken)"]) { try $0.content.encode(rip) }
    }
}
