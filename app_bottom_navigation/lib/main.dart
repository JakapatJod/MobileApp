import 'package:flutter/material.dart';
import 'activity_page.dart';
import 'discovery_page.dart';
import 'home_page.dart';
import 'feed_page.dart';
import 'library_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test Program',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Add item'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final tabs = [
    Home(),
    Discovery(),
    Library(),
    Feed(),
    ActivityPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.shifting,
        iconSize: 35,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Discover',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Library',
              backgroundColor: Colors.pink),
          BottomNavigationBarItem(
              icon: Icon(Icons.rss_feed),
              label: 'Feed',
              backgroundColor: Colors.deepOrange),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Activity',
              backgroundColor: Colors.deepPurple),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
