//
//  Item.swift
//  App
//
//  Created by Eric Cormack on 6/18/18.
//

import Vapor

struct Item: Content {
    var type: String
    var channel: String
    var ts: String
}
