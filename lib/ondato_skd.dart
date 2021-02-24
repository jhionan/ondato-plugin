import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ondato_skd/ondato_config_model.dart';

class OndatoSkd {
  static const MethodChannel _channel = const MethodChannel('ondato_skd');
  static bool _isInit = false;

  static Future<String> get platformVersion async {
    final String version =
        await _channel.invokeMethod(_OndatoSdkChannel.getPlatformVersion);
    return version;
  }

  static Future<bool> init(OndatoServiceConfiguration config) async {
    _isInit = await _channel.invokeMethod<bool>(_OndatoSdkChannel.init);
    return _isInit;
  }

  static Stream<String> startIdentification() async* {
    yield* _channel.invokeMethod(_OndatoSdkChannel.startIdentification).asStream();
  }
}

class _OndatoSdkChannel {
  _OndatoSdkChannel._();
  static const String getPlatformVersion = 'getPlatformVersion';
  static const String init = 'init';
  static const String startIdentification = 'startIdentification';
}
