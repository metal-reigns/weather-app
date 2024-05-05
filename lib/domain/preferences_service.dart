import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  Future<void> saveLocations(List<String> locations) async {
    final prefs = await SharedPreferences.getInstance();
    bool result = await prefs.setStringList('saved_locations', locations);
    print("Locations saved: $result");
  }

  Future<List<String>> loadLocations() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('saved_locations') ?? [];
  }

  Future<void> removeLocation(String location) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> currentLocations =
        prefs.getStringList('saved_locations') ?? [];
    currentLocations.remove(location);
    bool result =
        await prefs.setStringList('saved_locations', currentLocations);
    print("Location removed: $result");
  }
}
