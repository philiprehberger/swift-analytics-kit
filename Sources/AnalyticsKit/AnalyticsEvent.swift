import Foundation

/// A tracked analytics event
public struct AnalyticsEvent: Sendable, Identifiable {
    /// Unique identifier
    public let id: UUID

    /// Event name (e.g. "button_tapped", "purchase")
    public let name: String

    /// Event properties as string key-value pairs
    public let properties: [String: String]

    /// When the event was created
    public let timestamp: Date

    /// Create an analytics event
    public init(name: String, properties: [String: String] = [:]) {
        self.id = UUID()
        self.name = name
        self.properties = properties
        self.timestamp = Date()
    }
}
