import 'package:flutter/material.dart';
import 'Shopping.dart'; // Import the formShopping.dart file

class MyFORM extends StatefulWidget {
  const MyFORM({Key? key}) : super(key: key);

  @override
  State<MyFORM> createState() => _MyFORMState();
}

class _MyFORMState extends State<MyFORM> {
  var _productName;
  var _customerName;
  var _productPrice;
  var _numberofproduct;

  final _productController = TextEditingController();
  final _customerController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _numberofproductController = TextEditingController();

  void initState() {
    super.initState();
    _productController.addListener(_updateText);
    _customerController.addListener(_updateText2);
    _productPriceController.addListener(_updateText3);
    _numberofproductController.addListener(_updateText4); // Corrected reference
  }

  void _updateText() {
    setState(() {
      _productName = _productController.text;
    });
  }

  void _updateText2() {
    setState(() {
      _customerName = _customerController.text;
    });
  }

  void _updateText3() {
    setState(() {
      _productPrice = _productPriceController.text;
    });
  }

  void _updateText4() {
    setState(() {
      _numberofproduct = _numberofproductController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Name'), // Use _productName
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _productController,
              decoration: InputDecoration(
                labelText: 'Product Name',
                icon: Icon(Icons.verified_user_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _customerController,
              decoration: InputDecoration(
                labelText: 'Customer Name',
                icon: Icon(Icons.verified_user_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _productPriceController,
              decoration: InputDecoration(
                labelText: 'Product Price',
                icon: Icon(Icons.verified_user_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _numberofproductController,
              decoration: InputDecoration(
                labelText: 'Number of Product',
                icon: Icon(Icons.verified_user_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            myBTN(context),
            SizedBox(height: 10),
            Text(
              "Product Name is : ${_productController.text}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Customer Name is : ${_customerController.text}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Product Price : ${_productPriceController.text}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Number of Product : ${_numberofproductController.text}",
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
            const Text('Go to Shopping', style: TextStyle(fontSize: 20, color: Colors.black)),
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
                  customerName: _customerController.text,
                  prodcutprice: _productPriceController.text,
                  numberofproduct: _numberofproductController.text,
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
