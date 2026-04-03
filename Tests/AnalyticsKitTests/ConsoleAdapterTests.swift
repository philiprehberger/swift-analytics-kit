import Testing
@testable import AnalyticsKit

@Suite("ConsoleAdapter Tests")
struct ConsoleAdapterTests {
    @Test("Console adapter logs event name")
    func logsEventName() async {
        var messages: [String] = []
        let adapter = ConsoleAdapter { messages.append($0) }
        let event = AnalyticsEvent(name: "test_event")
        await adapter.track(event)
        #expect(messages.count == 1)
        #expect(messages[0].contains("test_event"))
    }

    @Test("Console adapter logs properties")
    func logsProperties() async {
        var messages: [String] = []
        let adapter = ConsoleAdapter { messages.append($0) }
        let event = AnalyticsEvent(name: "test", properties: ["key": "value"])
        await adapter.track(event)
        #expect(messages[0].contains("key"))
        #expect(messages[0].contains("value"))
    }

    @Test("Console adapter logs setUser")
    func logsSetUser() async {
        var messages: [String] = []
        let adapter = ConsoleAdapter { messages.append($0) }
        await adapter.setUser(UserProperties(userId: "user-1"))
        #expect(messages[0].contains("user-1"))
    }

    @Test("Console adapter logs resetUser")
    func logsResetUser() async {
        var messages: [String] = []
        let adapter = ConsoleAdapter { messages.append($0) }
        await adapter.resetUser()
        #expect(messages[0].contains("resetUser"))
    }
}
