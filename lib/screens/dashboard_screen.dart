import 'package:flutter/material.dart';
import '../models/reading.dart';
import '../services/firebase_service.dart';
import 'reports_screen.dart';

class DashboardScreen extends StatelessWidget {
  final List<Reading> readings;

  const DashboardScreen({Key? key, required this.readings}) : super(key: key);

  // Add a new reading
  Future<void> _addReading() async {
    final reading = Reading(
      timestamp: DateTime.now(),
      temperature: 24 +
          (5 * (0.5 - (DateTime.now().second % 10) / 10)), // random-ish
      moisture: 35 +
          (10 * (0.5 - (DateTime.now().second % 10) / 10)),
    );
    await FirebaseService().addReading(reading);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.green[50],
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.science),
                label: const Text("Test"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _addReading,
              ),
            ],
          ),
        ),

        // ✅ Show Reports screen with latest reading
        Expanded(
          child: ReportsScreen(
            latestReading: readings.isNotEmpty ? readings.first : null,
          ),
        ),
      ],
    );
  }
}
