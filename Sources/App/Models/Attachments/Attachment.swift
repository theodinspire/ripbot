//
//  Attachment.swift
//  App
//
//  Created by Eric Cormack on 6/19/18.
//

import Vapor

struct Attachment: Content {
	//  Required
	var fallback: String?

	//  Optional
	var text: String?

	var color: String?
	var pretext: String?

	var ts: Date?

	var author_name: String?
	var author_link: URL?
	var author_icon: URL?

	var title: String?
	var title_link: URL?

	var footer: String?
	var footer_icon: URL?

	var image_url: URL?
	var thumb_url: URL?

	var fields: [Field]?
	var actions: [Action]?
}
