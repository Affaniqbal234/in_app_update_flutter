import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'in_app_update_flutter_platform_interface.dart';

/// An implementation of [InAppUpdateFlutterPlatform] that uses method channels.
class MethodChannelInAppUpdateFlutter extends InAppUpdateFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('in_app_update_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
