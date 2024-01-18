import 'package:flutter/material.dart';
import 'cal.dart';

class MyFORM extends StatefulWidget {
  const MyFORM({Key? key}) : super(key: key);

  @override
  State<MyFORM> createState() => _MyFORMState();
}

class _MyFORMState extends State<MyFORM> {
  var _weight;
  var _height;
  var _age;
  var _selectedGender; 

  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  void initState() {
    super.initState();
    _weightController.addListener(_updateText);
    _heightController.addListener(_updateText2);
    _ageController.addListener(_updateText3);
  }

  void _updateText() {
    setState(() {
      _weight = _weightController.text;
    });
  }

  void _updateText2() {
    setState(() {
      _height = _heightController.text;
    });
  }

  void _updateText3() {
    setState(() {
      _age = _ageController.text;
    });
  }

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'กรุณาใส่ข้อความ';
    } else if (double.tryParse(value) == null) {
      return 'กรุณาใส่ตัวเลข';
    } else if (double.parse(value) <= 0) {
      return 'กรุณาอย่าใส่ค่าต่ำกว่า 0 หรือ ติดลบ';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Calculate BMI', style: TextStyle(fontSize: 35, color: Colors.white)),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Age',
                icon: Icon(Icons.calculate),
                border: OutlineInputBorder(),
                errorText: _validateInput(_age),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Weight',
                icon: Icon(Icons.calculate),
                border: OutlineInputBorder(),
                errorText: _validateInput(_weight),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Height',
                icon: Icon(Icons.calculate),
                border: OutlineInputBorder(),
                errorText: _validateInput(_height),
              ),
            ),
            SizedBox(height: 20),
            myBTN(context),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Center myBTN(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Calculator ', style: TextStyle(fontSize: 20, color: Colors.white)),
                Icon(Icons.calculate),
              ],
            ),
            onPressed: () {
              if (_validateInput(_age) == null &&
                  _validateInput(_weight) == null &&
                  _validateInput(_height) == null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return FormMatch(
                        age: _ageController.text,
                        width: _weightController.text,
                        height: _heightController.text,
                        gender: _selectedGender, 
                      );
                    },
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('กรุณาตรวจสอบความถูกต้องของข้อมูล'),
                    duration: Duration(seconds: 3),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(300, 80),
              backgroundColor: Colors.orange,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Radio(
                    value: 'male',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                  Text('Man', style: TextStyle(fontSize: 16)),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 'female',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                  Text('Female', style: TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
