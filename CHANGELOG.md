# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2026-04-02

### Added
- `Analytics` class for centralized event tracking
- `AnalyticsAdapter` protocol for plug-in analytics backends
- `ConsoleAdapter` built-in adapter for debug logging
- `AnalyticsEvent` struct with name, properties, and timestamp
- `EventSchema` for validating event properties
- `UserProperties` for managing user identity
- `trackScreen` SwiftUI view modifier for automatic screen tracking
- `AnalyticsDebugDashboard` SwiftUI view for inspecting recent events
- `setEnabled` to globally enable/disable tracking
- Zero external dependencies
