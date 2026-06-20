# in_app_update_flutter

[![pub package](https://img.shields.io/pub/v/in_app_update_flutter.svg)](https://pub.dev/packages/in_app_update_flutter)
[![likes](https://img.shields.io/pub/likes/in_app_update_flutter)](https://pub.dev/packages/in_app_update_flutter)
[![popularity](https://img.shields.io/pub/popularity/in_app_update_flutter)](https://pub.dev/packages/in_app_update_flutter)

A Flutter plugin that provides native in-app update experiences on both iOS and Android using StoreKit on iOS and Google Play In-App Updates on Android.

On **iOS**, it presents the App Store product page using `SKStoreProductViewController` (StoreKit), keeping users inside the app during the update flow. On **Android**, it integrates with Google Play's In-App Updates API to support both immediate (blocking) and flexible (background) update flows.

---

## Platform Support

| Platform | Supported |
|----------|-----------|
| Android | ✅ |
| iOS | ✅ |
| Web | ❌ |
| Windows | ❌ |
| macOS | ❌ |
| Linux | ❌ |

---

## Screenshots

| iOS | Android Immediate | Android Flexible |
|-----|------------------|-----------------|
| ![iOS in-app update](https://raw.githubusercontent.com/axions-org/in_app_update_flutter/production/assets/screenshots/ios-in-app-update.png) | ![Android immediate update](https://raw.githubusercontent.com/axions-org/in_app_update_flutter/production/assets/screenshots/android-immediate-update.png) | ![Android flexible update](https://raw.githubusercontent.com/axions-org/in_app_update_flutter/production/assets/screenshots/android-flexible-update.png) |

---

## Features

- iOS: Show the App Store update prompt using `SKStoreProductViewController` without navigating users away from the app
- iOS: Native Swift implementation with zero AppDelegate configuration required
- iOS: Supports both Swift Package Manager (SPM) and CocoaPods
- Android: Check update availability and metadata via the Play Core API
- Android: Immediate update flow — full-screen, blocking prompt the user must accept
- Android: Flexible update flow — background download while the user continues using the app
- Android: Install state stream for monitoring flexible update download progress
- Works on Flutter with a simple, unified API

---

## Why in_app_update_flutter?

This package offers a unified Flutter API for native in-app updates on both Android and iOS. It supports Google Play's official In-App Updates API on Android and StoreKit-powered App Store update flows on iOS, allowing users to update without leaving the app experience.

---

## Comparison

| Feature | in_app_update_flutter | in_app_update | upgrader |
|----------|----------|----------|----------|
| Android Support | ✅ | ✅ | ✅ |
| iOS Support | ✅ | ❌ | ✅ |
| Native Google Play In-App Updates | ✅ | ✅ | ❌ |
| Android Immediate Updates | ✅ | ✅ | ❌ |
| Android Flexible Updates | ✅ | ✅ | ❌ |
| In-App App Store Experience (iOS) | ✅ | ❌ | ❌ |
| Single Flutter API for Android & iOS | ✅ | ❌ | ✅ |

This package is designed for developers who want native update experiences on both Android and iOS through a unified Flutter API. If you only need Android's Play Core update API, `in_app_update` may be sufficient. If you prefer fully customizable update prompts, `upgrader` may be a better fit.

---

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  in_app_update_flutter: ^2.0.3
```

Then run:

```bash
flutter pub get
```

---

## iOS Usage

Pass your numeric App Store ID to `showUpdateForIos`. The ID can be found in your App Store Connect URL or the app's public App Store link.

```dart
import 'package:in_app_update_flutter/in_app_update_flutter.dart';

await InAppUpdateFlutter().showUpdateForIos(appStoreId: '1234567890');
```

**How to find your App Store ID:**

1. Open your app's App Store URL — for example: `https://apps.apple.com/app/id1234567890`
2. The numeric portion after `id` is your App Store ID.

**iOS notes:**
- Requires iOS 12.0 or later
- Does not work on simulators
- Not supported in TestFlight builds — test on a real device using a development or App Store build

---

## Android Usage

Android uses Google Play's In-App Updates API. The typical flow is:

1. Call `checkUpdateAndroid()` to retrieve update availability and metadata.
2. Based on the result, start either an immediate or flexible update.

### Immediate Update

An immediate update presents a full-screen prompt that the user must complete before continuing. Use this for critical updates.

```dart
import 'package:in_app_update_flutter/in_app_update_flutter.dart';

final plugin = InAppUpdateFlutter();

final info = await plugin.checkUpdateAndroid();

if (info.updateAvailability == UpdateAvailabilityAndroid.updateAvailable &&
    info.isImmediateUpdateAllowed) {
  final result = await plugin.startImmediateUpdateAndroid();
  // result is UpdateResultAndroid.success or UpdateResultAndroid.userCanceled
}
```

### Flexible Update

A flexible update downloads in the background while the user continues using the app. When the download completes, call `completeUpdateAndroid()` to apply the update.

```dart
import 'package:in_app_update_flutter/in_app_update_flutter.dart';

final plugin = InAppUpdateFlutter();

final info = await plugin.checkUpdateAndroid();

if (info.updateAvailability == UpdateAvailabilityAndroid.updateAvailable &&
    info.isFlexibleUpdateAllowed) {
  await plugin.startFlexibleUpdateAndroid();

  plugin.installStateStreamAndroid.listen((state) {
    if (state.installStatus == InstallStatusAndroid.downloaded) {
      plugin.completeUpdateAndroid();
    }
  });
}
```

### AppUpdateInfoAndroid fields

| Field | Type | Description |
|---|---|---|
| `updateAvailability` | `UpdateAvailabilityAndroid` | Whether an update is available |
| `availableVersionCode` | `int?` | Version code of the available update |
| `updatePriority` | `int` | Developer-assigned priority (0–5) |
| `clientVersionStalenessDays` | `int?` | Days since the update became available |
| `isImmediateUpdateAllowed` | `bool` | Whether immediate update is allowed |
| `isFlexibleUpdateAllowed` | `bool` | Whether flexible update is allowed |
| `installStatus` | `InstallStatusAndroid` | Current install status |

---

## Example

A complete working example is available in the [`example/`](example) directory.

```bash
cd example
flutter run
```

---

## FAQ

### Does this package support iOS?

Yes. The package supports iOS using StoreKit's `SKStoreProductViewController`, allowing users to view the App Store product page without leaving the app.

### Does this package support Android?

Yes. The package supports Android through Google Play's official In-App Updates API, including both immediate and flexible update flows.

### Does it work in TestFlight builds?

No. StoreKit-based update testing is not supported through TestFlight and should be tested on a real device using a development or App Store build.

### Does it work on Android emulators?

No. Google Play In-App Updates require installation through Google Play and generally cannot be fully tested on standard emulators.

### Can users continue using the app during an update?

Yes. Flexible updates allow users to continue using the app while the update downloads in the background.

---

## License

[MIT License](LICENSE)

---

## Contributing

Pull requests and feedback are welcome. For major changes, please open an issue first to discuss what you would like to change.

If this package helps your project, consider starring the repository on GitHub and liking the package on pub.dev. Community support helps improve visibility and ongoing maintenance.

