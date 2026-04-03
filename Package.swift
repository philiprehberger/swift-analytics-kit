// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "swift-analytics-kit",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .tvOS(.v16),
        .watchOS(.v9)
    ],
    products: [
        .library(name: "AnalyticsKit", targets: ["AnalyticsKit"])
    ],
    targets: [
        .target(
            name: "AnalyticsKit",
            path: "Sources/AnalyticsKit"
        ),
        .testTarget(
            name: "AnalyticsKitTests",
            dependencies: ["AnalyticsKit"],
            path: "Tests/AnalyticsKitTests"
        )
    ]
)
