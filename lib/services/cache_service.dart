import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/reading.dart';

class CacheService {
  static const _lastReadingKey = 'last_reading';

  static Future<void> saveLastReading(Reading reading) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_lastReadingKey, jsonEncode(reading.toJson()));
  }

  static Future<Reading?> getLastReading() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_lastReadingKey);
    if (jsonString == null) return null;
    return Reading.fromJson(jsonDecode(jsonString));
  }
}
