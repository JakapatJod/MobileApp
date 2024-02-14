import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'sql_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SQLite CRUD',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        appBarTheme: AppBarTheme(color: Colors.blueAccent),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> journals = [];
  bool isLoading = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String _gender = 'Male';
  DateTime? _selectedDate;
  File? _image;

  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      journals = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals();
  }

  void _showForm(int? id) async {
    final existingJournal = id != null
        ? journals.firstWhere((element) => element['id'] == id)
        : null;

    _nameController.text = existingJournal?['name'] ?? '';
    _ageController.text = existingJournal?['age'].toString() ?? '';
    _weightController.text = existingJournal?['weight'].toString() ?? '';
    _heightController.text = existingJournal?['height'].toString() ?? '';
    _selectedDate = existingJournal != null ? DateTime.parse(existingJournal['birthdate']) : null;
    _image = existingJournal?['image'] != null
        ? File(existingJournal?['image'])
        : null;

    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 180,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(hintText: 'Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Age'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Height (cm)'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Weight (kg)'),
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  Text('Gender: '),
                  DropdownButton<String>(
                    value: _gender,
                    onChanged: (String? value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                    items: <String>['Male', 'Female']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text('Birthdate: '),
                  TextButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: _selectedDate ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      ).then((selectedDate) {
                        setState(() {
                          _selectedDate = selectedDate;
                        });
                      });
                    },
                    child: Text(
                      _selectedDate != null
                          ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                          : 'Choose Date',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text('Image: '),
                  ElevatedButton(
                    onPressed: () async {
                      final picker = ImagePicker();
                      final pickedFile = await picker.pickImage(
                        source: ImageSource.gallery, 
                      );
                      if (pickedFile != null) {
                        setState(() {
                          _image = File(pickedFile.path);
                        });
                      }
                    },
                    child: Text('Pick Image'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_nameController.text.isNotEmpty &&
                      _ageController.text.isNotEmpty &&
                      _weightController.text.isNotEmpty &&
                      _heightController.text.isNotEmpty &&
                      _selectedDate != null) {
                    double weight = double.parse(_weightController.text);
                    double height = double.parse(_heightController.text);
                    double bmi = _calculateBMI(weight, height);

                    if (id == null) {
                      await _addItem(weight, height, bmi);
                    }

                    if (id != null) {
                      await _updateItem(
                          id, weight, height, bmi, _selectedDate!);
                    }

                    _nameController.text = '';
                    _ageController.text = '';
                    _weightController.text = '';
                    _heightController.text = '';

                    setState(() {
                      _selectedDate = null;
                      _image = null; // Clear selected image
                    });

                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Please enter valid values for all fields.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Text(id == null ? 'Create New' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addItem(double weight, double height, double bmi) async {
    await SQLHelper.createItem(
      _nameController.text,
      _ageController.text,
      weight,
      height,
      bmi,
      _gender,
      _selectedDate!.toString(),
      _image != null ? _image!.path : null, 
    );

    _refreshJournals();
  }

  Future<void> _updateItem(int id, double weight, double height, double bmi,
      DateTime birthdate) async {
    await SQLHelper.updateItem(
      id,
      _nameController.text,
      _ageController.text,
      weight,
      height,
      bmi,
      _gender,
      birthdate.toString(),
      _image != null ? _image!.path : null, 
    );

    _refreshJournals();
  }

  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully deleted a journal!'),
      ),
    );
    _refreshJournals();
  }

  double _calculateBMI(double weight, double height) {
    return weight / ((height / 100) * (height / 100));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite CRUD'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: journals.length,
              itemBuilder: (context, index) => Card(
                color: Color.fromARGB(255, 12, 26, 31),
                margin: const EdgeInsets.all(15),
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${journals[index]['title'] ?? 'N/A'}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 16)),
                      Text('Age: ${journals[index]['description'] ?? 'N/A'}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 16)),
                      Text('Height: ${journals[index]['height']}',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 16, ),),
                      Text('Weight: ${journals[index]['weight']}',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 16, ),),
                      Text('BMI: ${journals[index]['bmi'].toStringAsFixed(2)}',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 16, ),),
                      Text('Gender: ${journals[index]['gender']}',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 16, ),),
                      Text('Birthdate: ${journals[index]['birthdate']}'),
                      if (journals[index]['image'] != null)
                        Image.file(File(journals[index]['image'])),
                    ],
                  ),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showForm(journals[index]['id']),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteItem(journals[index]['id']),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 22, 151, 231),
        onPressed: () => _showForm(null),
      ),
    );
  }
}
