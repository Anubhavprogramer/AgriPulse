
import 'package:cloud_firestore/cloud_firestore.dart';
// Model for a soil reading (temperature and moisture)

class Reading {
  final DateTime timestamp;
  final double temperature;
  final double moisture;

  Reading({
    required this.timestamp,
    required this.temperature,
    required this.moisture,
  });

  // Convert Firestore document to Reading
  factory Reading.fromMap(Map<String, dynamic> map) {
    return Reading(
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      temperature: (map['temperature'] as num).toDouble(),
      moisture: (map['moisture'] as num).toDouble(),
    );
  }

  // Convert Reading to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'temperature': temperature,
      'moisture': moisture,
    };
  }
}
