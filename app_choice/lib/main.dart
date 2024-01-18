import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'List'),
    );
  }
}

class Data {
  late int id;
  late String name;
  late DateTime t;

  Data(this.id, this.name, this.t);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String txt = 'N/A';
  List<Data> mylist = <Data>[];
  int img = 0;
  var list = ['one', 'two', 'three', 'four'];

  ImageProvider getSelectedImage(int selectedId) {
    switch (selectedId) {
      case 1:
        return AssetImage('assets/images/ig.png');
      case 2:
        return AssetImage('assets/images/line.png');
      case 3:
        return AssetImage('assets/images/avenger.png');
      case 4:
        return AssetImage('assets/images/marvel.jpeg');
      default:
        return AssetImage('assets/images/rocket.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: img,
                  onChanged: (int? value) {
                    setState(() {
                      img = 1;
                    });
                  },
                ),
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/ig.png'),
                ),

                // --------------------------------

                Radio(
                  value: 2,
                  groupValue: img,
                  onChanged: (int? value) {
                    setState(() {
                      img = 2;
                    });
                  },
                ),
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/line.png'),
                ),

                // --------------------------------

                Radio(
                  value: 3,
                  groupValue: img,
                  onChanged: (int? value) {
                    setState(() {
                      img = 3;
                    });
                  },
                ),
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/avenger.png'),
                ),

                // --------------------------------

                Radio(
                  value: 4,
                  groupValue: img,
                  onChanged: (int? value) {
                    setState(() {
                      img = 4;
                    });
                  },
                ),
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/marvel.jpeg'),
                ),

                // --------------------------------
              ],
            ),
            TextField(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  txt = 'Add item Success';
                  mylist.add(Data(img, '1', DateTime.now()));
                });
              },
              child: const Text('Add Item'),
            ),
            Text(
              txt,
              textScaleFactor: 2,
            ),
            SizedBox(
              width: double.infinity,
              height: 550,
              child: ListView.builder(
                itemCount: mylist.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: Colors.primaries[index % Colors.primaries.length],
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: getSelectedImage(mylist[index].id),
                        ),
                        title: Text('Title Text (${mylist[index].id})'),
                        subtitle: Text(mylist[index].t.toString()),
                        trailing: const Icon(Icons.delete_rounded),
                        onTap: () {
                          setState(() {
                            txt = 'Title Text ($index) is removed';
                            mylist.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
