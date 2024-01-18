import 'package:flutter/material.dart';

class formShopping extends StatelessWidget {
  final String productName;
  final String customerName;
  final String prodcutprice;
  final String numberofproduct;

  const formShopping({Key? key, 
  required this.productName ,
  required this.customerName  ,
  required this.prodcutprice  ,
  required this.numberofproduct }) : super(key: key);
  
  double calculateTotalPrice() {
    double price = double.parse(prodcutprice);
    int quantity = int.parse(numberofproduct);

    return price * quantity;
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = calculateTotalPrice();

    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
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
              title: Text('Product Name : ${productName}\n Customer Name : ${customerName}\n Total Price : ${totalPrice}',
              style: TextStyle(fontSize: 15),),

            ),
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
        child: const Text('Go back!'),
      ),
    );
  }
}
