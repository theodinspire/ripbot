//
//  Reaction.swift
//  App
//
//  Created by Eric Cormack on 6/19/18.
//

import Vapor

struct Reaction: Content {
	let token = KeyChain.botToken
	var channel: String
	var timestamp: String
	var name: String
}
