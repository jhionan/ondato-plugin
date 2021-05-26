import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ondato_skd/ondato_config_model.dart';

class OndatoSkd {
  OndatoSkd._();
  static const MethodChannel _channel = const MethodChannel('ondato_skd');
  static bool _isInit = false;

  static Future<String> get platformVersion async {
    final String version =
        await _channel.invokeMethod(_OndatoSdkChannel.getPlatformVersion);
    return version;
  }

  static Future<bool> init(OndatoServiceConfiguration config) async {
    _isInit = await _channel.invokeMethod<bool>(
        _OndatoSdkChannel.initialSetup, config.toMap());
    return _isInit;
  }

  static Future<OndatoResponse> startIdentification() async {
    final result = Map.castFrom<dynamic, dynamic, String, Object>(
        await _channel.invokeMethod(_OndatoSdkChannel.startIdentification));

    return OndatoResponse.fromMap(result);
  }
}

class _OndatoSdkChannel {
  _OndatoSdkChannel._();
  static const String getPlatformVersion = 'getPlatformVersion';
  static const String initialSetup = 'initialSetup';
  static const String startIdentification = 'startIdentification';
}
