import 'package:flutter/material.dart';
import 'database_helper.dart';

class Brand {
  final int? id;
  final String name;
  final String price;
  final String imageUrl;
  Brand(this.name, this.price, this.imageUrl, {this.id});
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Brand> brands = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getBrands();
  }

  Future<void> _getBrands() async {
    List<Brand> brandList = [];
    final brands = await DatabaseHelper.getBrands();
    for (var brand in brands) {
      brandList.add(Brand(
        brand['name'],
        brand['price'],
        brand['imageUrl'],
        id: brand['id'],
      ));
    }
    setState(() {
      this.brands = brandList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Final-SQFlite',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[700],
        leading: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _addShoe(context);
          },
          color: Colors.white,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
            color: Colors.white,
          ),
        ],
      ),
      body: brands.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: brands.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Image.network(
                    brands[index].imageUrl,
                    fit: BoxFit.cover,
                    width: 80,
                  ),
                  title: Text(brands[index].name),
                  subtitle: Text(brands[index].price),
                  onTap: () {},
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {},
                    ),
                  ]),
                );
              },
            ),
    );
  }

  void _addShoe(BuildContext context) {
    nameController.clear();
    priceController.clear();
    urlController.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Shoe'),
          content: SingleChildScrollView(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    controller: nameController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Price'),
                    controller: priceController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Image URL'),
                    controller: urlController,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _insertShoe();
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _insertShoe() async {
    final name = nameController.text;
    final price = priceController.text;
    final imageUrl = urlController.text;
    await DatabaseHelper.insertBrand(name, price, imageUrl);
    _getBrands();
  }
}
