import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_update_flutter/in_app_update_flutter_platform_interface.dart';
import 'package:in_app_update_flutter/in_app_update_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockInAppUpdateFlutterPlatform
    with MockPlatformInterfaceMixin
    implements InAppUpdateFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final InAppUpdateFlutterPlatform initialPlatform = InAppUpdateFlutterPlatform.instance;

  test('$MethodChannelInAppUpdateFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelInAppUpdateFlutter>());
  });

  test('getPlatformVersion', () async {
    MockInAppUpdateFlutterPlatform fakePlatform = MockInAppUpdateFlutterPlatform();
    InAppUpdateFlutterPlatform.instance = fakePlatform;
  });
}
