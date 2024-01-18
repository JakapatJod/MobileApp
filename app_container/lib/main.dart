import 'package:app_container/Moneybox.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          " Account Balance New ",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 6, 52, 239),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              height: 120,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.blue.shade200,
                borderRadius: BorderRadius.circular(20)),
              child: InputDecoratorExample(),
            ), 
            MoneyBox(
              title: "ยอดคงเหลือ",
              amount: 30000.514,
              sizeConHeight: 120,
              colorset: Colors.lightBlue,
            ),
            SizedBox(height: 2),
            MoneyBox(
              title: "รายรับ",
              amount: 10000,
              sizeConHeight: 100,
              colorset: Colors.green,
            ),
            SizedBox(height: 2),
            MoneyBox(
              title: "รายจ่าย",
              amount: 80000,
              sizeConHeight: 100,
              colorset: Colors.orange,
            ),
            SizedBox(height: 2),
            MoneyBox(
              title: "ค้างจ่าย",
              amount: 4000.15,
              sizeConHeight: 100,
              colorset: Colors.yellow.shade600,
            ),
            Container(
              child: TextButton(
                child: Text(
                  "button",
                  style: TextStyle(fontSize: 30),
                ),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.green,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputDecoratorExample extends StatelessWidget {
  const InputDecoratorExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Account Name',
        labelStyle: MaterialStateTextStyle.resolveWith(
          (Set<MaterialState> states) {
            final Color color = states.contains(MaterialState.error)
                ? Theme.of(context).errorColor
                : Colors.orange;
            return TextStyle(color: color, letterSpacing: 1.3);
          },
        ),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Enter name';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.always,
    );
  }
}

