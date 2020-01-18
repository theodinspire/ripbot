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
//		request.setValue("application/json", forHTTPHeaderField: "Content-Type")

		do {
			let body = try JSONEncoder().encode(reaction)
			request.httpBody = body

			URLSession.shared.dataTask(
				with: request,
				completionHandler: { data, response, error in
					if let _ = error { return }

					let terminal = Terminal()

					guard let _ = response as? HTTPURLResponse else {
						terminal.error("Incorrect response type.")
						return
					}

					guard let data = data, let contents = String(data: data, encoding: .utf8) else {
						terminal.error("Could not parse response")
						return
					}

					terminal.output(contents.consoleText(color: .brightYellow))
			}).resume()
		} catch {
			Terminal().error("Error making reaction \(emote) to message \(event.event_ts): \(error.localizedDescription)")
		}
	}
}
