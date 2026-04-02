import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_update_flutter/src/method_channel/in_app_update_flutter_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const methodChannel = MethodChannel('in_app_update_flutter');

  late MethodChannelInAppUpdateFlutter plugin;

  setUp(() {
    plugin = MethodChannelInAppUpdateFlutter();
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(methodChannel, null);
  });

  group('MethodChannelInAppUpdateFlutter', () {
    group('showUpdate', () {
      test('calls showStoreUpdate method on the channel', () async {
        String? invokedMethod;
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(methodChannel, (call) async {
          invokedMethod = call.method;
          return null;
        });

        await plugin.showUpdate(appStoreId: '544007664');
        expect(invokedMethod, 'showStoreUpdate');
      });

      test('passes appStoreId argument to the channel', () async {
        Map<dynamic, dynamic>? invokedArgs;
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(methodChannel, (call) async {
          invokedArgs = call.arguments as Map<dynamic, dynamic>;
          return null;
        });

        await plugin.showUpdate(appStoreId: '544007664');
        expect(invokedArgs, {'appStoreId': '544007664'});
      });

      test('propagates platform errors', () async {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(methodChannel, (call) async {
          throw PlatformException(
            code: 'STORE_ERROR',
            message: 'Failed to load product',
          );
        });

        expect(
          () => plugin.showUpdate(appStoreId: '544007664'),
          throwsA(isA<PlatformException>()),
        );
      });
    });
  });
}
