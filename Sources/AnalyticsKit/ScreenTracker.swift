#if canImport(SwiftUI)
import SwiftUI

/// A view modifier that tracks screen appearances
struct ScreenTrackingModifier: ViewModifier {
    let screenName: String
    let properties: [String: String]
    let analytics: Analytics

    func body(content: Content) -> some View {
        content.onAppear {
            var props = properties
            props["screen"] = screenName
            analytics.track("screen_view", properties: props)
        }
    }
}

extension View {
    /// Track screen appearances with analytics
    ///
    /// ```swift
    /// Text("Home").trackScreen("home_screen")
    /// ```
    public func trackScreen(
        _ name: String,
        properties: [String: String] = [:],
        analytics: Analytics = Analytics()
    ) -> some View {
        modifier(ScreenTrackingModifier(screenName: name, properties: properties, analytics: analytics))
    }
}
#endif
