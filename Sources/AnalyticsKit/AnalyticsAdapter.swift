import Foundation

/// A backend that receives analytics events
///
/// Implement this protocol to send events to Firebase, Mixpanel, Segment, or any other service.
public protocol AnalyticsAdapter: Sendable {
    /// The adapter name (for logging)
    var name: String { get }

    /// Track an event
    func track(_ event: AnalyticsEvent) async

    /// Set user identity and properties
    func setUser(_ properties: UserProperties) async

    /// Clear user data
    func resetUser() async

    /// Flush any queued events to the backend
    func flush() async
}
