//
//  Field.swift
//  App
//
//  Created by Eric Cormack on 6/19/18.
//

import Vapor

struct Field: Content {
	var title: String
	var value: String
	var short: Bool
}
