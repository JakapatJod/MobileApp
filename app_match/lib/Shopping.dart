import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormMatch(width: '0', height: '0'),
    );
  }
}

class FormMatch extends StatelessWidget {
  final String width;
  final String height;

  const FormMatch({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Calculate Math App', style: TextStyle(fontSize: 25, color: Colors.white)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            myBtn(context),
            ListTile(
              leading: Icon(Icons.account_balance_wallet_outlined),
              title: Text(
                determineLabel(),
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center myBtn(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Go back!', style: TextStyle(fontSize: 25)),
      ),
    );
  }

  String determineLabel() {
    double parsedWidth = double.tryParse(width) ?? 0.0;       // tryParse เป็นการแปลง String เป็น float โดยใช้คำว้่ Double
    double parsedHeight = double.tryParse(height) ?? 0.0;

    if (parsedWidth > 0.0 && parsedHeight <= 0.0) {       // แสดงผลถ้าใส่แค่ 1 ช่อง
      return 'Radius : ${width}\nArea : ${calculateCircleArea(parsedWidth).toStringAsFixed(2)} \nCircle Perimeter : ${calculateCirclePerimeter(parsedWidth).toStringAsFixed(2)}';
    } else {      // แสดงผลถ้าใส่ 2 ช่องครบ
      return 'Width : ${width}\nHeight : ${height}\nArea : ${calculateRectangleArea(parsedWidth, parsedHeight).toStringAsFixed(2)} \nPerimeter : ${calculateRectanglePerimeter(parsedWidth, parsedHeight).toStringAsFixed(2)}';
    }
  }

  double calculateRectangleArea(double width, double height) {
    return width * height;      // พื่นที่สี่เหลี่ยม
  }

  double calculateRectanglePerimeter(double width, double height) {
    return 2 * (width + height);    // เส้นรอบรูปรอบ
  }

  double calculateCircleArea(double radius) {
    return 3.14159 * radius * radius; // พื่นที่วงกลม
  }

  double calculateCirclePerimeter(double radius) {
    return 2 * 3.14 * radius; // เส้นรอบวงของวงกลม
  }
}
