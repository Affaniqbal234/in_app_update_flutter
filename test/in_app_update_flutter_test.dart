import 'package:in_app_update_flutter/src/method_channel/in_app_update_flutter_method_channel.dart';
import 'package:in_app_update_flutter/src/platform_interface/in_app_update_flutter_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

/// A valid mock that extends [InAppUpdateFlutterPlatform], giving it
/// the correct token so it can be set as the platform instance.
class _MockPlatform extends InAppUpdateFlutterPlatform {
  String? lastAppStoreId;

  @override
  Future<void> showUpdate({required String appStoreId}) async {
    lastAppStoreId = appStoreId;
  }
}

/// Minimal subclass that does NOT override the abstract methods,
/// so calls fall through to the base-class throw.
class _UnimplementedPlatform extends InAppUpdateFlutterPlatform {}

void main() {
  group('InAppUpdateFlutterPlatform', () {
    tearDown(() {
      // Restore default instance after each test.
      InAppUpdateFlutterPlatform.instance = MethodChannelInAppUpdateFlutter();
    });

    test('default instance is MethodChannelInAppUpdateFlutter', () {
      expect(
        InAppUpdateFlutterPlatform.instance,
        isA<MethodChannelInAppUpdateFlutter>(),
      );
    });

    test('instance can be replaced with a valid mock', () {
      final mock = _MockPlatform();
      InAppUpdateFlutterPlatform.instance = mock;
      expect(InAppUpdateFlutterPlatform.instance, same(mock));
    });

    test('setting instance back to MethodChannel works', () {
      InAppUpdateFlutterPlatform.instance = _MockPlatform();
      InAppUpdateFlutterPlatform.instance = MethodChannelInAppUpdateFlutter();
      expect(
        InAppUpdateFlutterPlatform.instance,
        isA<MethodChannelInAppUpdateFlutter>(),
      );
    });

    group('base class throws UnimplementedError', () {
      test('showUpdate throws UnimplementedError', () {
        final platform = _UnimplementedPlatform();
        expect(
          () => platform.showUpdate(appStoreId: '123'),
          throwsA(isA<UnimplementedError>()),
        );
      });
    });

    group('mock platform delegates', () {
      test('showUpdate passes appStoreId to mock', () async {
        final mock = _MockPlatform();
        InAppUpdateFlutterPlatform.instance = mock;

        await InAppUpdateFlutterPlatform.instance
            .showUpdate(appStoreId: '544007664');
        expect(mock.lastAppStoreId, '544007664');
      });
    });
  });
}
