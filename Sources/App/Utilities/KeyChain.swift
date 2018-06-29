//
//  KeyChain.swift
//  App
//
//  Created by Eric Cormack on 6/22/18.
//

import Foundation

class KeyChain {
    static let verificationToken =
        (ProcessInfo.processInfo.environment["VERIFICATION_TOKEN"]) ?? ""

    static let accessToken =
        (ProcessInfo.processInfo.environment["ACCESS_TOKEN"]) ?? ""

    static let botToken =
        (ProcessInfo.processInfo.environment["BOT_TOKEN"]) ?? ""
}
