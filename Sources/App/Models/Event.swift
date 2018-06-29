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
    var event_ts: String

    //  Optional
    var attachments: [Attachment]?
    var channel: String?

    var text: String?

    var user: String?
    var reaction: String?
    var item_user: String?
    var item: Item?
}

extension Event {
    var allTexts: [String] {
        return ([text] + (attachments ?? []).flatMap { attachment in
            [attachment.text, attachment.fallback]
                + (attachment.fields ?? []).compactMap { field in field.value }
        }).compactMap { $0 }
    }
}
