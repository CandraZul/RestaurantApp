import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _preferences;

  SharedPreferencesService(this._preferences);

  static const String keyTheme = "MYTHEME";

  Future<void> saveSettingValue(ThemeMode themeMode) async {
    try {
      await _preferences.setString(
          keyTheme, themeMode == ThemeMode.dark ? 'dark' : 'light');
    } catch (e) {
      throw Exception("Shared preferences cannot save the setting value.");
    }
  }

  ThemeMode getSettingValue() {
    String themeMode = _preferences.getString(keyTheme) ?? '';
    return themeMode == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }
}
