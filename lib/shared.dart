import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<List<String>> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
    print(value);
    print(key);
  }
}
