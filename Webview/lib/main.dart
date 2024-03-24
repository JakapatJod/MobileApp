import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QRCode(title: 'Test Qr Code'), 
      debugShowCheckedModeBanner: false,

    );
  }
}

class QRCode extends StatefulWidget {
  const QRCode({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<QRCode> createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  String? _qrInfo = "Scan";
  bool _camState = false;

  Widget showButton() {
    return ElevatedButton.icon(
      onPressed: () {
        print("Pressed Scan");
        setState(() {
          _camState = true;
        });
      },
      icon: Icon(Icons.qr_code_2_outlined),
      label: Text("Scan"),
    );
  }

  void _qrCallback(String? code) {
    setState(() {
      _camState = false;
      _qrInfo = code;
    });
  }

  void _scanCode() {
    setState(() {
      _camState = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _scanCode(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          _camState ? showScanner() : Container(),
          showButton(),
          Text(_qrInfo ??
              "Scan"), 
        ],
      ),
    );
  }

  Widget showScanner() {
    return Container(
      child: SizedBox(
        height: 200,
        width: 200,
        child: QRBarScannerCamera(
          onError: (context, error) => Text(
            error.toString(),
            style: TextStyle(color: Colors.red),
          ),
          qrCodeCallback: (code) {
            _qrCallback(code);
          },
        ),
      ),
    );
  }
}
