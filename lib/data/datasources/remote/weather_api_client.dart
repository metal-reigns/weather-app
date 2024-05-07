import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/configuration/configuration.dart';

class WeatherApiClient {
  Future<Map<String, dynamic>> fetchLocationByIP() async {
    var url = Uri.parse(
        '${Configuration.ipInfo.host}/json?token=${Configuration.ipInfo.apiKey}');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to fetch location by IP. Status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> fetchWeather(String city, String locale) async {
    var url = Uri.parse(
        '${Configuration.openWeather.host}/weather?q=$city&appid=${Configuration.openWeather.apiKey}&units=metric&lang=$locale');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to fetch weather data. Status code: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> fetchDailyForecast(String city, String locale) async {
    var url = Uri.parse(
        '${Configuration.openWeather.host}/forecast?q=$city&appid=${Configuration.openWeather.apiKey}&units=metric&lang=$locale');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['list'];
    } else {
      throw Exception(
          'Failed to load forecast data. Status code: ${response.statusCode}');
    }
  }
}
