import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/services/theme/app_theme.dart';

class SharedPreferencesManager {
  Future<void> saveLocations(List<String> locations) async {
    final prefs = await SharedPreferences.getInstance();
    bool result = await prefs.setStringList('saved_locations', locations);
    print("Locations saved: $result");
  }

  Future<List<String>> loadLocations() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('saved_locations') ?? [];
  }

  Future<void> removeLocation(String city) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> currentLocations = prefs.getStringList('locations') ?? [];
    currentLocations.remove(city);
    prefs.setStringList('locations', currentLocations);
  }

  Future<void> toggleTheme(AppTheme appTheme) async {}
}
