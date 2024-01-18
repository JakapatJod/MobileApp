import 'package:flutter/material.dart';
import 'Shopping.dart';

class MyFORM extends StatefulWidget {
  const MyFORM({Key? key}) : super(key: key);

  @override
  State<MyFORM> createState() => _MyFORMState();
}

class _MyFORMState extends State<MyFORM> {
  var _squareWidth;
  var _squarehigh;

  final _squareWidthController = TextEditingController();
  final _squarehighController = TextEditingController();

  void initState() {
    super.initState();
    _squareWidthController.addListener(_updateText);
    _squarehighController.addListener(_updateText2);
  }

  void _updateText() {
    setState(() {
      _squareWidth = _squareWidthController.text;
    });
  }

  void _updateText2() {
    setState(() {
      _squarehigh = _squarehighController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Calculate',style: TextStyle(fontSize: 35,color: Colors.white),),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _squareWidthController,
              keyboardType: TextInputType.number, // Set keyboardType to allow only numeric input
              decoration: InputDecoration(
                labelText: 'Width or Radius',
                icon: Icon(Icons.calculate),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _squarehighController,
              keyboardType: TextInputType.number, // Set keyboardType to allow only numeric input
              decoration: InputDecoration(
                labelText: 'Height',
                icon: Icon(Icons.calculate),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            myBTN(context),
            SizedBox(height: 10),
            Text(
              "Width (or Radius) is : ${_squareWidthController.text}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Height is : ${_squarehighController.text}",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Center myBTN(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Calculator ', style: TextStyle(fontSize: 20, color: Colors.white)),
            Icon(Icons.calculate),
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return FormMatch(
                  width: _squareWidthController.text,
                  height: _squarehighController.text,
                );
              },
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          fixedSize: Size(300, 80),
          backgroundColor: Colors.lightBlue,
        ),
      ),
    );
  }
}
