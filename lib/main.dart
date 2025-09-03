import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/input_screen.dart';
import 'screens/results_screen.dart';
import 'screens/about_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soil Health App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/input': (context) => InputScreen(),
        '/results': (context) => ResultsScreen(),
        '/about': (context) => AboutScreen(),
      },
    );
  }
}
