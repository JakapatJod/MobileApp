import 'package:flutter/material.dart';
import 'personal_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,  
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _name = TextEditingController();
  TextEditingController _sex = TextEditingController();
  TextEditingController _birth = TextEditingController();
  TextEditingController _nationality = TextEditingController();
  TextEditingController _religion = TextEditingController();
  TextEditingController _status = TextEditingController();
  TextEditingController _educational = TextEditingController();
  TextEditingController _gpa = TextEditingController();
  TextEditingController _project = TextEditingController();
  TextEditingController _num1 = TextEditingController();
  TextEditingController _num2 = TextEditingController();
  TextEditingController _num3 = TextEditingController();

  String? _genderError;

  @override
  void initState() {
    _name.text = "";
    _sex.text = "";
    _birth.text = "";
    _nationality.text = "";
    _religion.text = "";
    _status.text = "";
    _educational.text = "";
    _gpa.text = "";
    _project.text = "";
    _num1.text = "";
    _num2.text = "";
    _num3.text = "";

    super.initState();
  }

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'กรุณาใส่ข้อความ';
    } else if (double.tryParse(value) == null) {
      return 'กรุณาใส่ตัวเลข';
    } else if (double.parse(value) <= 0) {
      return 'กรุณาอย่าใส่ค่าต่ำกว่า 0 หรือ ติดลบ';
    }

    if (_sex.text == null) {
      _genderError = 'กรุณาเลือกเพศ';
    } else {
      _genderError = null;
    }
    return _genderError;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register of FITM", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset(
              "assets/images/fitm.jpg",
              height: 250,
            ),
            TextField(
              controller: _name,
              decoration: InputDecoration(
                labelText: "Name - Surname",
                prefixIcon: Icon(Icons.person),
                border: myInputBorder(),
                enabledBorder: myInputBorder(),
                focusedBorder: myFocusBorder(),
                errorText: _validateInput(_name.text),
              ),
            ),
            Container(height: 10),
            TextField(
              controller: _birth,
              decoration: InputDecoration(
                labelText: "Date of birth",
                prefixIcon: Icon(Icons.date_range),
                border: myInputBorder(),
                enabledBorder: myInputBorder(),
                focusedBorder: myFocusBorder(),
              ),
            ),
            Container(height: 10),
            TextField(
              controller: _nationality,
              decoration: InputDecoration(
                labelText: "Nationality",
                prefixIcon: Icon(Icons.flag),
                border: myInputBorder(),
                enabledBorder: myInputBorder(),
                focusedBorder: myFocusBorder(),
              ),
            ),
            Container(height: 10),
            TextField(
              controller: _religion,
              decoration: InputDecoration(
                labelText: "Religion",
                prefixIcon: Icon(Icons.person),
                border: myInputBorder(),
                enabledBorder: myInputBorder(),
                focusedBorder: myFocusBorder(),
              ),
            ),
            Container(height: 10),
            TextField(
              controller: _gpa,
              decoration: InputDecoration(
                labelText: "GPA",
                prefixIcon: Icon(Icons.book),
                border: myInputBorder(),
                enabledBorder: myInputBorder(),
                focusedBorder: myFocusBorder(),
              ),
            ),
            Container(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
              ),
              hint: Text('Sex'),
              items: <String>['Female', 'Male'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _sex.text = value!;
                });
              },
            ),
            Container(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
              ),
              hint: Text('Status'),
              items: <String>['Single', 'Married', 'Divorced'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _status.text = value!;
                });
              },
            ),
            Container(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.school),
              ),
              hint: Text('Educational'),
              items: <String>[
                'Senior High School',
                'Vocational Certificate',
                'Vocational Diploma'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _educational.text = value!;
                });
              },
            ),
            Container(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.school),
              ),
              hint: Text('โครงการรับสมัคร'),
              items: <String>[
                'รับตรงสอบข้อเขียน',
                'โควตาพื้นที่',
                'Portfolio',
                'เรียนดี',
                'รับตรงใช้คะแนน GAT/PAT'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _project.text = value!;
                });
              },
            ),
            Container(height: 10),
            DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.stacked_line_chart),
              ),
              hint: Text('อันดับ 1, 2, 3'),
              items: <String>['1', '2', '3'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _num1.text = value!;
                });
              },
            ),
            Container(height: 10),
            DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.stacked_line_chart),
              ),
              hint: Text('อันดับ 1, 2, 3'),
              items: <String>['1', '2', '3'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _num2.text = value!;
                });
              },
            ),
            Container(height: 10),
            DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.stacked_line_chart),
              ),
              hint: Text('อันดับ 1, 2, 3'),
              items: <String>['1', '2', '3'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _num3.text = value!;
                });
              },
            ),
            Container(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_validateInput(_gpa.text) == null &&
                    _validateInput(_name.text) == null &&
                    _validateInput(_religion.text) == null &&
                    _genderError == null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PersonalPage(
                        name: _name.text,
                        sex: _sex.text,
                        birth: _birth.text,
                        nationality: _nationality.text,
                        religion: _religion.text,
                        status: _status.text,
                        educational: _educational.text,
                        gpa: _gpa.text,
                        project: _project.text,
                        num1: _num1.text,
                        num2: _num2.text,
                        num3: _num3.text,
                      ),
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
              child: Text("Submit"),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder myInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.blue),
    );
  }

  OutlineInputBorder myFocusBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: const Color.fromARGB(255, 6, 42, 72), width: 2),
    );
  }
}
