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
}
