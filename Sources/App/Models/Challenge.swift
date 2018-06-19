//
//  Challenge.swift
//  App
//
//  Created by Eric Cormack on 6/18/18.
//

import Vapor

struct Challenge: Content, Slack {
    //  Properties
    var token: String
    var challenge: String
    var type: String
}
