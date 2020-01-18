//
//  Slack.swift
//  App
//
//  Created by Eric Cormack on 6/18/18.
//

import Vapor

struct Slack: Content {
	let token: String
	let type: SlackRequestType
	let challenge: String?

	var isCanonical: Bool {
		get {
			return token == KeyChain.verificationToken
		}
	}
}
