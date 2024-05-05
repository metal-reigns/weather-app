import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/domain/entity/current_weather.dart';
import 'package:weather_app/domain/entity/daily_weather.dart';
import 'package:weather_app/domain/preferences_service.dart';

class WeatherProvider with ChangeNotifier {
  final String apiKey = '6f1d3f3c24abb10a55e458cdc5a18390';
  List<CurrentWeather> weathers = [];
  bool isLoaded = false;
  final PreferencesService _prefs = PreferencesService();

  WeatherProvider() {
    _loadSavedOrFetchDefault();
    print('WeatherProvider start');
  }

  Future<void> _loadSavedOrFetchDefault() async {
    print("Loading saved or default weather data...");
    try {
      List<String> savedLocations = await _prefs.loadLocations();
      print("Saved locations: $savedLocations");
      if (savedLocations.isNotEmpty) {
        for (String city in savedLocations) {
          await fetchWeather(city);
        }
      } else {
        var locationData = await _fetchLocationByIP();
        await fetchWeather(locationData['city']);
      }
      isLoaded = true;
      notifyListeners();
    } catch (e) {
      print('Initialization error: $e');
      isLoaded = true;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> _fetchLocationByIP() async {
    var url = Uri.parse('https://ipinfo.io/json?token=4239c685d6b877');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return {
        'city': json['city'],
      };
    } else {
      print(
          "Failed to fetch location by IP. Status code: ${response.statusCode}, Response body: ${response.body}");
      throw Exception('Failed to fetch location by IP');
    }
  }

  Future<void> fetchWeather(String city) async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      CurrentWeather weather = CurrentWeather.fromJson(jsonData, []);
      print(jsonData);
      weathers.add(weather);
      notifyListeners();
      fetchDailyForecast(weather.cityName, weather);
    } else {
      print('Failed to fetch weather data: ${response.statusCode}');
    }
  }

  Future<void> fetchDailyForecast(String city, CurrentWeather weather) async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      // print('JSON data fetchDailyForecast: $jsonData');
      List<DailyWeather> hourlyForecasts =
          (jsonData['list'] as List).map((data) {
        return DailyWeather.fromJson(data);
      }).toList();
      weather.dailyForecasts = hourlyForecasts;
      notifyListeners();

      print("Updated Daily Forecasts:");
      for (var forecast in hourlyForecasts) {
        print(forecast.toString());
      }
    } else {
      print('Failed to load forecast data: ${response.statusCode}');
    }
  }

  void addLocation(String city) async {
    await fetchWeather(city);
    _prefs.saveLocations(weathers.map((w) => w.cityName).toList());
    notifyListeners();
    printWeatherData(); // Выводим данные о погоде в консоль
  }

  void removeLocation(String city) {
    weathers.removeWhere((weather) => weather.cityName == city);
    _prefs.saveLocations(weathers.map((w) => w.cityName).toList());
    notifyListeners();
  }

  void printWeatherData() {
    for (var weather in weathers) {
      print(weather.toString());
    }
  }
}
