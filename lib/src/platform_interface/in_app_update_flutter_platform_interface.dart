import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:in_app_update_flutter/src/method_channel/in_app_update_flutter_method_channel.dart';

/// The platform interface for the `in_app_update_flutter` plugin.
///
/// This class defines the API that platform-specific implementations
/// must implement. It uses the [PlatformInterface] pattern to ensure
/// safe extension and prevent accidental breaking changes.
abstract class InAppUpdateFlutterPlatform extends PlatformInterface {
  /// Constructs an InAppUpdateFlutterPlatform.
  InAppUpdateFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static InAppUpdateFlutterPlatform _instance =
      MethodChannelInAppUpdateFlutter();

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

  /// Shows the platform-specific in-app update UI.
  ///
  /// On iOS, this presents the App Store product page using StoreKit.
  /// [appStoreId] is the numeric App Store ID of your app.
  Future<void> showUpdate({required String appStoreId}) {
    throw UnimplementedError('showUpdate() has not been implemented.');
  }
}
