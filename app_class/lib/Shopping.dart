import 'package:flutter/material.dart';

class formShopping extends StatelessWidget {
  final String productName;
  final String productDes;


  const formShopping({Key? key, 
  required this.productName ,
  required this.productDes  ,
 }) : super(key: key);
  


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Screen'),
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
              title: Text(productName,
              style: TextStyle(fontSize: 15),),
              subtitle: Text(productDes),

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
