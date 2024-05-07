import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> saveLocale(String locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale);
  }

  Future<String> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('locale') ?? 'en';
  }
}
