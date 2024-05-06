class DailyWeather {
  final double temperature;
  final String description;
  final String icon;
  final double windSpeed;
  final int humidity;
  final double pressure;
  final DateTime dateTime;

  DailyWeather({
    required this.temperature,
    required this.description,
    required this.icon,
    required this.windSpeed,
    required this.humidity,
    required this.pressure,
    required this.dateTime,
  });

  @override
  String toString() {
    return 'DailyWeather: ${dateTime.hour}:00 Temperature: $temperature°C, Description: $description, Icon: $icon, '
        'Wind Speed: $windSpeed m/s, Humidity: $humidity%, Pressure: $pressure hPa';
  }

  factory DailyWeather.fromJson(Map<String, dynamic> data) {
    return DailyWeather(
      temperature: (data['main']['temp'] as num?)?.toDouble() ?? 0.0,
      description: data['weather'][0]['description'] ?? 'No description',
      icon: data['weather'][0]['icon'] ?? '',
      windSpeed: (data['wind']['speed'] as num?)?.toDouble() ?? 0.0,
      humidity: data['main']['humidity'] as int? ?? 0,
      pressure: (data['main']['pressure'] as num?)?.toDouble() ?? 0.0,
      dateTime: DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000),
    );
  }
}
