import 'package:flutter/material.dart';
import 'sql_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite CRUD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
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
  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;

  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals();
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  Future<double> _calculateBMIForItem(Map<String, dynamic> item) async {
    double height = item['height'] is double
        ? item['height']
        : double.tryParse(item['height'].toString()) ?? 0.0;
    double weight = item['weight'] is double
        ? item['weight']
        : double.tryParse(item['weight'].toString()) ?? 0.0;

    double heightInMeters = height / 100.0; // Convert height to meters

    double bmi = weight / (heightInMeters * heightInMeters);
    print('BMI: $bmi');
    return bmi;
  }

  void _showForm(int? id) async {
    if (id != null) {
      final existingJournal =
          _journals.firstWhere((element) => element['id'] == id);
      _titleController.text = existingJournal['title'];
      _descriptionController.text = existingJournal['description'];
      _heightController.text = existingJournal['height'].toString();
      _weightController.text = existingJournal['weight'].toString();
    }
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
            bottom: MediaQuery.of(context).viewInsets.bottom + 120,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(hintText: 'Title'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(hintText: 'Description'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(hintText: 'Height (meters)'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(hintText: 'Weight (kg)'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (id == null) {
                    await _addItem();
                  }
                  if (id != null) {
                    await _updateItem(id);
                  }

                  // Calculate BMI after adding/updating an item
                  _refreshJournals();

                  // Clear the text fields
                  _titleController.text = '';
                  _descriptionController.text = '';
                  _heightController.text = '';
                  _weightController.text = '';

                  // Close the bottom sheet
                  Navigator.of(context).pop();
                },
                child: Text(id == null ? 'Create New' : 'Update'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addItem() async {
    // Calculate BMI before adding the item
    double bmi = await _calculateBMI();

    await SQLHelper.createItem(
        _titleController.text,
        _descriptionController.text,
        double.tryParse(_heightController.text),
        double.tryParse(_weightController.text),
        bmi); // Pass BMI to createItem
    _refreshJournals();
  }

  Future<void> _updateItem(int id) async {
    // Calculate BMI before updating the item
    double bmi = await _calculateBMI();

    await SQLHelper.updateItem(
        id,
        _titleController.text,
        _descriptionController.text,
        double.tryParse(_heightController.text),
        double.tryParse(_weightController.text),
        bmi); // Pass BMI to updateItem
    _refreshJournals();
  }

  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a journal!'),
    ));
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite CRUD'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _journals.length,
              itemBuilder: (context, index) => Card(
                color: Colors.orange[200],
                margin: const EdgeInsets.all(15),
                child: ListTile(
                  title: Text(_journals[index]['title']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_journals[index]['description']),
                      Text('Height: ${_journals[index]['height']} meters'),
                      Text('Weight: ${_journals[index]['weight']} kg'),
                      FutureBuilder<double>(
                        future: _calculateBMIForItem(_journals[index]),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else {
                            if (snapshot.hasData) {
                              return Text(
                                  'BMI: ${snapshot.data!.toStringAsFixed(2)}');
                            } else {
                              return Text('BMI: N/A');
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _showForm(_journals[index]['id']),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteItem(_journals[index]['id']),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }

  // Calculate BMI based on the current input fields
  Future<double> _calculateBMI() async {
    double height = double.tryParse(_heightController.text) ?? 0.0;
    double weight = double.tryParse(_weightController.text) ?? 0.0;

    double heightInMeters = height / 100.0; // Convert height to meters

    double bmi = weight / (heightInMeters * heightInMeters);
    print('BMI: $bmi');
    return double.parse(bmi.toStringAsFixed(2));
  }
}
