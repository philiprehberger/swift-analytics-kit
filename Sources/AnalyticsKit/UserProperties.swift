import Foundation

/// User identity and properties for analytics
public struct UserProperties: Sendable {
    /// The user identifier (e.g. database ID)
    public let userId: String?

    /// Additional properties (e.g. plan, role)
    public let properties: [String: String]

    /// Create user properties
    public init(userId: String? = nil, properties: [String: String] = [:]) {
        self.userId = userId
        self.properties = properties
    }
}
