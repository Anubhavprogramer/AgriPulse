import 'package:flutter/material.dart';
import '../models/reading.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  final List<Reading> readings;
  const HistoryScreen({required this.readings, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (readings.isEmpty) {
      return const Center(child: Text("No readings available"));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Chart Card
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    "Soil Health Trends",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 250,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: true),
                        borderData: FlBorderData(show: true),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40, // ✅ ensures labels visible
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toInt().toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                );
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: (readings.length / 4).ceilToDouble(), // ✅ spread timestamps
                              getTitlesWidget: (value, meta) {
                                final int index = value.toInt();
                                if (index < 0 || index >= readings.length) {
                                  return const SizedBox.shrink();
                                }
                                final dt = readings[index].timestamp;
                                final formatted =
                                    DateFormat.Hm().format(dt); // HH:mm format
                                return Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: Text(
                                    formatted,
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.black),
                                  ),
                                );
                              },
                            ),
                          ),
                          rightTitles:
                              AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles:
                              AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
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
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.show_chart, color: Colors.red, size: 18),
                      const SizedBox(width: 4),
                      const Text("Temperature"),
                      const SizedBox(width: 16),
                      Icon(Icons.show_chart, color: Colors.blue, size: 18),
                      const SizedBox(width: 4),
                      const Text("Moisture"),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // History List Card
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: readings.length,
              itemBuilder: (context, index) {
                final r = readings[index];
                return ListTile(
                  leading: const Icon(Icons.history, color: Colors.green),
                  title: Text(
                    "Temp: ${r.temperature.toStringAsFixed(1)} °C,  Moisture: ${r.moisture.toStringAsFixed(1)} %",
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    _formatTime(r.timestamp),
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
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
