//
//  EventWrapper.swift
//  App
//
//  Created by Eric Cormack on 6/18/18.
//

import Vapor

struct EventWrapper: Content, Slack {
    //  Properties
    var token: String
    var teamId: String
    var apiAppId: String
    var event: Event
    var type: String
    var eventId: String
    var eventTime: Date
    var authedUsers: [String]
}
