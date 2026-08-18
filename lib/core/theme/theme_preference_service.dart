import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferenceService {
  static const String _themeKey = 'theme_mode';

  final SharedPreferencesAsync _preferences;

  ThemePreferenceService({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  Future<String?> loadThemeMode() {
    return _preferences.getString(_themeKey);
  }

  Future<void> saveThemeMode(String mode) async {
    await _preferences.setString(_themeKey, mode);
  }
}
