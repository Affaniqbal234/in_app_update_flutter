## 2.0.2

- Added `homepage` and `issue_tracker` fields to pubspec.yaml for pub.dev sidebar links
- Updated pub.dev topics for better discoverability.
- Updated screenshots for Android immediate and flexible update flow

## 2.0.1

- Added pub.dev screenshots for iOS, Android immediate, and Android flexible update flows
- Updated package description to reflect both iOS (StoreKit) and Android (Play Core) support
- Updated repository URL and author to Axions

## 2.0.0

- Added Android in-app updates support via Google Play's In-App Updates API
- Added `checkUpdateAndroid()` to retrieve update availability and metadata
- Added `startImmediateUpdateAndroid()` for full-screen, blocking update flow
- Added `startFlexibleUpdateAndroid()` for background download update flow
- Added `completeUpdateAndroid()` to apply a downloaded flexible update
- Added `installStateStreamAndroid` stream for monitoring flexible update download progress
- Added `AppUpdateInfoAndroid`, `InstallStateAndroid`, `InstallStatusAndroid`, `UpdateAvailabilityAndroid`, and `UpdateResultAndroid` models
- Renamed `showUpdate()` to `showUpdateForIos()` (old method is deprecated)
- Updated Android toolchain to latest stable versions

## 1.0.4

- Added Swift Package Manager (SPM) support for iOS while maintaining CocoaPods backward compatibility
- Restructured iOS plugin sources into SPM-compatible directory layout
- Updated podspec metadata (version, summary, description, homepage, author)
- Enabled PrivacyInfo.xcprivacy resource bundle
- Fixed iOS unit tests to match actual plugin API
- Shortened package description to meet pub.dev requirements

## 1.0.3

- Restructured plugin with federated architecture pattern

## 1.0.2

- Updated README and package metadata

## 1.0.1

- Minor documentation fixes

## 1.0.0

- Initial release: iOS in-app update support via SKStoreProductViewController (StoreKit)
