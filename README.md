# AnalyticsKit

[![Tests](https://github.com/philiprehberger/swift-analytics-kit/actions/workflows/ci.yml/badge.svg)](https://github.com/philiprehberger/swift-analytics-kit/actions/workflows/ci.yml)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fphiliprehberger%2Fswift-analytics-kit%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/philiprehberger/swift-analytics-kit)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fphiliprehberger%2Fswift-analytics-kit%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/philiprehberger/swift-analytics-kit)

Unified analytics abstraction with plug-in adapters, schema validation, and debug dashboard

## Requirements

- Swift >= 6.0
- macOS 13+ / iOS 16+ / tvOS 16+ / watchOS 9+

## Installation

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/philiprehberger/swift-analytics-kit.git", from: "0.1.0")
]
```

Then add `"AnalyticsKit"` to your target dependencies:

```swift
.target(name: "YourTarget", dependencies: [
    .product(name: "AnalyticsKit", package: "swift-analytics-kit")
])
```

## Usage

```swift
import AnalyticsKit

// Set up analytics with adapters
let analytics = Analytics()
analytics.register([ConsoleAdapter()])

// Track events
analytics.track("button_tapped", properties: ["screen": "home"])
analytics.track(AnalyticsEvent(name: "purchase", properties: ["item": "pro_plan"]))
```

### Multiple Adapters

```swift
analytics.register([
    ConsoleAdapter(),           // logs to console
    myFirebaseAdapter,          // sends to Firebase
    myMixpanelAdapter           // sends to Mixpanel
])
// All adapters receive every event
```

### User Properties

```swift
analytics.setUser(UserProperties(userId: "user-123", properties: ["plan": "pro"]))
analytics.resetUser()  // on logout
```

### Event Schema Validation

```swift
analytics.registerSchema(EventSchema(
    eventName: "purchase",
    required: ["item", "amount"],
    optional: ["currency"]
))
// Events missing required properties will log a warning
```

### Screen Tracking (SwiftUI)

```swift
struct HomeView: View {
    var body: some View {
        Text("Home")
            .trackScreen("home_screen")
    }
}
```

### Debug Dashboard (SwiftUI)

```swift
AnalyticsDebugDashboard()  // Shows recent events in a list
```

### Disable Tracking

```swift
analytics.setEnabled(false)  // e.g. user opted out
```

## API

### Analytics

| Method | Description |
|--------|-------------|
| `register(_:)` | Register analytics adapters |
| `track(_:)` | Track an event |
| `track(_:properties:)` | Track a named event with properties |
| `setUser(_:)` | Set user identity and properties |
| `resetUser()` | Clear user data |
| `setEnabled(_:)` | Enable or disable tracking |
| `registerSchema(_:)` | Register an event schema for validation |
| `recentEvents(limit:)` | Get recent tracked events |

### AnalyticsAdapter

| Method | Description |
|--------|-------------|
| `track(_:)` | Track an event |
| `setUser(_:)` | Set user properties |
| `resetUser()` | Clear user data |
| `flush()` | Flush queued events |

## Development

```bash
swift build
swift test
```

## Support

[💬 Bluesky](https://bsky.app/profile/philiprehberger.bsky.social) · [🐦 X](https://x.com/philiprehberger) · [💼 LinkedIn](https://linkedin.com/in/philiprehberger) · [🌐 Website](https://philiprehberger.com) · [📦 GitHub](https://github.com/philiprehberger) · [☕ Buy Me a Coffee](https://buymeacoffee.com/philiprehberger) · [❤️ GitHub Sponsors](https://github.com/sponsors/philiprehberger)

## License

[MIT](LICENSE)
