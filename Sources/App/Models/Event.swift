//
//  Event.swift
//  App
//
//  Created by Eric Cormack on 6/18/18.
//

import Vapor

struct Event: Content {
    //  Required
    var type: EventType
    var eventTs: String

    //  Optional
    var attachments: [Attachment]?
    var channel: String?

    var user: String?
    var reaction: String?
    var itemUser: String?
    var item: Item?
}
