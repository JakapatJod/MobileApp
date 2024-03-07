// import 'package:flutter/material.dart';
// import 'package:screens/simple_map_screen.dart';
// import 'package:flutter/cupertino.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => HomeScreenState();
// }

// class HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Google Map New"),
//         centerTitle: true,
//       ),
//       body: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => SimpleMapScreen(),
//                   ),
//                 );
//               },
//               child: const Text("Simple Map"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => CurrentLocation(),
//                   ),
//                 );
//               },
//               child: const Text("Current Location"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
