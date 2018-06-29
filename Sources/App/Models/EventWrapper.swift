//
//  EventWrapper.swift
//  App
//
//  Created by Eric Cormack on 6/18/18.
//

import Vapor

struct EventWrapper: Content {
    //  Properties
    let team_id: String
    let api_app_id: String
    let event: Event
    let type: String
    let event_id: String
    let event_time: Date
}
