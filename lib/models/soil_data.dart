// Model class for soil data

class SoilData {
  final double ph;
  final double moisture;
  final double nitrogen;
  final double phosphorus;
  final double potassium;

  SoilData({
    required this.ph,
    required this.moisture,
    required this.nitrogen,
    required this.phosphorus,
    required this.potassium,
  });
}
