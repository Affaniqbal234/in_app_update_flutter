import 'package:flutter/services.dart';

class InAppUpdateFlutter {
  final MethodChannel _channel = MethodChannel('in_app_update_flutter');

  Future<void> showUpdate({required String appStoreId}) async {
    await _channel.invokeMethod('showStoreUpdate', {
      'appStoreId': appStoreId,
    });
  }
}
