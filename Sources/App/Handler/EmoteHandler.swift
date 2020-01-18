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
		let terminal = Terminal()

		guard event.allTexts.contains(where: pattern.matches(_:)) else {
			return
		}

		guard let channel = event.channel,
			let url = URL(string: EmoteHandler.address) else {
				terminal.output("Channel or URL not parsed")
				return
		}

		let reaction = Reaction(
			channel: channel, timestamp: event.event_ts, name: emote)
		var request = URLRequest(url: url)

		request.setValue(
			"Bearer \(KeyChain.botToken)", forHTTPHeaderField: "Authorization")

		do {
			terminal.output("Sending reaction \(emote).".consoleText(color: .yellow))
			request.httpBody = try JSONEncoder().encode(reaction)
			URLSession.shared.dataTask(
				with: request,
				completionHandler: { data, response, error in
					let terminal = Terminal()
					print("Request sent.")

					if let error = error {
						terminal.output("Error: ".consoleText(color: .red) + "\(error)".consoleText())
						return
					}

					guard let data = data,
						let response = response as? HTTPURLResponse else {
							terminal.error("Error parsing data or response")
							return
					}

					guard response.statusCode == 200 else {
						terminal.error("Invalid response code: \(response.statusCode)")
						return
					}

					terminal.output(String(data: data, encoding: .utf8)?.consoleText() ?? "What string".consoleText())
			}).resume()
		} catch {
			print(error)
		}
	}
}
