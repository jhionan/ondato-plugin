
import 'dart:async';

import 'package:flutter/services.dart';

class OndatoSkd {
  static const MethodChannel _channel =
      const MethodChannel('ondato_skd');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
