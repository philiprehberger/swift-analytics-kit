import Testing
@testable import AnalyticsKit

@Suite("EventSchema Tests")
struct EventSchemaTests {
    @Test("Valid event passes schema")
    func validEvent() {
        let schema = EventSchema(eventName: "purchase", required: ["item", "amount"])
        let event = AnalyticsEvent(name: "purchase", properties: ["item": "pro", "amount": "9.99"])
        let errors = schema.validate(event)
        #expect(errors.isEmpty)
    }

    @Test("Missing required property returns error")
    func missingRequired() {
        let schema = EventSchema(eventName: "purchase", required: ["item", "amount"])
        let event = AnalyticsEvent(name: "purchase", properties: ["item": "pro"])
        let errors = schema.validate(event)
        #expect(errors.count == 1)
        #expect(errors[0].contains("amount"))
    }

    @Test("Schema ignores non-matching events")
    func nonMatchingEvent() {
        let schema = EventSchema(eventName: "purchase", required: ["item"])
        let event = AnalyticsEvent(name: "page_view", properties: [:])
        let errors = schema.validate(event)
        #expect(errors.isEmpty)
    }

    @Test("Multiple missing properties returns multiple errors")
    func multipleMissing() {
        let schema = EventSchema(eventName: "purchase", required: ["item", "amount", "currency"])
        let event = AnalyticsEvent(name: "purchase", properties: [:])
        let errors = schema.validate(event)
        #expect(errors.count == 3)
    }
}
