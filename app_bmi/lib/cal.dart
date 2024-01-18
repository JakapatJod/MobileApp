import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormMatch(gender: '?', age: '0', width: '0', height: '0'),
    );
  }
}

class FormMatch extends StatelessWidget {
  final String width;
  final String height;
  final String age;
  final String gender;

  const FormMatch({
    Key? key,
    required this.width,
    required this.height,
    required this.age,
    required this.gender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double parsedWidth = double.tryParse(width) ?? 0.0;
    double parsedHeight = double.tryParse(height) ?? 0.0;
    double parsedAge = double.tryParse(age) ?? 0.0;

    double bmi = calculateBMI(parsedWidth, parsedHeight);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Calculate BMI App', style: TextStyle(fontSize: 25, color: Colors.white)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            myBtn(context),
            ListTile(
              leading: Icon(Icons.account_balance_wallet_outlined),
              title: Text(
                determineLabel(bmi),
                style: TextStyle(fontSize: 20),
              ),
            ),
            if (isUnderweight())
              Image.asset('assets/images/bmi-1.png', height: 250, width: 150),
            if (isNomalweight())
              Image.asset('assets/images/bmi-2.png', height: 250, width: 150),
            if (Risktooverweight())
              Image.asset('assets/images/bmi-3.png', height: 250, width: 150),
            if (overweight())
              Image.asset('assets/images/bmi-4.png', height: 250, width: 150),
            if (obesity())
              Image.asset('assets/images/bmi-5.png', height: 250, width: 150),
          ],
        ),
      ),
    );
  }

  Center myBtn(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Go back!', style: TextStyle(fontSize: 25)),
      ),
    );
  }

  String determineLabel(double bmi) {
    double parsedWidth = double.tryParse(width) ?? 0.0;
    double parsedHeight = double.tryParse(height) ?? 0.0;
    double parsedAge = double.tryParse(age) ?? 0.0;

    double bmr = calculateBMR(gender, parsedAge, parsedWidth, parsedHeight);
    String weightChangeInfo = determineWeightChange(bmi);
    return 'BMI : ${bmi.toStringAsFixed(2)} \nBMR: ${bmr.toStringAsFixed(2)} \nGender : ${gender} \n$weightChangeInfo';
  }

  String determineWeightChange(double bmi) {
    if (bmi < 18.5) {
      return 'น้ำหนักที่ต้องเพิ่ม ${(18.5 - bmi).toStringAsFixed(2)} kg';
    } else if (bmi >= 18.5 && bmi <= 22.9) {
      return 'อยู่ในสัดส่วนน้ำหนักที่พอดี';
    } else {
      return 'น้ำหนักที่ต้องลด ${(bmi - 22.9).toStringAsFixed(2)} kg';
    }
  }

  bool isUnderweight() {
    double parsedWidth = double.tryParse(width) ?? 0.0;
    double parsedHeight = double.tryParse(height) ?? 0.0;
    double bmiValue = calculateBMI(parsedWidth, parsedHeight);
    return bmiValue < 18.5;
  }

  bool isNomalweight() {
    double parsedWidth = double.tryParse(width) ?? 0.0;
    double parsedHeight = double.tryParse(height) ?? 0.0;
    double bmiValue = calculateBMI(parsedWidth, parsedHeight);
    return bmiValue >= 18.5 && bmiValue <= 22.5;
  }

  bool Risktooverweight() {
    double parsedWidth = double.tryParse(width) ?? 0.0;
    double parsedHeight = double.tryParse(height) ?? 0.0;
    double bmiValue = calculateBMI(parsedWidth, parsedHeight);
    return bmiValue >= 23 && bmiValue <= 24.9;
  }

  bool overweight() {
    double parsedWidth = double.tryParse(width) ?? 0.0;
    double parsedHeight = double.tryParse(height) ?? 0.0;
    double bmiValue = calculateBMI(parsedWidth, parsedHeight);
    return bmiValue >= 25 && bmiValue <= 29.9;
  }

  bool obesity() {
    double parsedWidth = double.tryParse(width) ?? 0.0;
    double parsedHeight = double.tryParse(height) ?? 0.0;
    double bmiValue = calculateBMI(parsedWidth, parsedHeight);
    return bmiValue > 30;
  }

  double calculateBMI(double weight, double height) {
    double heightInMeters = height / 100.0;
    double BMI_CAL = weight / (heightInMeters * heightInMeters);
    return BMI_CAL;
  }

  double calculateBMR(String gender, double age, double weight, double height) {
    double heightInMeters = height / 100.0;

    if (gender == 'male') {
      return 66 + (13.7 * weight) + (5 * heightInMeters) - (6.8 * age);
    } else if (gender == 'female') {
      return 665 + (9.6 * weight) + (1.8 * heightInMeters) - (4.7 * age);
    } else {
      return 0;
    }
  }
}
