import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _prefs;

  static Future<SharedPreferences> get instance async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    return _prefs!;
  }
}