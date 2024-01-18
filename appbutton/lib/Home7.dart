import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('AlertDialog Title'),
              content: const Text('AlertDialog description'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Ok'),
                  child: const Text('Ok'),
                ),
              ],
            ),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20.0),
            minimumSize: Size(300, 80),
            textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            primary: Colors.yellow,
            onPrimary: Colors.black,
            elevation: 15,
            shadowColor: Colors.yellow,
            side: BorderSide(color: Colors.black87, width: 2),
            shape: StadiumBorder(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Let's Begin"),
              Icon(Icons.add_shopping_cart_outlined),
            ],
          ),
        ),
        
      ),
    );
  }
}
