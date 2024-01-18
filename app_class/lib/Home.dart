import 'package:flutter/material.dart';
import 'Shopping.dart'; // Import the formShopping.dart file
import 'package:app_homework_match/my_radio_button.dart';
import 'dart:ui';

// enum ProductTypeEnum { Downloadable, Deliverable}

class MyFORM extends StatefulWidget {
  const MyFORM({Key? key}) : super(key: key);

  @override
  State<MyFORM> createState() => _MyFORMState();
}

class _MyFORMState extends State<MyFORM> {
  var _productName;
  var _productDes;

  final _productController = TextEditingController();
  final _productDesController = TextEditingController();

  var _selectedChoice;

  bool? _checkBox, _listTileCheckBox = false;

  ProductTypeEnum? _productTypeEnum;

  void initState() {
    super.initState();
    _productController.addListener(_updateText);
    _productDesController.addListener(_updateText2);
  }

  void _updateText() {
    setState(() {
      _productName = _productController.text;
    });
  }

  void _updateText2() {
    setState(() {
      _productDes = _productDesController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Name'), 
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text(
              'PRODUCT APP',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 10),

            const Text('Add Product detail in the form'),

            SizedBox(height: 10),
            MyTextField(
              fieldname: 'Product Name',
              myController: _productController,
              myIcon: Icons.pin_drop_sharp,
              prefixIconColor: Colors.deepOrange.shade300,
            ),
            SizedBox(height: 10),
            MyTextField(
              fieldname: 'Product Description',
              myController: _productDesController,
              myIcon: Icons.pin_drop_sharp,
              prefixIconColor: Colors.deepOrange.shade300,
            ),
            SizedBox(height: 20),


            // Checkbox(
            //   checkColor: Colors.white,
            //   activeColor: Colors.deepOrange,
            //   tristate: true,
            //   value: _checkBox,
            //   onChanged: (val) {
            //     setState(() {
            //       _checkBox = val;
            //     });
            //   },
            // ),

            CheckboxListTile(
              value: _listTileCheckBox,
              title: Text("Top Product"),
              onChanged: (val) {
                setState(() {
                  _listTileCheckBox = val;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),

            // Radio(value: null, groupValue: null , onChanged: null),
            // RadioListTile(value: null, groupValue: null, onChanged: null),
            // SizedBox(height: 10),

            // ListTile(
            //   title: Text('1'),
            //   leading: Radio(
            //     value: 1,groupValue: _selectedChoice,
            //     onChanged: (value) {
            //       setState(() {
            //         _selectedChoice = 1 ;
            //       });
            //     },
            //   ),
            // ),


            // ListTile(
            //   title: Text('2'),
            //   leading: Radio(
            //     value: 2,groupValue: _selectedChoice,
            //     onChanged: (value) {
            //       setState(() {
            //         _selectedChoice = 2 ;
            //       });
            //     },
            //   ),
            // ),

            // ListTile(
            //   title: Text('3'),
            //   leading: Radio(
            //     value: 3,groupValue: _selectedChoice,
            //     onChanged: (value) {
            //       setState(() {
            //         _selectedChoice = 3 ;
            //       });
            //     },
            //   ),
            // ),


            MyRadioButton(
              title: ProductTypeEnum.Downloadable.name,
              value: ProductTypeEnum.Downloadable,
              selectedProductType: _productTypeEnum,
              onChanged: (val) {
                setState(() {
                  _productTypeEnum = val ;
                });
              },
            ),
            SizedBox(width: 5),
            MyRadioButton(
              title: ProductTypeEnum.Deliverable.name,
              value: ProductTypeEnum.Deliverable,
              selectedProductType: _productTypeEnum,
              onChanged: (val) {
                setState(() {
                  _productTypeEnum = val ;
                });
              },
            ),



            SizedBox(height: 10),
            myBTN(context),
            SizedBox(height: 10),
            Text(
              "Product Name is : ${_productController.text}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Customer Name is : ${_productDesController.text}",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Center myBTN(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Go to Shopping',
                style: TextStyle(fontSize: 20, color: Colors.black)),
            Icon(Icons.add_shopping_cart_outlined),
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return formShopping(
                  productName: _productController.text,
                  productDes: _productDesController.text,
                );
              },
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          fixedSize: Size(300, 80),
          backgroundColor: Colors.lightBlue,
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.fieldname,
    required this.myController,
    this.myIcon = Icons.verified_user_outlined,
    this.prefixIconColor = Colors.blueAccent,
  }) : super(key: key);

  final TextEditingController myController;
  final String fieldname;
  final IconData myIcon;
  final Color prefixIconColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      decoration: InputDecoration(
        labelText: fieldname,
        prefixIcon: Icon(
          myIcon,
          color: prefixIconColor,
        ),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrange.shade200),
        ),
        labelStyle: const TextStyle(color: Colors.deepOrange),
      ),
    );
  }
}
