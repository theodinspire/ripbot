//
//  ReactionHandler.swift
//  App
//
//  Created by Eric Cormack on 6/18/18.
//

import Vapor

import Regex

class ReactionHandler {
    private static let instance = ReactionHandler()

    private init() {}

    private let buildFailureMatch = Regex("Build (.*/d+.*) failed")

    public static func react(to json: Any) {
        print("I'm dealing with it")
    }
}
