//
//  EmoteHandler.swift
//  App
//
//  Created by Eric Cormack on 12/13/19.
//

import Foundation
import Regex

import Console

class EmoteHandler : Handler {
	static let address = "https://slack.com/api/reactions.add"
	//        "https://www.mocky.io/v2/5185415ba171ea3a00704eed"

	let pattern: Regex
	let emote: String

	init(_ emote: String, on pattern: StaticString) {
		self.emote = emote
		self.pattern = Regex(pattern)
	}

	func act(on event: Event) {
		guard event.allTexts.contains(where: pattern.matches(_:)) else {
			return
		}

		guard let channel = event.channel,
			let url = URL(string: EmoteHandler.address) else {
				return
		}

		let reaction = Reaction(
			channel: channel, timestamp: event.event_ts, name: emote)

		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.setValue(
			"Bearer \(KeyChain.botToken)", forHTTPHeaderField: "Authorization")

		do {
			let data = try JSONEncoder().encode(reaction)
			request.httpBody = data

			URLSession.shared.dataTask(
				with: request,
				completionHandler: { _, response,_ in
					if let response = response as? HTTPURLResponse,
						let contents = String(data: data, encoding: .utf8) {
						let terminal = Terminal()
						terminal.output(contents.consoleText(color: .brightYellow))
						terminal.output("Status code: \(response.statusCode)".consoleText(color: .yellow))
					}
			}).resume()
		} catch {
			Terminal().error("Error making reaction \(emote) to message \(event.event_ts): \(error.localizedDescription)")
		}
	}
}
