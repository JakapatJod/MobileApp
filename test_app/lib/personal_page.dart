import 'package:flutter/material.dart';

class PersonalPage extends StatelessWidget {
  String name, sex, birth, nationality, religion, status, educational, gpa, project, num1, num2, num3;

  PersonalPage({
    Key? key,
    required this.name,
    required this.sex,
    required this.birth,
    required this.nationality,
    required this.religion,
    required this.status,
    required this.educational,
    required this.gpa,
    required this.project,
    required this.num1,
    required this.num2,
    required this.num3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
                if (sex == 'Male') ...{
                  Center(
                    child: Image.asset('assets/images/man.png', height: 250, width: 150),
                  ),
                } else if (sex == 'Female') ...{
                  Center(
                    child: Image.asset('assets/images/female.png', height: 250, width: 150),
                  ),
                },
                
                Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(10),
                  color: Colors.blue,
                  child: ListTile(
                    title: Text('Information Personal',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,)),
                    subtitle: Text(
                      ' \tName : ${name} \n \tDate of birth : ${birth} \n \tSex : ${sex} \n \tNationality : ${nationality} \n \tRegion : ${religion} \n \tGPA : ${gpa} \n \tEducation : ${educational}',
                      style: TextStyle(
                        color: Colors.white, // สีของตัวอักษร
                        fontSize: 16.0, // ขนาดฟอนต์ // น้ำหนักของฟอนต์ (bold)
                        fontFamily: 'YourFontFamily', // ชื่อของฟอนต์ที่ใช้
                      ),
                    ),
                  ),
                ),

                Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(10),
                  color: Colors.blue,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('โครงการที่สมัคร',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,)),
                        subtitle: Text(' โควตาที่สมัคร : ${project} \n ลำดับที่ 1 : ${num1} \n ลำดับที่ 2 : ${num2} \n ลำดับที่ 3 : ${num3} ',
                        style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0, 
                        fontFamily: 'YourFontFamily',
                      ),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

