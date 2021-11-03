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
                              'eyJhbGciOiJSUzI1NiIsImtpZCI6IkE0QkU3OUQ0NTZCNDQ3NTk2Rjk3MzY5Q0E4QzhBMEU2NkRGRUQ1M0IiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJwTDU1MUZhMFIxbHZsemFjcU1pZzVtMy0xVHMifQ.eyJuYmYiOjE2MzU5NjI0NDcsImV4cCI6MTYzNjA0ODg0NywiaXNzIjoiaHR0cHM6Ly9zYW5kYm94LWlkLm9uZGF0by5jb20iLCJhdWQiOlsiaHR0cHM6Ly9zYW5kYm94LWlkLm9uZGF0by5jb20vcmVzb3VyY2VzIiwidmVyaWZpZF9wdWJsaWNfYXBpIl0sImNsaWVudF9pZCI6ImFwcC5vbmRhdG8uZ3JhY2Uta2VubmVkeS0xIiwiY2xpZW50X2FwcGxpY2F0aW9uX2lkIjoiQkRDMERENUMtOUU1Ny00MUFBLUE3NUQtMTJEMUU0NTE3RUE0Iiwic2NvcGUiOlsidmVyaWZpZF9wdWJsaWNfYXBpIl19.OCpe8ShmS664TV1yElDzHcmBapvxlU7To2e0UBmY8KUblnS7r0WpQsC7MaIdpcLODGJ5tLldEjXlXE4eteTX1CNFARWeHPgfvieohSHqZuxq2FW2sQegkGYWO6TM8r9RUNk8FtaUaoIAmI7o2sfvXa9jV0MMM7ZS-7eCmXICvo2dsxEgnlNZS5tIdlDc3CcqveqO5a_1cmJ7mQYxRrW3i7soOj4s7qFex_ViO0zYcufpu7GgNLbwPQkgtxdNgqhSUQFench_u5nOQo6ZgaFOEC6dhZUkhmbPiewKF4TluKrFo4Mi8KcAD4glEMTP6uumHaDfSnS5vMFL9F6pJ9dA2w',
                          identificationId: '7c1e5813eae84113b58ea5b2f6c70b2c'),
                      mode: OndatoEnvironment.test,
                      flowConfiguration: OndatoFlowConfiguration(
                        recordProcess: false
                      ),
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
