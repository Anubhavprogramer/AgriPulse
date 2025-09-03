import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Soil Health App')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome to the Soil Health App!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Easily input your soil data and get instant health analysis and recommendations.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            CustomButton(
              label: 'Input Soil Data',
              onPressed: () => Navigator.pushNamed(context, '/input'),
            ),
            SizedBox(height: 16),
            CustomButton(
              label: 'View Results',
              onPressed: () => Navigator.pushNamed(context, '/results'),
            ),
            SizedBox(height: 16),
            CustomButton(
              label: 'About',
              onPressed: () => Navigator.pushNamed(context, '/about'),
            ),
          ],
        ),
      ),
    );
  }
}
