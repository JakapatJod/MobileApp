import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          icon: Icon(Icons.add_shopping_cart_outlined),
          label: Text("Let's Begin"),
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20.0),
            minimumSize: Size(300, 80),
            textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
            primary: Colors.yellow,
            onPrimary: Colors.black,
            elevation: 15,
            shadowColor: Colors.yellow,
            side: BorderSide(color: Colors.black87, width: 2),
            shape: StadiumBorder(),
          ),
        ),
      ),
    );
  }
}
