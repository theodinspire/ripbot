//
//  Reaction.swift
//  App
//
//  Created by Eric Cormack on 6/19/18.
//

import Vapor

struct Reaction: Content {
    let token = ProcessInfo.processInfo.environment["BOT_TOKEN"] ?? "null"
    var channel: String
    var timestamp: String
    var name: String
}
