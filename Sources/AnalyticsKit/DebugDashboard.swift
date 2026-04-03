#if canImport(SwiftUI)
import SwiftUI

/// A debug view showing recent analytics events
///
/// Use this in debug builds to inspect tracked events:
/// ```swift
/// AnalyticsDebugDashboard(analytics: myAnalytics)
/// ```
@available(macOS 14.0, iOS 17.0, tvOS 17.0, watchOS 10.0, *)
public struct AnalyticsDebugDashboard: View {
    private let analytics: Analytics

    /// Create a debug dashboard for an analytics instance
    public init(analytics: Analytics = Analytics()) {
        self.analytics = analytics
    }

    public var body: some View {
        List {
            let events = analytics.recentEvents()
            if events.isEmpty {
                Text("No events tracked yet")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(events) { event in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(event.name)
                            .font(.headline)
                        if !event.properties.isEmpty {
                            Text(event.properties.map { "\($0.key): \($0.value)" }.joined(separator: ", "))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Text(event.timestamp.formatted())
                            .font(.caption2)
                            .foregroundStyle(.tertiary)
                    }
                }
            }
        }
        .navigationTitle("Analytics Events")
    }
}
#endif
