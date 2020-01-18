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
				return
		}

		let reaction = Reaction(
			channel: channel, timestamp: event.event_ts, name: emote)
		var request = URLRequest(url: url)

		request.setValue(
			"Bearer \(KeyChain.botToken)", forHTTPHeaderField: "Authorization")

		do {
			terminal.output("Sending reaction \(emote).".consoleText(color: .yellow))
			let body = try JSONEncoder().encode(reaction)
			request.httpBody = body

			let bodyString = String(data: body, encoding: .utf8)
				?? "Could not parse body."
			terminal.output((request.allHTTPHeaderFields?.debugDescription
				?? "No headers found").consoleText(color: .brightMagenta))
			terminal.output(bodyString.consoleText(color: .brightYellow))

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

						let content =
							String(data: data, encoding: .utf8)
								?? "What string"
						let lines = content.components(separatedBy: "\n")
						let start = max(0, lines.endIndex - 10)

						for line in lines[start..<lines.endIndex].map({ $0.consoleText(color: .green) }) {
							terminal.output(line)
						}

						return
					}

					terminal.output(String(data: data, encoding: .utf8)?.consoleText() ?? "What string".consoleText())
			}).resume()
		} catch {
			print(error)
		}
	}
}
