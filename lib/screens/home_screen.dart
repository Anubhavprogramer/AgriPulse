import 'package:flutter/material.dart';
import '../models/reading.dart';
import 'reports_screen.dart';
import 'history_screen.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Dummy data for demonstration
  final List<Reading> readings = [
    Reading(timestamp: DateTime.now(), temperature: 24.5, moisture: 38.2),
    Reading(timestamp: DateTime.now().subtract(Duration(hours: 1)), temperature: 23.9, moisture: 40.1),
    Reading(timestamp: DateTime.now().subtract(Duration(hours: 2)), temperature: 25.2, moisture: 37.5),
    Reading(timestamp: DateTime.now().subtract(Duration(hours: 3)), temperature: 24.0, moisture: 39.0),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      ReportsScreen(latestReading: readings.first),
      HistoryScreen(readings: readings),
    ];

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }
}

