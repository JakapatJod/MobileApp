import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart'; // Import เพิ่มเติม

class Page1 extends StatefulWidget {
  const Page1({Key? key}); // แก้ไข key เป็น Key?

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Firestore Example',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('careeData').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    title: Text(data['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Job: ${data['job']}'),
                        Text('Salary: ${data['salary']}'),
                      ],
                    ),
                    leading: const Icon(Icons.person),
                    trailing: !data['admin']
                        ? SizedBox(
                            width: 100,
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    doEdit(document, data);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    doDel(document.id);
                                  },
                                ),
                              ],
                            ),
                          )
                        : null,
                    tileColor: Colors.amberAccent,
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          doAdd();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void doAdd() async {
    TextEditingController nameController = TextEditingController();
    TextEditingController jobController = TextEditingController();
    TextEditingController salaryController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: const Text('Add User'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: jobController,
                  decoration: const InputDecoration(labelText: 'Job'),
                ),
                TextField(
                  controller: salaryController,
                  decoration: const InputDecoration(labelText: 'Salary'),
                  keyboardType: TextInputType.number, // เพิ่ม keyboardType
                  inputFormatters: <TextInputFormatter>[
                    // เพิ่ม inputFormatters
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Save'),
                onPressed: () {
                  final FirebaseFirestore firestore =
                      FirebaseFirestore.instance;
                  final CollectionReference mainCollection =
                      firestore.collection('careeData');
                  mainCollection.add({
                    'name': nameController.text,
                    'job': jobController.text,
                    'salary': int.parse(
                        salaryController.text), // แปลงข้อมูลเป็น integer
                    'admin': false,
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void doEdit(DocumentSnapshot document, Map<String, dynamic> data) {
    TextEditingController nameController = TextEditingController();
    TextEditingController jobController = TextEditingController();
    TextEditingController salaryController = TextEditingController();

    nameController.text = data['name'];
    jobController.text = data['job'];

    int initialSalary = data['salary'] ?? 0; // แปลงให้รับเฉพาะค่าจำนวนเต็ม
    salaryController.text = initialSalary.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: const Text('Edit User'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: jobController,
                  decoration: const InputDecoration(labelText: 'Job'),
                ),
                TextField(
                  controller: salaryController,
                  decoration: const InputDecoration(labelText: 'Salary'),
                  keyboardType: TextInputType.number, // เพิ่ม keyboardType
                  inputFormatters: <TextInputFormatter>[
                    // เพิ่ม inputFormatters
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Save'),
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Save Data'),
                        content: const Text('Are you sure?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            child: const Text('Save'),
                            onPressed: () async {
                              Navigator.pop(context);
                              final FirebaseFirestore firestore =
                                  FirebaseFirestore.instance;
                              final CollectionReference mainCollection =
                                  firestore.collection('careeData');

                              await mainCollection.doc(document.id).update({
                                'name': nameController.text,
                                'job': jobController.text,
                                'salary': int.parse(salaryController
                                    .text), // แปลงข้อมูลเป็น integer
                              });
                            },
                          )
                        ],
                      );
                    },
                  ).then((value) => Navigator.pop(context));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void doDel(String id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete Data'),
            content: const Text('Are your sure?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                child: const Text('Delete'),
                onPressed: () async {
                  Navigator.pop(context);
                  final FirebaseFirestore firestore =
                      FirebaseFirestore.instance;
                  final CollectionReference mainCollection =
                      firestore.collection('careeData');
                  await mainCollection.doc(id).delete();
                },
              )
            ],
          );
        });
  }
}
