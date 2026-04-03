import Testing
@testable import AnalyticsKit

final class LogCapture: @unchecked Sendable {
    var messages: [String] = []
}

@Suite("ConsoleAdapter Tests")
struct ConsoleAdapterTests {
    @Test("Console adapter logs event name")
    func logsEventName() async {
        let capture = LogCapture()
        let adapter = ConsoleAdapter { capture.messages.append($0) }
        let event = AnalyticsEvent(name: "test_event")
        await adapter.track(event)
        #expect(capture.messages.count == 1)
        #expect(capture.messages[0].contains("test_event"))
    }

    @Test("Console adapter logs properties")
    func logsProperties() async {
        let capture = LogCapture()
        let adapter = ConsoleAdapter { capture.messages.append($0) }
        let event = AnalyticsEvent(name: "test", properties: ["key": "value"])
        await adapter.track(event)
        #expect(capture.messages[0].contains("key"))
        #expect(capture.messages[0].contains("value"))
    }

    @Test("Console adapter logs setUser")
    func logsSetUser() async {
        let capture = LogCapture()
        let adapter = ConsoleAdapter { capture.messages.append($0) }
        await adapter.setUser(UserProperties(userId: "user-1"))
        #expect(capture.messages[0].contains("user-1"))
    }

    @Test("Console adapter logs resetUser")
    func logsResetUser() async {
        let capture = LogCapture()
        let adapter = ConsoleAdapter { capture.messages.append($0) }
        await adapter.resetUser()
        #expect(capture.messages[0].contains("resetUser"))
    }
}
