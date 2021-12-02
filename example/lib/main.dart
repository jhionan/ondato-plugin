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
                              'eyJhbGciOiJSUzI1NiIsImtpZCI6IkE0QkU3OUQ0NTZCNDQ3NTk2Rjk3MzY5Q0E4QzhBMEU2NkRGRUQ1M0IiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJwTDU1MUZhMFIxbHZsemFjcU1pZzVtMy0xVHMifQ.eyJuYmYiOjE2Mzg0NTQzMzcsImV4cCI6MTYzODU0MDczNywiaXNzIjoiaHR0cHM6Ly9zYW5kYm94LWlkLm9uZGF0by5jb20iLCJhdWQiOlsiaHR0cHM6Ly9zYW5kYm94LWlkLm9uZGF0by5jb20vcmVzb3VyY2VzIiwidmVyaWZpZF9wdWJsaWNfYXBpIl0sImNsaWVudF9pZCI6ImFwcC5vbmRhdG8uZ3JhY2Uta2VubmVkeS0xIiwiY2xpZW50X2FwcGxpY2F0aW9uX2lkIjoiQkRDMERENUMtOUU1Ny00MUFBLUE3NUQtMTJEMUU0NTE3RUE0Iiwic2NvcGUiOlsidmVyaWZpZF9wdWJsaWNfYXBpIl19.TEUJ_s17Det5p-qO59A8lNB8KuSmlMtqvIi8h3O4s9ClyXxHABMmOGUBPSuMBTzRFGhvIbQ8FV2QzoDFGqT5aKdpYRHeCA8vS_LTriJVNBtoBroamvdNk4IcVb0bCYXQ6vjwrM-1J4A3gUhjL3aBil2ooVGWVWV4M_sxbyKJ3qRLvsrXbY7a7fSlN1DAwsybsX7CW7X2uV5AAQuP1ZEpknvbkfnjWIOgYtXlJ_Euw2Wt-5DJ_NSY9mtPuDZPG3cEPr8niyhrrAD9WYWOO7fCPsY198EOZ4CAkymOA3I3oFe5p2nwBVR6r9RLVBCT9Un21q8DTp5N8uhWTzICBkjZ8Q',
                          identificationId: '1a475e4025b34cb098587128cb64717d'),
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
