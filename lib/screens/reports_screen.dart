import 'package:flutter/material.dart';
import '../models/reading.dart';


class ReportsScreen extends StatelessWidget {
  final Reading? latestReading;
  const ReportsScreen({required this.latestReading, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Latest Report')),
      body: Center(
        child: latestReading == null
            ? Text('No readings yet.')
            : Card(
                margin: EdgeInsets.all(24),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Temperature: ${latestReading!.temperature.toStringAsFixed(1)} °C', style: TextStyle(fontSize: 20)),
                      SizedBox(height: 12),
                      Text('Moisture: ${latestReading!.moisture.toStringAsFixed(1)} %', style: TextStyle(fontSize: 20)),
                      SizedBox(height: 12),
                      Text('Time: ${_formatTime(latestReading!.timestamp)}', style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} '
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
