import Testing
@testable import AnalyticsKit

@Suite("UserProperties Tests")
struct UserPropertiesTests {
    @Test("Creates user properties with ID")
    func withId() {
        let props = UserProperties(userId: "user-123", properties: ["plan": "pro"])
        #expect(props.userId == "user-123")
        #expect(props.properties["plan"] == "pro")
    }

    @Test("Creates user properties without ID")
    func withoutId() {
        let props = UserProperties(properties: ["role": "admin"])
        #expect(props.userId == nil)
        #expect(props.properties["role"] == "admin")
    }

    @Test("Empty user properties")
    func empty() {
        let props = UserProperties()
        #expect(props.userId == nil)
        #expect(props.properties.isEmpty)
    }
}
