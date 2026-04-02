import 'package:in_app_update_flutter/src/platform_interface/in_app_update_flutter_platform_interface.dart';

/// A Flutter plugin to display an in-app update prompt.
///
/// On iOS, this presents the App Store product page using StoreKit,
/// providing a seamless native update experience that keeps users
/// within the app.
class InAppUpdateFlutter {
  /// Shows the platform-specific in-app update UI.
  ///
  /// [appStoreId] is the numeric App Store ID of your app
  /// (found in your App Store Connect URL).
  Future<void> showUpdate({required String appStoreId}) {
    return InAppUpdateFlutterPlatform.instance
        .showUpdate(appStoreId: appStoreId);
  }
}
