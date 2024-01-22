import 'package:flutter/material.dart';
import 'calculate_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget{

  @override
  _HomeState createState() => _HomeState();
}



class _HomeState extends State<Home> {

  TextEditingController _product = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _installment = TextEditingController();

  @override
  void initState() {
    _product.text = ""; 
    _price.text = "";
    _installment.text = "";
    super.initState();
  }
  

  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar( 
             title: Text("Fast_Shop"),
             backgroundColor: Colors.orange,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Image.asset(
                "assets/images/logo.png",
                height: 150,
                ),

                Container(height:10),

                TextField( 
                  controller: _product,
                  decoration: InputDecoration( 
                      labelText: "Notebook, Tablet, PC",
                      prefixIcon: Icon(Icons.shop),
                      border: myinputborder(),
                      enabledBorder: myinputborder(),
                      focusedBorder: myfocusborder(),
                  )
                ),

                Container(height:10),

                TextField( 
                  controller: _price,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration( 
                      labelText: "ราคา",
                      prefixIcon: Icon(Icons.money_off),
                      border: myinputborder(),
                      enabledBorder: myinputborder(),
                      focusedBorder: myfocusborder(),
                  )
                ),        

                Container(height:20),

                TextField( 
                  controller: _installment,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration( 
                      labelText: "จำนวนงวด 6 , 10 , 24",
                      prefixIcon: Icon(Icons.calculate),
                      border: myinputborder(),
                      enabledBorder: myinputborder(),
                      focusedBorder: myfocusborder(),
                  )
                ),

                Container(height:20),

                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Calculator(
                          product: _product.text, 
                          price: _price.text, 
                          installment: _installment.text,))
                    );
                  },
                  style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  textStyle: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold)
                ),
                    child: Text(
                      'Calculator',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ) ,
                      ))
              ],
            ),
          )
       );
  }

  OutlineInputBorder myinputborder(){ 
    return OutlineInputBorder( 
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
          color:Colors.grey,
          width: 3,
        )
    );
  }

  OutlineInputBorder myfocusborder(){
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
          color:Colors.redAccent,
          width: 3,
        )
    );
  }
}