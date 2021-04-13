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
                          accessToken: 'eyJhbGciOiJSUzI1NiIsImtpZCI6IkE0QkU3OUQ0NTZCNDQ3NTk2Rjk3MzY5Q0E4QzhBMEU2NkRGRUQ1M0IiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJwTDU1MUZhMFIxbHZsemFjcU1pZzVtMy0xVHMifQ.eyJuYmYiOjE2MTgyMzU0NjAsImV4cCI6MTYxODMyMTg2MCwiaXNzIjoiaHR0cHM6Ly9pZC5vbmRhdG8uY29tIiwiYXVkIjpbImh0dHBzOi8vaWQub25kYXRvLmNvbS9yZXNvdXJjZXMiLCJ2ZXJpZmlkX3B1YmxpY19hcGkiXSwiY2xpZW50X2lkIjoiYXBwLm9uZGF0by5jcmVkaXRpbmZvamFtYWljYWRlbW8iLCJjbGllbnRfYXBwbGljYXRpb25faWQiOiI1Y2JiM2QxYi00YmQwLTQ2NzgtOTAzYS1lYWM3ZmQ4YjJjYjQiLCJzY29wZSI6WyJ2ZXJpZmlkX3B1YmxpY19hcGkiXX0.nU_sxMdJxeA7uXBidjk9Mregip4IgH1dxqzQPwLwCyp4EJaeQsE1gSme4Hn0dF5TETZcI9KRNkR1wwJlRHgDvqjZjaUid1YY8iZJ8Nmc7gtiEt-F4U7WWVxb7nCwzhWW-HBZ3oyNWoW7aQm2558z_b2ll9vKSa4mGSFSxozEwCwwlQyJAGhXci1YK3UMckOzYTGi0sS8H2RjY6R8jWp55LsZJ0VPjJVQgYErBpMDG_cHH5G3ehs_RWJcX2o5LqgsSw2UDDLIY8vbAAU5E4YR6aCM2YfH_7kWAHTigVFgIyY-Kq_8_WpTpsraQ_w4e1dMfVemOcM4uSrf9RfZMPsAVA',
                          identificationId: '0fe67a1171424a08ad8244f480707ea2'),
                      mode: OndatoEnvironment.live,
                      appearance: OndatoIosAppearance(  
                          buttonColor: Colors.redAccent,
                          logoImageBase64: base64.encode((await rootBundle
                                  .load('assets/grace_kennedy_logo.jpg'))
                              .buffer
                              .asUint8List())),
                    ),
                  );
                  print(await OndatoSkd.startIdentification().first);
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
