import 'package:flutter/material.dart';
import 'package:restaurant_app/services/shared_preferences_service.dart';

class ThemeProvider with ChangeNotifier {
  final SharedPreferencesService _service;

  ThemeProvider(this._service){
    _loadTheme();
  }

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> _loadTheme() async {
    final savedTheme = _service.getSettingValue();
    _themeMode = savedTheme;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    await _service.saveSettingValue(_themeMode);
    notifyListeners();
  }
}
