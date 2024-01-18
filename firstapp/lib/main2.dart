import 'package:flutter/material.dart';
import 'foodMenu.dart';

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
  int selectedDishes = 0;
  int food_summary = 0;

  // list ข้อมูล
  List<foodMenu> menu = [
    foodMenu("ข้าวไข่เจียว", 40, "assets/images/food_1.jpg"),
    foodMenu("ข้าวผัด", 50, "assets/images/food_2.webp"),
    foodMenu("สุกี้", 50, "assets/images/food_3.jpg"),
    foodMenu("ข้าวกระเพราหมูสับ", 55, "assets/images/food_4.jpg"),
    foodMenu("ข้าวผัดทะเล", 65, "assets/images/food_5.jpg"),
    foodMenu("ข้าวหมูทอดกระเทียม", 70, "assets/images/food_6.jpg"),
    foodMenu("ข้าวไก่ทอด", 45, "assets/images/food_7.jpg"),
    foodMenu("ข้าวไข่ข้นลาวา", 60, "assets/images/food_8.jpg"),
    foodMenu("ข้าวคลุกกะปิ", 55, "assets/images/food_9.webp"),
    foodMenu("ข้าวผัดผงกะหรี่ปลาหมึก", 70, "assets/images/food_10.jpg"),
    foodMenu("ราดหน้า", 50, "assets/images/food_11.webp"),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          " เลือกเมนูอาหาร ",
          style: TextStyle(fontSize: 40, color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 6, 52, 239),
      ),
      body: ListView.builder(
        itemCount: menu.length,
        itemBuilder: (BuildContext context, int index) {
          foodMenu food = menu[index];
          return Card(
            child: ListTile(
              leading: Image.asset(
                food.img,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text("เมนู ${index + 1}",style: TextStyle(fontSize: 30),),
              subtitle: Text("${food.name} ราคา ${food.price} บาท"),
              onTap: () {
                setState(() {
                  selectedDishes+=1;
                  food_summary += food.price;
                });
                AlertDialog alert = AlertDialog(
                  title: Text("คุณสั่งอาหารทั้งหมด $selectedDishes จาน  \n ราคารวมทั้งหมด ${food_summary} บาท"),

                  
                );
                showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
