//
//  RipBotController.swift
//  App
//
//  Created by Eric Cormack on 6/18/18.
//

import Vapor

import Dispatch
import Regex

class RipBotController {
    private let matchTable: [Regex: String] = [
        Regex("Build .*\\d+.* failed") : "rip",
        Regex("sandwich", options: .ignoreCase) : "sandwich",
        Regex("thank(s| you)", options: .ignoreCase) : "heart",
        Regex("ripbot", options: .ignoreCase) : "robot_face",
    ]

    private let handlers: [Handler] = [
        EmoteHandler("rip", on: "Build .*\\d+.* failed"),
        EmoteHandler("sandwich", on: "sandwich"),
        EmoteHandler("heart", on: "thank(s| you)"),
        EmoteHandler("robot_face", on: "ripbot")
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
            let _ = try request.content.decode(EventWrapper.self)
				.map { self.act(upon: $0.event) }
        }

        return HTTPResponse(status: .ok)
    }

    func act(upon event: Event) {
        for handler in handlers {
            DispatchQueue.global(qos: .background).async {
                handler.act(on: event)
            }
        }
    }
}
