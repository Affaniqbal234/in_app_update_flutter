import 'package:flutter/services.dart';
import 'package:in_app_update_flutter/src/platform_interface/in_app_update_flutter_platform_interface.dart';

/// An implementation of [InAppUpdateFlutterPlatform] that uses method channels.
class MethodChannelInAppUpdateFlutter extends InAppUpdateFlutterPlatform {
  /// The method channel used to interact with the native platform.
  static const MethodChannel _methodChannel = MethodChannel(
    'in_app_update_flutter',
  );

  @override
  Future<void> showUpdate({required String appStoreId}) async {
    await _methodChannel.invokeMethod('showStoreUpdate', {
      'appStoreId': appStoreId,
    });
  }
}
