import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {}, 
                    child: const Text('Elevated'),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(300, 80),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {}, 
                    child: const Text('Outlined'),
                    style: ElevatedButton.styleFrom(
                    fixedSize: Size(300, 80),
                    ),
                  ),
                  TextButton(
                    onPressed: () {}, 
                    child: const Text('Text'),
                    style: TextButton.styleFrom(
                      fixedSize: Size(300,80),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}