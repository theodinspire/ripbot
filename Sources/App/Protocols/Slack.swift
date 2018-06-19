//
//  Slack.swift
//  App
//
//  Created by Eric Cormack on 6/18/18.
//

import Foundation

protocol Slack {
    var token: String { get }
}

extension Slack {
    var isCanonical: Bool {
        get {
            return token == ProcessInfo.processInfo.environment["VERIFICATION_TOKEN"]
        }
    }
}
