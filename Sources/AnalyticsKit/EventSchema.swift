import Foundation

/// A schema for validating analytics event properties
public struct EventSchema: Sendable {
    /// The event name this schema applies to
    public let eventName: String

    /// Properties that must be present
    public let requiredProperties: Set<String>

    /// Properties that may be present
    public let optionalProperties: Set<String>

    /// Create an event schema
    public init(eventName: String, required: Set<String> = [], optional: Set<String> = []) {
        self.eventName = eventName
        self.requiredProperties = required
        self.optionalProperties = optional
    }

    /// Validate an event against this schema, returning any errors
    public func validate(_ event: AnalyticsEvent) -> [String] {
        guard event.name == eventName else { return [] }
        var errors: [String] = []
        for prop in requiredProperties {
            if event.properties[prop] == nil {
                errors.append("Missing required property '\(prop)' on event '\(eventName)'")
            }
        }
        return errors
    }
}
