//
//  Attachment.swift
//  App
//
//  Created by Eric Cormack on 6/19/18.
//

import Vapor

struct Attachment: Content {
    //  Required
    var fallback: String

    //  Optional
    var text: String?

    var color: String?
    var pretext: String?

    var ts: Date?

    var authorName: String?
    var authorLink: URL?
    var authorIcon: URL?

    var title: String?
    var titleLink: URL?

    var footer: String?
    var footerIcon: URL?

    var imageUrl: URL?
    var thumbUrl: URL?

    var fields: [Field]?
    var actions: [Action]?
}
