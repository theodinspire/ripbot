//
//  SlackRequestType.swift
//  App
//
//  Created by Eric Cormack on 6/25/18.
//

import Vapor

enum SlackRequestType: String, Content {
    case challenge = "url_verification"
    case event = "event_callback"
}
