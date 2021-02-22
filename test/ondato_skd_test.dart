import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ondato_skd/ondato_skd.dart';

void main() {
  const MethodChannel channel = MethodChannel('ondato_skd');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await OndatoSkd.platformVersion, '42');
  });
}
