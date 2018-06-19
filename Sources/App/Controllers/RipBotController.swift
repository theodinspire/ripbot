//
//  RipBotController.swift
//  App
//
//  Created by Eric Cormack on 6/18/18.
//

import Foundation

import Vapor

class RipBotController {
    func accept(_ request: Request, threat challenge: Challenge) throws -> HTTPResponse {
        guard challenge.isCanonical else {
            return HTTPResponse(status: .init(statusCode: 418, reasonPhrase: "I am a teapot"), body: "How appropriate, you fight like a cow!")
        }

        return HTTPResponse(status: .ok, body: challenge.challenge)
    }

    func handle(_ request: Request, event: EventWrapper) throws -> HTTPResponse {
        guard event.isCanonical else {
            return HTTPResponse(status: .init(statusCode: 418, reasonPhrase: "I am a teapot"), body: "How appropriate, you fight like a cow!")
        }

        return HTTPResponse(status: .forbidden, body: "This has not been implemented")
    }
}
