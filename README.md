# 📦 in_app_update_flutter

A Flutter plugin to display an **in-app update prompt for iOS** using the **App Store product page**. This avoids navigating the user out of your app, providing a seamless and native update experience.

---

## ✨ Features

- ✅ Show in-app update prompt using `SKStoreProductViewController`
- ✅ Native Swift implementation
- ✅ No manual setup required in iOS AppDelegate
- ✅ Pass dynamic App Store ID via MethodChannel
- ✅ Works directly from Flutter with a single call

---

## 🛠 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  in_app_update_flutter: ^1.0.0
```

Then run:

```bash
flutter pub get
```

---

## 🚀 Usage

```dart
import 'package:in_app_update_flutter/in_app_update_flutter.dart';

await InAppUpdateFlutter().showUpdate(appStoreId: '1234567890');
```

Make sure to pass your App Store ID (from the app’s public iTunes URL).

---

## 🔍 How to Get Your App Store ID

1. Go to your app’s App Store URL  
   Example: `https://apps.apple.com/app/id1234567890`
2. Extract the numeric ID (without the `id` prefix)
3. Pass it like this:

```dart
await InAppUpdateFlutter().showUpdate(appStoreId: "1234567890");
```

---

## 📱 iOS Notes

- ✅ Supports iOS 12.0+
- ❌ Does **not work on simulators**
- ❌ Not supported in **TestFlight** builds (use App Store or dev builds on real devices)

---

## ✅ Example

A complete working example is available in the [`example/`](example) directory.

```bash
cd example
flutter run
```

---

## 📦 Publisher

Published by [pulkit.sh](https://pub.dev/publishers/pulkit.sh)

---

## 📄 License

[MIT License](LICENSE)

---

## 🤝 Contributing

Pull requests and feedback are welcome!  
For major changes, please open an issue first to discuss what you’d like to change.