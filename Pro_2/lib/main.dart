import 'package:flutter/material.dart';
import 'personal_page.dart';
import 'package:flutter/services.dart';

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
  TextEditingController _email = TextEditingController();
  TextEditingController _school = TextEditingController();

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
    _email.text = "";
    _school.text = "";

    super.initState();
  }

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'กรุณาใส่ข้อความ';
    }
    if (_birth.text.isEmpty) {
      return 'กรุณาเลือกใส่วันเดือนปีเกิด';
    }
    if (_sex.text.isEmpty) {
      return 'กรุณาเลือกเพศ';
    }

    if (_status.text.isEmpty) {
      return 'กรุณาเลือกสถานะ';
    }

    if (_educational.text.isEmpty) {
      return 'กรุณาเลือกระดับการศึกษา';
    }

    if (_school.text.isEmpty) {
      return 'กรุณาใส่สถาบันที่จบการศึกษา';
    }

    if (_email.text.isEmpty) {
      return 'กรุณาใส่ Email ของท่าน';
    }

    if (_project.text.isEmpty) {
      return 'กรุณาเลือกโครงการรับสมัคร';
    }

    double gpaValue = double.tryParse(_gpa.text) ?? -1.0;

    if (gpaValue < 0.0 || gpaValue > 4.0) {
      return 'GPA ต้องอยู่ในช่วง 0.00 ถึง 4.00';
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
              "assets/images/imgfitm.jpg",
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
                errorText: _validateInput(_birth.text),
                hintText: "e.g., 20 / 01 / 2024",
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
                errorText: _validateInput(_nationality.text),
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
                errorText: _validateInput(_religion.text),
              ),
            ),
            Container(height: 10),
            TextField(
              controller: _school,
              decoration: InputDecoration(
                labelText: "School",
                prefixIcon: Icon(Icons.school),
                border: myInputBorder(),
                enabledBorder: myInputBorder(),
                focusedBorder: myFocusBorder(),
                errorText: _validateInput(_school.text),
              ),
            ),
            Container(height: 10),
            TextField(
              controller: _email,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.add_box),
                border: myInputBorder(),
                enabledBorder: myInputBorder(),
                focusedBorder: myFocusBorder(),
                errorText: _validateInput(_email.text),
              ),
            ),
            Container(height: 10),
            TextField(
              controller: _gpa,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$')),
              ],
              decoration: InputDecoration(
                labelText: "GPA",
                prefixIcon: Icon(Icons.book),
                border: myInputBorder(),
                enabledBorder: myInputBorder(),
                focusedBorder: myFocusBorder(),
                errorText: _validateInput(_gpa.text),
                hintText: "3.34",
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
              items:
                  <String>['Single', 'Married', 'Divorced'].map((String value) {
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
                'มัธยมปลาย',
                'ประกาศนียบัตรวิชาชีพ ( ป.ว.ช )',
                'ประกาศนียบัตรวิชาชีพชั้นสูง ( ป.ว.ส )'
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
              items: <String>[
                'ภาควิชาเทคโนโลยีสารสนเทศ หลักสูตร 4 ปีรับ ม.6 ปวช, สาขาวิชาเทคโนโลยีสารสนเทศ (IT)\n',
                'ภาควิชาเทคโนโลยีสารสนเทศ หลักสูตร 4 ปีรับ ม.6 ปวช, สาขาวิชาวิศวกรรมสารสนเทศและเครือข่าย (INE)\n',
                'ภาควิชาเทคโนโลยีสารสนเทศ หลักสูตร ต่อเนื่อง รับ ปวส, สาขาวิชาเทคโนโลยีสารสนเทศ (ITI)\n',
                'ภาควิชาเทคโนโลยีสารสนเทศ หลักสูตร ต่อเนื่อง รับ ปวส, สาขาวิชาวิศวกรรมสารสนเทศและเครือข่าย (INET)\n',
                'ภาควิชาการจัดการอุตสาหกรรม หลักสูตร 4 ปีรับ ม.6 ปวช, สาขาวิชาวิศวกรรมอุตสาหการและการจัดการ (IEM)\n',
                'ภาควิชาการจัดการอุตสาหกรรม  หลักสูตร 4 ปีรับ ม.6 ปวช, สาขาวิชาเทคโนโลยีเครื่องกลและกระบวนการผลิต (MM)\n',
                'ภาควิชาการจัดการอุตสาหกรรม  หลักสูตร ต่อเนื่อง รับ ปวส, สาขาวิชาการจัดการอุตสาหกรรม (IMT)\n',
                'ภาควิชาการจัดการอุตสาหกรรม  หลักสูตร ต่อเนื่อง รับ ปวส, สาขาวิชาเทคโนโลยีเครื่องกลและกระบวนการผลิต (MMT)\n',
                'ภาควิชาวิศวกรรมเกษตรเพื่ออุตสาหกรรม  หลักสูตร 4 ปีรับ ม.6 ปวช, สาขาวิชาวิศวกรรมเกษตรและอาหาร (AFE)\n',
                'ภาควิชาวิศวกรรมเกษตรเพื่ออุตสาหกรรม  หลักสูตร ต่อเนื่อง รับ ปวส, สาขาวิชาวิศวกรรมเกษตรและอาหาร (AFET)\n',
                'ภาควิชาการออกแบบและบริหารงานก่อสร้าง  หลักสูตร 4 ปีรับ ม.6 ปวช, สาขาวิชาคอมพิวเตอร์ออกแบบและบริหารงานก่อสร้าง (CA)\n',
                'ภาควิชาการออกแบบและบริหารงานก่อสร้าง  หลักสูตร ต่อเนื่อง รับ ปวส, สาขาวิชาคอมพิวเตอร์ออกแบบและบริหารงานก่อสร้าง (CDM)\n',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _num1.text = value!;
                  if (value == _num2.text || value == _num3.text) {
                    _num2.text = '';
                    _num3.text = '';
                  }
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
              items: <String>[
                'ภาควิชาเทคโนโลยีสารสนเทศ หลักสูตร 4 ปีรับ ม.6 ปวช, สาขาวิชาเทคโนโลยีสารสนเทศ (IT)\n',
                'ภาควิชาเทคโนโลยีสารสนเทศ หลักสูตร 4 ปีรับ ม.6 ปวช, สาขาวิชาวิศวกรรมสารสนเทศและเครือข่าย (INE)\n',
                'ภาควิชาเทคโนโลยีสารสนเทศ หลักสูตร ต่อเนื่อง รับ ปวส, สาขาวิชาเทคโนโลยีสารสนเทศ (ITI)\n',
                'ภาควิชาเทคโนโลยีสารสนเทศ หลักสูตร ต่อเนื่อง รับ ปวส, สาขาวิชาวิศวกรรมสารสนเทศและเครือข่าย (INET)\n',
                'ภาควิชาการจัดการอุตสาหกรรม หลักสูตร 4 ปีรับ ม.6 ปวช, สาขาวิชาวิศวกรรมอุตสาหการและการจัดการ (IEM)\n',
                'ภาควิชาการจัดการอุตสาหกรรม  หลักสูตร 4 ปีรับ ม.6 ปวช, สาขาวิชาเทคโนโลยีเครื่องกลและกระบวนการผลิต (MM)\n',
                'ภาควิชาการจัดการอุตสาหกรรม  หลักสูตร ต่อเนื่อง รับ ปวส, สาขาวิชาการจัดการอุตสาหกรรม (IMT)\n',
                'ภาควิชาการจัดการอุตสาหกรรม  หลักสูตร ต่อเนื่อง รับ ปวส, สาขาวิชาเทคโนโลยีเครื่องกลและกระบวนการผลิต (MMT)\n',
                'ภาควิชาวิศวกรรมเกษตรเพื่ออุตสาหกรรม  หลักสูตร 4 ปีรับ ม.6 ปวช, สาขาวิชาวิศวกรรมเกษตรและอาหาร (AFE)\n',
                'ภาควิชาวิศวกรรมเกษตรเพื่ออุตสาหกรรม  หลักสูตร ต่อเนื่อง รับ ปวส, สาขาวิชาวิศวกรรมเกษตรและอาหาร (AFET)\n',
                'ภาควิชาการออกแบบและบริหารงานก่อสร้าง  หลักสูตร 4 ปีรับ ม.6 ปวช, สาขาวิชาคอมพิวเตอร์ออกแบบและบริหารงานก่อสร้าง (CA)\n',
                'ภาควิชาการออกแบบและบริหารงานก่อสร้าง  หลักสูตร ต่อเนื่อง รับ ปวส, สาขาวิชาคอมพิวเตอร์ออกแบบและบริหารงานก่อสร้าง (CDM)\n',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _num2.text = value!;
                  if (value == _num1.text || value == _num3.text) {
                    _num1.text = '';
                    _num3.text = '';
                  }
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
              items: <String>[
                'ภาควิชาเทคโนโลยีสารสนเทศ หลักสูตร 4 ปีรับ ม.6 ปวช, สาขาวิชาเทคโนโลยีสารสนเทศ (IT)\n',
                'ภาควิชาเทคโนโลยีสารสนเทศ หลักสูตร 4 ปีรับ ม.6 ปวช, สาขาวิชาวิศวกรรมสารสนเทศและเครือข่าย (INE)\n',
                'ภาควิชาเทคโนโลยีสารสนเทศ หลักสูตร ต่อเนื่อง รับ ปวส, สาขาวิชาเทคโนโลยีสารสนเทศ (ITI)\n',
                'ภาควิชาเทคโนโลยีสารสนเทศ หลักสูตร ต่อเนื่อง รับ ปวส, สาขาวิชาวิศวกรรมสารสนเทศและเครือข่าย (INET)\n',
                'ภาควิชาการจัดการอุตสาหกรรม หลักสูตร 4 ปีรับ ม.6 ปวช, สาขาวิชาวิศวกรรมอุตสาหการและการจัดการ (IEM)\n',
                'ภาควิชาการจัดการอุตสาหกรรม  หลักสูตร 4 ปีรับ ม.6 ปวช, สาขาวิชาเทคโนโลยีเครื่องกลและกระบวนการผลิต (MM)\n',
                'ภาควิชาการจัดการอุตสาหกรรม  หลักสูตร ต่อเนื่อง รับ ปวส, สาขาวิชาการจัดการอุตสาหกรรม (IMT)\n',
                'ภาควิชาการจัดการอุตสาหกรรม  หลักสูตร ต่อเนื่อง รับ ปวส, สาขาวิชาเทคโนโลยีเครื่องกลและกระบวนการผลิต (MMT)\n',
                'ภาควิชาวิศวกรรมเกษตรเพื่ออุตสาหกรรม  หลักสูตร 4 ปีรับ ม.6 ปวช, สาขาวิชาวิศวกรรมเกษตรและอาหาร (AFE)\n',
                'ภาควิชาวิศวกรรมเกษตรเพื่ออุตสาหกรรม  หลักสูตร ต่อเนื่อง รับ ปวส, สาขาวิชาวิศวกรรมเกษตรและอาหาร (AFET)\n',
                'ภาควิชาการออกแบบและบริหารงานก่อสร้าง  หลักสูตร 4 ปีรับ ม.6 ปวช, สาขาวิชาคอมพิวเตอร์ออกแบบและบริหารงานก่อสร้าง (CA)\n',
                'ภาควิชาการออกแบบและบริหารงานก่อสร้าง  หลักสูตร ต่อเนื่อง รับ ปวส, สาขาวิชาคอมพิวเตอร์ออกแบบและบริหารงานก่อสร้าง (CDM)\n',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _num3.text = value!;
                  if (value == _num1.text || value == _num2.text) {
                    _num1.text = '';
                    _num2.text = '';
                  }
                });
              },
            ),
            Container(height: 20),

            ElevatedButton(
              onPressed: () {
                if (_validateInput(_gpa.text) == null &&
                    _validateInput(_name.text) == null &&
                    _validateInput(_num1.text) == null &&
                    _validateInput(_num2.text) == null &&
                    _validateInput(_num3.text) == null &&
                    _validateInput(_nationality.text) == null &&
                    _validateInput(_birth.text) == null &&
                    _validateInput(_status.text) == null &&
                    _validateInput(_sex.text) == null &&
                    _validateInput(_educational.text) == null &&
                    _validateInput(_project.text) == null &&
                    _validateInput(_school.text) == null &&
                    _validateInput(_email.text) == null &&
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
                        school: _school.text,
                        email: _email.text,
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
      borderSide:
          BorderSide(color: const Color.fromARGB(255, 6, 42, 72), width: 2),
    );
  }
}
