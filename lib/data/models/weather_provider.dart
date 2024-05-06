import 'package:flutter/material.dart';
import 'package:weather_app/data/datasources/local/shared_preferences_manager.dart';
import 'package:weather_app/data/datasources/remote/weather_api_client.dart';
import 'package:weather_app/domain/entity/current_weather.dart';
import 'package:weather_app/domain/entity/daily_weather.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherApiClient _apiClient = WeatherApiClient();
  final SharedPreferencesManager _prefs = SharedPreferencesManager();
  List<CurrentWeather> weathers = [];
  bool isLoaded = false;

  WeatherProvider() {
    _loadSavedOrFetchDefault();
  }

  Future<void> _loadSavedOrFetchDefault() async {
    try {
      List<String> savedLocations = await _prefs.loadLocations();
      if (savedLocations.isNotEmpty) {
        for (String city in savedLocations) {
          await addLocation(city);
        }
      } else {
        var locationData = await _apiClient.fetchLocationByIP();
        await addLocation(locationData['city']);
      }
      isLoaded = true;
      notifyListeners();
    } catch (e) {
      print('Initialization error: $e');
      isLoaded = true;
      notifyListeners();
    }
  }

  Future<void> addLocation(String city) async {
    var weatherData = await _apiClient.fetchWeather(city);
    var forecastData = await _apiClient.fetchDailyForecast(city);
    CurrentWeather weather = CurrentWeather.fromJson(weatherData, []);
    weather.dailyForecasts =
        forecastData.map((data) => DailyWeather.fromJson(data)).toList();
    weathers.add(weather);
    _prefs.saveLocations(weathers.map((w) => w.cityName).toList());
    notifyListeners();
  }

  void removeLocation(String city) {
    weathers.removeWhere((weather) => weather.cityName == city);
    _prefs.saveLocations(weathers.map((w) => w.cityName).toList());
    notifyListeners();
  }
}
