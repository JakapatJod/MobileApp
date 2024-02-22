import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double x = 0, y = 0, z = 0;
  String direction = "none";

  @override
  void initState() {
    super.initState();
    gyroscopeEvents.listen((GyroscopeEvent event) {
      print(event);
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;
        // Rough calculation, you can use advance formula to calculate the orientation
        if (x > 0) {
          direction = "back";
        } else if (x < 0) {
          direction = "forward";
        } else if (y > 0) {
          direction = "left";
        } else if (y < 0) {
          direction = "right";
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gyroscope Sensor in Flutter"),
        backgroundColor: Color.fromARGB(255, 82, 220, 255),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Direction: $direction",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "X: $x",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Y: $y",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Z: $z",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
