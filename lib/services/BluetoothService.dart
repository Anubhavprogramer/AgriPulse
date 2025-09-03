import 'dart:math';

class BluetoothService {
  // Singleton pattern
  static final BluetoothService _instance = BluetoothService._internal();
  factory BluetoothService() => _instance;
  BluetoothService._internal();

  // Simulate Bluetooth connection status
  bool get isConnected => false; // Change to true when real device is connected

  // Simulate reading from Bluetooth device
  Future<Map<String, double>> getReading() async {
    // If hardware is connected, fetch from device
    if (isConnected) {
      // TODO: Implement real Bluetooth read logic here
      // Example: return {'temperature': ..., 'moisture': ...};
    }
    // Otherwise, return mock data
    final now = DateTime.now().second;
    return {
      'temperature': 24 + (5 * (0.5 - (now % 10) / 10)),
      'moisture': 35 + (10 * (0.5 - (now % 10) / 10)),
    };
  }
}