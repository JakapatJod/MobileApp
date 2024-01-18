import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Let's Begin"),
              Icon(Icons.add_shopping_cart_outlined),
            ],
          ),
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20.0),
            fixedSize: Size(300, 80),
            textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            // primary: Colors.yellow,
            onPrimary: Colors.black,
            // elevation: 15,
            shadowColor: Colors.yellow,
            // side: BorderSide(color: Colors.black87, width: 2),
            shape: StadiumBorder(),
          ),
        ),
      ),
    );
  }
}
