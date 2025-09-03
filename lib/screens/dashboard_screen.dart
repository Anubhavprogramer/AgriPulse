import 'package:flutter/material.dart';
import '../models/reading.dart';
import 'reports_screen.dart';
import 'history_screen.dart';
import '../services/firebase_service.dart';

class DashboardScreen extends StatefulWidget {
	DashboardScreen({Key? key}) : super(key: key);

	@override
	State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
		return Scaffold(
			appBar: AppBar(
				title: Text('Soil Health Home'),
				automaticallyImplyLeading: false,
			),
			body: Column(
				children: [
					Container(
						width: double.infinity,
						color: Colors.green[50],
						padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
						child: Row(
							mainAxisAlignment: MainAxisAlignment.spaceEvenly,
							children: [
								ElevatedButton.icon(
									icon: Icon(Icons.science),
									label: Text('Test'),
									style: ElevatedButton.styleFrom(
										backgroundColor: Colors.green,
										foregroundColor: Colors.white,
										padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
										textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
										shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
									),
									onPressed: _addReading,
								),
								ElevatedButton.icon(
									icon: Icon(Icons.receipt_long),
									label: Text('Reports'),
									style: ElevatedButton.styleFrom(
										backgroundColor: _selectedIndex == 0 ? Colors.green[700] : Colors.grey[300],
										foregroundColor: _selectedIndex == 0 ? Colors.white : Colors.black,
										padding: EdgeInsets.symmetric(horizontal: 28, vertical: 16),
										textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
										shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
									),
									onPressed: () => _onTabTapped(0),
								),
							],
						),
					),
					Expanded(
						child: StreamBuilder<List<Reading>>(
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
					),
				],
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
