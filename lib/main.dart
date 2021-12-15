import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '端末id取得',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '端末id取得'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _id = "";

  void _getTerminalId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      //Android端末
      var androidInfo = await deviceInfo.androidInfo;
      _setTerminalId(androidInfo.androidId);
      print(androidInfo.androidId);
    } else if (Platform.isIOS) {
      //iOS端末
      var iosDeviceInfo = await deviceInfo.iosInfo;
      _setTerminalId(iosDeviceInfo.identifierForVendor);
    } else {
      //その他...
      _setTerminalId("その他の端末らしいです");
    }
  }

  void _setTerminalId(String terminalId) {
    print(terminalId);
    setState(() {
      //_idに入れ込む
      _id = terminalId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _id,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getTerminalId,
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
