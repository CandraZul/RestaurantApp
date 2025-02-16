import 'package:flutter/material.dart';
import 'package:restaurant_app/restaurant_app.dart';
import 'package:restaurant_app/services/workmanager_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WorkmanagerService().init();

  final prefs = await SharedPreferences.getInstance();

  runApp(RestaurantApp(prefs: prefs));
}


