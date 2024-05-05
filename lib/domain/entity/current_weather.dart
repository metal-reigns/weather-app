import 'package:weather_app/domain/entity/daily_weather.dart';

class CurrentWeather {
  final String cityName;
  final double temperature;
  final String mainDescription;
  final String detailedDescription;
  final String weatherIcon;
  final String condition;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final int visibility;
  final int pressure;
  final DateTime dateTime;
  List<DailyWeather> dailyForecasts;

  CurrentWeather({
    required this.cityName,
    required this.temperature,
    required this.mainDescription,
    required this.detailedDescription,
    required this.weatherIcon,
    required this.condition,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.visibility,
    required this.pressure,
    required this.dateTime,
    this.dailyForecasts = const [],
  });

  factory CurrentWeather.fromJson(
      Map<String, dynamic> json, List<DailyWeather> dailyForecasts) {
    return CurrentWeather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainDescription: json['weather'][0]['main'],
      detailedDescription: json['weather'][0]['description'],
      weatherIcon: json['weather'][0]['icon'],
      condition: json['weather'][0]['main'],
      feelsLike: json['main']['feels_like'].toDouble(),
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      visibility: json['visibility'],
      pressure: json['main']['pressure'],
      dateTime:
          DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true),
      dailyForecasts: dailyForecasts,
    );
  }

  @override
  String toString() {
    return 'CurrentWeather(cityName: $cityName, temperature: $temperature°C, mainDescription: $mainDescription, '
        'detailedDescription: $detailedDescription, weatherIcon: $weatherIcon, condition: $condition, '
        'feelsLike: $feelsLike°C, humidity: $humidity%, windSpeed: $windSpeed m/s, visibility: $visibility meters, '
        'pressure: $pressure hPa, dailyForecast: $dailyForecasts ';
  }
}
