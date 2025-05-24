import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'in_app_update_flutter_method_channel.dart';

abstract class InAppUpdateFlutterPlatform extends PlatformInterface {
  /// Constructs a InAppUpdateFlutterPlatform.
  InAppUpdateFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static InAppUpdateFlutterPlatform _instance = MethodChannelInAppUpdateFlutter();

  /// The default instance of [InAppUpdateFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelInAppUpdateFlutter].
  static InAppUpdateFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [InAppUpdateFlutterPlatform] when
  /// they register themselves.
  static set instance(InAppUpdateFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
