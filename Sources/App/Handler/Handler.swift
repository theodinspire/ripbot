//
//  Handler.swift
//  App
//
//  Created by Eric Cormack on 12/13/19.
//

import Foundation

protocol Handler {
    func act(on event: Event)
}
