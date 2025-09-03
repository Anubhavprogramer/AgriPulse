import 'package:flutter/material.dart';
import '../models/reading.dart';
import 'reports_screen.dart';
import 'history_screen.dart';
import '../services/firebase_service.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Add a new reading using FirebaseService
  Future<void> _addReading() async {
    final reading = Reading(
      timestamp: DateTime.now(),
      temperature: 24 + (5 * (0.5 - (DateTime.now().second % 10) / 10)), // random-ish
      moisture: 35 + (10 * (0.5 - (DateTime.now().second % 10) / 10)),
    );
    await FirebaseService().addReading(reading);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseService().currentUser;
    if (user == null) {
      return Center(child: Text('Not logged in'));
    }
    // Fetch readings once and keep them in memory for this session
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'Reports' : 'History'),
        actions: _selectedIndex == 0
            ? [
                IconButton(
                  icon: Icon(Icons.add),
                  tooltip: 'Test (Add Reading)',
                  onPressed: _addReading,
                ),
              ]
            : null,
      ),
      body: StreamBuilder<List<Reading>>(
        stream: FirebaseService().readingsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error loading readings'));
          }
          final readings = snapshot.data ?? [];
          if (_selectedIndex == 0) {
            return ReportsScreen(latestReading: readings.isNotEmpty ? readings.first : null);
          } else {
            return HistoryScreen(readings: readings);
          }
        },
      ),
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

