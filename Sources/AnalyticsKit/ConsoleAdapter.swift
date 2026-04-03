import Foundation

/// A built-in adapter that logs events to the console
public struct ConsoleAdapter: AnalyticsAdapter, Sendable {
    public let name = "Console"

    private let logger: @Sendable (String) -> Void

    /// Create a console adapter with an optional custom logger
    public init(logger: @escaping @Sendable (String) -> Void = { print($0) }) {
        self.logger = logger
    }

    public func track(_ event: AnalyticsEvent) async {
        var message = "[Analytics] \(event.name)"
        if !event.properties.isEmpty {
            let props = event.properties.map { "\($0.key)=\($0.value)" }.joined(separator: ", ")
            message += " {\(props)}"
        }
        logger(message)
    }

    public func setUser(_ properties: UserProperties) async {
        logger("[Analytics] setUser: \(properties.userId ?? "nil")")
    }

    public func resetUser() async {
        logger("[Analytics] resetUser")
    }

    public func flush() async {
        // No-op for console
    }
}
