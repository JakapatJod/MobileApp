import 'package:flutter/material.dart';

class foodMenu {
  final String name;
  final String price;
  final String img;

  foodMenu(this.name, this.price, this.img);
}

class ShoppingCart {
  List<foodMenu> items = [];
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
  List<foodMenu> menu = [
    foodMenu("กุ้งเผา", "200", "assets/images/image1.jpg"),
    foodMenu("กระเพราหมู", "60", "assets/images/image2.jpg"),
    foodMenu("ทะเลเผา", "199", "assets/images/image3.jpg"),
    foodMenu("ปูนึ่ง", "200", "assets/images/image4.jpg"),
    foodMenu("ข้าวผัด", "60", "assets/images/image5.jpg"),
    foodMenu("แฮมเบอร์เกอร์", "50", "assets/images/image6.jpg"),
    foodMenu("ซูชิ", "70", "assets/images/image7.jpg"),
    foodMenu("ข้าวยำไก่แซ่บ", "65", "assets/images/image8.jpg"),
    foodMenu("ปูผัดผงกะหรี่", "70", "assets/images/image9.jpg"),
    foodMenu("แกงเขียวหวาน", "65", "assets/images/image10.jpg"),
    foodMenu("ผัดไท", "80", "assets/images/image11.jpg"),
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
          TextButton(
            onPressed: () {
              _navigateToCart();
            },
            child: Text(
              'ดูตะกร้า',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: menu.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Image.asset(
              menu[index].img,
              width: 200,
              fit: BoxFit.cover,
            ),
            title: Text(
              menu[index].name,
              style:
              TextStyle(fontSize: 18, color: Color.fromARGB(255, 0, 0, 0)),
            ),
            subtitle: Text(
              'Price: ${menu[index].price} Baht',
              style: TextStyle(
                  fontSize: 14, color: const Color.fromARGB(255, 0, 0, 0)),
            ),
            onTap: () {
              _showDialog(menu[index]);
            },
          );
        },
      ),
    );
  }

  void _showDialog(foodMenu selectedMenu) {
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

  void _addItemToCart(foodMenu selectedMenu) {
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

  double _calculateTax(int totalSelected) { // ภาษี
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
          final foodMenu item = widget.shoppingCart.items[index];

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

  void _removeItem(foodMenu item) {
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
