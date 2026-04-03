import Testing
@testable import AnalyticsKit

final class MockAdapter: AnalyticsAdapter, @unchecked Sendable {
    let name = "Mock"
    var trackedEvents: [AnalyticsEvent] = []
    var userProperties: UserProperties?
    var didReset = false
    var didFlush = false

    func track(_ event: AnalyticsEvent) async {
        trackedEvents.append(event)
    }

    func setUser(_ properties: UserProperties) async {
        userProperties = properties
    }

    func resetUser() async {
        didReset = true
    }

    func flush() async {
        didFlush = true
    }
}

@Suite("Analytics Tests")
struct AnalyticsTests {
    @Test("Track event is stored in recent events")
    func trackEvent() {
        let analytics = Analytics()
        analytics.track("button_tapped")
        let events = analytics.recentEvents()
        #expect(events.count == 1)
        #expect(events[0].name == "button_tapped")
    }

    @Test("Track event with properties")
    func trackWithProperties() {
        let analytics = Analytics()
        analytics.track("purchase", properties: ["item": "pro"])
        let events = analytics.recentEvents()
        #expect(events[0].properties["item"] == "pro")
    }

    @Test("Disabled analytics does not track")
    func disabledTracking() {
        let analytics = Analytics()
        analytics.setEnabled(false)
        analytics.track("should_not_track")
        #expect(analytics.recentEvents().isEmpty)
    }

    @Test("Re-enabled analytics tracks again")
    func reEnabledTracking() {
        let analytics = Analytics()
        analytics.setEnabled(false)
        analytics.track("first")
        analytics.setEnabled(true)
        analytics.track("second")
        #expect(analytics.recentEvents().count == 1)
        #expect(analytics.recentEvents()[0].name == "second")
    }

    @Test("Recent events respects limit")
    func recentEventsLimit() {
        let analytics = Analytics()
        for i in 0..<10 {
            analytics.track("event_\(i)")
        }
        let events = analytics.recentEvents(limit: 3)
        #expect(events.count == 3)
        #expect(events[0].name == "event_7")
    }
}
