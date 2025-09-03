import 'package:flutter/material.dart';
import '../models/reading.dart';

class HistoryScreen extends StatelessWidget {
  final List<Reading> readings;
  const HistoryScreen({required this.readings, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('History')),
      body: ListView.builder(
        itemCount: readings.length,
        itemBuilder: (context, index) {
          final r = readings[index];
          return ListTile(
            leading: Icon(Icons.history),
            title: Text('Temp: ${r.temperature.toStringAsFixed(1)} °C, Moisture: ${r.moisture.toStringAsFixed(1)} %'),
            subtitle: Text(_formatTime(r.timestamp)),
          );
        },
      ),
    );
  }

  String _formatTime(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} '
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
