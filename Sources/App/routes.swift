import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
	// Basic "Hello, world!" example
	router.get("hello") { req in
		return "Hello, world!"
	}

	// RipBot
	let ripBot = RipBotController()
	router.post(Slack.self, at: "ripbot", use: ripBot.handle)
}
