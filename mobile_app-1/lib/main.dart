import 'package:flutter/material.dart';

class FoodMenu {
  final String name;
  final String price;
  final String img;

  FoodMenu(this.name, this.price, this.img);
}

class ShoppingCart {
  List<FoodMenu> items = [];
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<FoodMenu> menu = [
    FoodMenu("กุ้งเผา", "200", "assets/images/image1.jpg"),
    FoodMenu("กระเพราหมู", "60", "assets/images/image2.jpg"),
    FoodMenu("ทะเลเผา", "199", "assets/images/image3.jpg"),
    FoodMenu("ปูนึ่ง", "200", "assets/images/image4.jpg"),
    FoodMenu("ข้าวผัด", "60", "assets/images/image5.jpg"),
    FoodMenu("แฮมเบอร์เกอร์", "50", "assets/images/image6.jpg"),
    FoodMenu("ซูชิ", "70", "assets/images/image7.jpg"),
    FoodMenu("ข้าวยำไก่แซ่บ", "65", "assets/images/image8.jpg"),
    FoodMenu("ปูผัดผงกะหรี่", "70", "assets/images/image9.jpg"),
    FoodMenu("แกงเขียวหวาน", "65", "assets/images/image10.jpg"),
    FoodMenu("ผัดไท", "80", "assets/images/image11.jpg"),
  ];

  ShoppingCart shoppingCart = ShoppingCart();
  int totalSelected = 0;
  double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FOOD ORDERING APP',
          style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 133, 123, 123)),
        ),
        backgroundColor: const Color.fromARGB(255, 243, 33, 33),
        actions: [
          IconButton(
            onPressed: () {
              _navigateToCart();
            },
            icon: Icon(Icons.shopping_cart, color: Colors.white),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: menu.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 2.0,
            margin: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                _showDialog(menu[index]);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    menu[index].img,
                    width: double.infinity,
                    height: 150.0,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          menu[index].name,
                          style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Text(
                          'Price: ${menu[index].price} Baht',
                          style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDialog(FoodMenu selectedMenu) {
    int totalSelected = _getTotalSelected() + 1;
    double totalPrice = _getTotalPrice() + double.parse(selectedMenu.price);
    double taxRate = _calculateTax(totalSelected);
    double tax = totalPrice * taxRate;
    double totalWithTax = totalPrice + tax;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("คุณเลือกเมนู: ${selectedMenu.name}"),
          content: Container(
            height: 150,
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("จำนวนที่เลือก: $totalSelected"),
                Text("ราคารวม: $totalPrice Baht"),
                Text("ภาษี:  ${tax.toStringAsFixed(2)}  Baht"),
                Text("ราคารวมทั้งสิ้น: $totalWithTax Baht"),
              ],
            ),
          ),
          actions: [
            TextButton.icon(
              icon: Icon(Icons.remove),
              label: Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.add),
              label: Text('เพิ่มลงตะกร้า'),
              onPressed: () {
                _addItemToCart(selectedMenu);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addItemToCart(FoodMenu selectedMenu) {
    setState(() {
      shoppingCart.items.add(selectedMenu);
      totalSelected++;
      totalPrice += double.parse(selectedMenu.price);
    });
  }

  void _navigateToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShoppingCartScreen(shoppingCart: shoppingCart),
      ),
    );
  }

  int _getTotalSelected() {
    return shoppingCart.items.length;
  }

  double _getTotalPrice() {
    double totalPrice = 0;
    for (var item in shoppingCart.items) {
      totalPrice += double.parse(item.price);
    }
    return totalPrice;
  }

  double _calculateTax(int totalSelected) {
    if (totalSelected > 10) {
      return 0.10; // 10% tax
    } else if (totalSelected > 7) {
      return 0.06; // 6% tax
    } else {
      return 0.0; // 0% tax
    }
  }
}

class ShoppingCartScreen extends StatefulWidget {
  final ShoppingCart shoppingCart;

  const ShoppingCartScreen({Key? key, required this.shoppingCart}) : super(key: key);

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: ListView.builder(
        itemCount: widget.shoppingCart.items.length,
        itemBuilder: (BuildContext context, int index) {
          final FoodMenu item = widget.shoppingCart.items[index];

          return ListTile(
            title: Text(item.name),
            subtitle: Text('Price: ${item.price} Baht'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _removeItem(item);
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Total Price: ${_calculateTotalPrice()} Baht',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

  void _removeItem(FoodMenu item) {
    setState(() {
      widget.shoppingCart.items.remove(item);
    });
  }

  double _calculateTotalPrice() {
    double total = 0;
    for (var item in widget.shoppingCart.items) {
      total += double.parse(item.price);
    }
    return total;
  }
}
  