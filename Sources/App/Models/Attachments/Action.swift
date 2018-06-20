//
//  Action.swift
//  App
//
//  Created by Eric Cormack on 6/19/18.
//

import Vapor

struct Action: Content {
    var type: String
    var text: String
    var url: String
    var style: String
}
