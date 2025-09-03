import 'package:flutter/material.dart';
import '../models/reading.dart';
import 'package:fl_chart/fl_chart.dart';

class HistoryScreen extends StatelessWidget {
  final List<Reading> readings;
  const HistoryScreen({required this.readings, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Graph Section
        if (readings.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 220,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    // Temperature line
                    LineChartBarData(
                      spots: [
                        for (int i = 0; i < readings.length; i++)
                          FlSpot(i.toDouble(), readings[i].temperature),
                      ],
                      isCurved: true,
                      color: Colors.red,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                    // Moisture line
                    LineChartBarData(
                      spots: [
                        for (int i = 0; i < readings.length; i++)
                          FlSpot(i.toDouble(), readings[i].moisture),
                      ],
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  lineTouchData: LineTouchData(enabled: true),
                  minY: _minY(readings),
                  maxY: _maxY(readings),
                ),
              ),
            ),
          ),
        // Legend
        if (readings.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(Icons.show_chart, color: Colors.red, size: 18),
                SizedBox(width: 4),
                Text('Temperature'),
                SizedBox(width: 16),
                Icon(Icons.show_chart, color: Colors.blue, size: 18),
                SizedBox(width: 4),
                Text('Moisture'),
              ],
            ),
          ),
        // List Section
        Expanded(
          child: ListView.builder(
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
        ),
      ],
    );
  }

  double _minY(List<Reading> readings) {
    final values = <double>[];
    values.addAll(readings.map((r) => r.temperature));
    values.addAll(readings.map((r) => r.moisture));
    return values.reduce((a, b) => a < b ? a : b) - 5;
  }
  double _maxY(List<Reading> readings) {
    final values = <double>[];
    values.addAll(readings.map((r) => r.temperature));
    values.addAll(readings.map((r) => r.moisture));
    return values.reduce((a, b) => a > b ? a : b) + 5;
  }

  String _formatTime(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} '
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
