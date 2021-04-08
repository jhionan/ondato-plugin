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
                          accessToken: 'eyJhbGciOiJSUzI1NiIsImtpZCI6IkE0QkU3OUQ0NTZCNDQ3NTk2Rjk3MzY5Q0E4QzhBMEU2NkRGRUQ1M0IiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJwTDU1MUZhMFIxbHZsemFjcU1pZzVtMy0xVHMifQ.eyJuYmYiOjE2MTc4OTY3NjksImV4cCI6MTYxNzk4MzE2OSwiaXNzIjoiaHR0cHM6Ly9pZC5vbmRhdG8uY29tIiwiYXVkIjpbImh0dHBzOi8vaWQub25kYXRvLmNvbS9yZXNvdXJjZXMiLCJ2ZXJpZmlkX3B1YmxpY19hcGkiXSwiY2xpZW50X2lkIjoiYXBwLm9uZGF0by5jcmVkaXRpbmZvamFtYWljYWRlbW8iLCJjbGllbnRfYXBwbGljYXRpb25faWQiOiI1Y2JiM2QxYi00YmQwLTQ2NzgtOTAzYS1lYWM3ZmQ4YjJjYjQiLCJzY29wZSI6WyJ2ZXJpZmlkX3B1YmxpY19hcGkiXX0.ua1IaQabKvFa-GtQL872avm8wMm22NuH5VNOpKkpuiAl8WKEDHQVnHIVnfawQBtA1BdzYRgvOxghHvKeOvV0pGbapgXHQ4c3qkQigdbqouo3Y7gMlq6H_3U5gvUC5ql4StNRsqM9V0ta47X7Oai088vb56a4-ioac_pHhOOnMqNN3T-Vga0dpoNfiF20AgCl3A2tbZfNvxuWzaFzQ9UPb4kFmav-bMlvCRkWFTRC7fGxfM9CE6Gp72l6oS_xPQRqAj0I-cbFYDkG59ngbDy1ANDikiT8zvCZevSdf-Xddhffz3Ohw_echz82LPBrxcFqf9PmwJxuZ7waoAciTIpfWQ',
                          identificationId: '1477e4d54170442f97dbeff3808283d8'),
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
