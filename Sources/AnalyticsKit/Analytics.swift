import Foundation

/// Central analytics manager that routes events to registered adapters
public final class Analytics: @unchecked Sendable {
    private var adapters: [any AnalyticsAdapter] = []
    private var schemas: [String: EventSchema] = [:]
    private var events: [AnalyticsEvent] = []
    private var enabled: Bool = true
    private let lock = NSLock()
    private let logger: @Sendable (String) -> Void

    /// Create an analytics manager
    public init(logger: @escaping @Sendable (String) -> Void = { print($0) }) {
        self.logger = logger
    }

    /// Register analytics adapters
    public func register(_ adapters: [any AnalyticsAdapter]) {
        lock.lock()
        self.adapters.append(contentsOf: adapters)
        lock.unlock()
    }

    /// Track an analytics event
    public func track(_ event: AnalyticsEvent) {
        lock.lock()
        guard enabled else {
            lock.unlock()
            return
        }

        // Validate against schema if one exists
        if let schema = schemas[event.name] {
            let errors = schema.validate(event)
            for error in errors {
                logger("[Analytics] Schema warning: \(error)")
            }
        }

        events.append(event)
        let currentAdapters = adapters
        lock.unlock()

        Task {
            for adapter in currentAdapters {
                await adapter.track(event)
            }
        }
    }

    /// Track a named event with optional properties
    public func track(_ name: String, properties: [String: String] = [:]) {
        track(AnalyticsEvent(name: name, properties: properties))
    }

    /// Set user identity and properties on all adapters
    public func setUser(_ properties: UserProperties) {
        lock.lock()
        let currentAdapters = adapters
        lock.unlock()

        Task {
            for adapter in currentAdapters {
                await adapter.setUser(properties)
            }
        }
    }

    /// Clear user data on all adapters
    public func resetUser() {
        lock.lock()
        let currentAdapters = adapters
        lock.unlock()

        Task {
            for adapter in currentAdapters {
                await adapter.resetUser()
            }
        }
    }

    /// Enable or disable tracking globally
    public func setEnabled(_ enabled: Bool) {
        lock.lock()
        self.enabled = enabled
        lock.unlock()
    }

    /// Register an event schema for validation
    public func registerSchema(_ schema: EventSchema) {
        lock.lock()
        schemas[schema.eventName] = schema
        lock.unlock()
    }

    /// Get recent tracked events
    public func recentEvents(limit: Int = 100) -> [AnalyticsEvent] {
        lock.lock()
        defer { lock.unlock() }
        return Array(events.suffix(limit))
    }
}
