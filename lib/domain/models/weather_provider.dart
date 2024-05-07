import 'package:flutter/material.dart';
import 'package:weather_app/data/datasources/local/shared_preferences_manager.dart';
import 'package:weather_app/data/datasources/remote/weather_api_client.dart';
import 'package:weather_app/domain/entity/current_weather.dart';
import 'package:weather_app/domain/entity/daily_weather.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherApiClient _apiClient = WeatherApiClient();
  final SharedPreferencesManager _prefs = SharedPreferencesManager();
  List<CurrentWeather> weathers = [];
  String _currentLocale = 'en';
  bool isLoaded = false;

  WeatherProvider() {
    _loadSettingsAndData();
  }

  String get currentLocale => _currentLocale;

  set currentLocale(String locale) {
    if (_currentLocale != locale) {
      _currentLocale = locale;
      _prefs.saveLocale(locale); // Save locale to SharedPreferences
      _reloadWeatherData();
    }
  }

  Future<void> _loadSettingsAndData() async {
    _currentLocale =
        await _prefs.loadLocale(); // Load locale from SharedPreferences
    await _loadSavedOrFetchDefault();
  }

  Future<void> _loadSavedOrFetchDefault() async {
    try {
      List<String> savedLocations = await _prefs.loadLocations();
      isLoaded = false;
      notifyListeners();
      if (savedLocations.isNotEmpty) {
        for (String city in savedLocations) {
          await addLocation(city, currentLocale);
        }
      } else {
        var locationData = await _apiClient.fetchLocationByIP();
        await addLocation(locationData['city'], currentLocale);
      }
      isLoaded = true;
      notifyListeners();
    } catch (e) {
      print('Initialization error: $e');
      isLoaded = true;
      notifyListeners();
    }
  }

  Future<void> addLocation(String city, String locale) async {
    var weatherData = await _apiClient.fetchWeather(city, locale);
    var forecastData = await _apiClient.fetchDailyForecast(city, locale);
    CurrentWeather newWeather = CurrentWeather.fromJson(weatherData, []);
    newWeather.dailyForecasts =
        forecastData.map((data) => DailyWeather.fromJson(data)).toList();

    int index = weathers.indexWhere(
        (element) => element.cityName.toLowerCase() == city.toLowerCase());
    if (index != -1) {
      weathers[index] = newWeather;
    } else {
      weathers.add(newWeather);
    }

    _prefs.saveLocations(weathers.map((w) => w.cityName).toList());
    notifyListeners();
  }

  void removeLocation(String city) {
    weathers.removeWhere(
        (weather) => weather.cityName.toLowerCase() == city.toLowerCase());
    _prefs.saveLocations(weathers.map((w) => w.cityName).toList());
    notifyListeners();
  }

  void updateLocale(String newLocale) {
    if (currentLocale != newLocale) {
      currentLocale = newLocale;
      _reloadWeatherData();
    }
  }

  void _reloadWeatherData() async {
    isLoaded = false;
    notifyListeners();
    List<String> cities = weathers.map((w) => w.cityName).toList();
    weathers.clear();
    for (var city in cities) {
      await addLocation(city, _currentLocale);
    }
    isLoaded = true;
    notifyListeners();
  }
}
