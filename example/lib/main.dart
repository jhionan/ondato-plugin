import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ondato_skd/ondato_config_model.dart';
import 'package:ondato_skd/ondato_skd.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await OndatoSkd.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              TextButton(
                onPressed: () async {
                  await OndatoSkd.init(
                    OndatoServiceConfiguration(
                      credentials: OndataCredencials(
                          accessToken:
                              'eyJhbGciOiJSUzI1NiIsImtpZCI6IkE0QkU3OUQ0NTZCNDQ3NTk2Rjk3MzY5Q0E4QzhBMEU2NkRGRUQ1M0IiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJwTDU1MUZhMFIxbHZsemFjcU1pZzVtMy0xVHMifQ.eyJuYmYiOjE2Mzc5NTMxNTQsImV4cCI6MTYzODAzOTU1NCwiaXNzIjoiaHR0cHM6Ly9zYW5kYm94LWlkLm9uZGF0by5jb20iLCJhdWQiOlsiaHR0cHM6Ly9zYW5kYm94LWlkLm9uZGF0by5jb20vcmVzb3VyY2VzIiwidmVyaWZpZF9wdWJsaWNfYXBpIl0sImNsaWVudF9pZCI6ImFwcC5vbmRhdG8uZ3JhY2Uta2VubmVkeS0xIiwiY2xpZW50X2FwcGxpY2F0aW9uX2lkIjoiQkRDMERENUMtOUU1Ny00MUFBLUE3NUQtMTJEMUU0NTE3RUE0Iiwic2NvcGUiOlsidmVyaWZpZF9wdWJsaWNfYXBpIl19.qkQkV6bePcuQoYUgVSEdw3b7vySocoml7Dxazmnm70p4g3UiXOQXgSPNx3MFwjbAm7tE55cvFX0NHzfAjYhIaJ5izNm-ZsDduXc-YErrcN3etWt4uH-EmkMfcn481HMhWYxphHaNjx3voY-kfMEJKdgbe1lxAPSeQCH_lGS-BQOlABfXzNiHgehUFESrI-0xOARd1b4SgplrgI6tF4T1HIH16QutdK1ipLZ63di8xXE6ME1Dxd-bvP2uwgsC-AaEscGLYo0k39-wuPZOEsdzTMDMAjDvjfxquX86LSBFF179NgYwQ-pBOuUk94rM1y8gmtNA_fWz-uSVfjfSHUGJhA',
                          identificationId: '76a4b48b931e415eab19456c8bd65ca2'),
                      mode: OndatoEnvironment.test,
                      flowConfiguration:
                          OndatoFlowConfiguration(recordProcess: false),
                      appearance: OndatoIosAppearance(
                          buttonColor: Colors.redAccent,
                          logoImageBase64: base64.encode((await rootBundle
                                  .load('assets/grace_kennedy_logo.jpg'))
                              .buffer
                              .asUint8List())),
                    ),
                  );
                  print(await OndatoSkd.startIdentification());
                  print('finished process');
                },
                child: Text('startIdentification'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
