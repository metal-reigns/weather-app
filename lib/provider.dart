// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:weather_app/domain/entity/weather_entity.dart';
// import 'package:weather_app/domain/preferences_service.dart';
//
// class WeatherProvider with ChangeNotifier {
//   final String apiKey = '6f1d3f3c24abb10a55e458cdc5a18390';
//   List<CurrentWeather> weathers = [];
//   bool isLoaded = false;
//   final PreferencesService _prefs = PreferencesService();
//
//   WeatherProvider() {
//     _loadSavedOrFetchDefault();
//     print('WeatherProvider start');
//   }
//
//   Future<void> _loadSavedOrFetchDefault() async {
//     print("Loading saved or default weather data...");
//     try {
//       List<String> savedLocations = await _prefs.loadLocations();
//       print("Saved locations: $savedLocations");
//       if (savedLocations.isNotEmpty) {
//         await loadWeathers(savedLocations);
//       } else {
//         var locationData = await _fetchLocationByIP();
//         await fetchWeather(locationData['city']);
//         _prefs.saveLocations([locationData['city']]);
//       }
//     } catch (e) {
//       print('Initialization error: $e');
//       isLoaded = true;
//       notifyListeners();
//     }
//   }
//
//   Future<Map<String, dynamic>> _fetchLocationByIP() async {
//     var url = Uri.parse('https://ipinfo.io/json?token=4239c685d6b877');
//     var response = await http.get(url);
//     if (response.statusCode == 200) {
//       // Логируем тело ответа для отладки
//       print("Response body: ${response.body}");
//
//       var json = jsonDecode(response.body);
//       return {
//         'city': json['city'],
//         'latitude': json['loc'].split(',')[0],
//         'longitude': json['loc'].split(',')[1]
//       };
//     } else {
//       // Логируем тело ответа в случае ошибки
//       print(
//           "Failed to fetch location by IP. Status code: ${response.statusCode}, Response body: ${response.body}");
//       throw Exception('Failed to fetch location by IP');
//     }
//   }
//
//   Future<void> fetchWeather(String city) async {
//     var url = Uri.parse(
//         'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');
//     var response = await http.get(url);
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);
//       print(jsonData);
//       var coords = jsonData['coord'];
//       double lat = coords['lat'];
//       double lon = coords['lon'];
//       print(coords);
//       weathers.add(CurrentWeather.fromJson(jsonData));
//
//       await fetchHourlyWeather(lat, lon);
//     } else {
//       print('Failed to load weather data: ${response.statusCode}');
//     }
//     isLoaded = true;
//     notifyListeners();
//   }
//
//   Future<void> fetchHourlyWeather(double lat, double lon) async {
//     var hourlyUrl = Uri.parse(
//         'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=current,minutely,daily,alerts&appid=$apiKey&units=metric');
//     var hourlyResponse = await http.get(hourlyUrl);
//     if (hourlyResponse.statusCode == 200) {
//       var hourlyData = json.decode(hourlyResponse.body);
//       print(hourlyData);
//     } else {
//       print('Failed to load hourly weather data: ${hourlyResponse.statusCode}');
//     }
//   }
//
//   void clearWeathers() {
//     weathers.clear();
//     notifyListeners();
//   }
//
//   Future<void> loadWeathers(List<String> cities) async {
//     clearWeathers();
//     for (var city in cities) {
//       await fetchWeather(city);
//     }
//     isLoaded = true;
//     notifyListeners();
//   }
//
//   Future<void> saveLocations() async {
//     List<String> cities = weathers.map((weather) => weather.cityName).toList();
//     await _prefs.saveLocations(cities);
//   }
//
//   void addLocation(String city) async {
//     print("Adding city: $city");
//     await fetchWeather(city);
//     print("City added, saving locations");
//     await saveLocations();
//     print("Locations saved, notifying listeners");
//     notifyListeners();
//   }
//
//   void removeLocation(String city) {
//     weathers.removeWhere((element) => element.cityName == city);
//     saveLocations();
//     print('removeLocation $city}');
//     notifyListeners();
//   }
// }
