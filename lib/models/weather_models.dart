import 'dart:convert';

class WeatherModel {
  final String locationName;
  final double temperature;
  final String weatherType;
  final String icon;

  WeatherModel(
      {required this.locationName,
      required this.temperature,
      required this.weatherType,
      required this.icon});

  Map<String, dynamic> toMap() {
    return {
      'locationName': locationName,
      'temperature': temperature,
      'weatherType': weatherType,
      'icon': icon,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    final data = map['current'];
    return WeatherModel(
      locationName: map['location']['name'] ?? '',
      temperature: data['temp_c']?.toDouble() ?? 0.0,
      weatherType: data['condition']['text'] ?? '',
      icon: data['condition']['icon'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source));
}
