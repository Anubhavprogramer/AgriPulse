import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Soil Health App')),
      body: Center(child: Text('Welcome to the Soil Health App!')),
    );
  }
}
