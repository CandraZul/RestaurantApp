import 'package:flutter/foundation.dart';
import 'package:restaurant_app/services/local_notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationButtonProvider with ChangeNotifier {
  bool _isNotificationEnabled = false;

  bool get isNotificationEnabled => _isNotificationEnabled;

  NotificationButtonProvider() {
    _loadNotificationState();
  }

  Future<void> _loadNotificationState() async {
    final prefs = await SharedPreferences.getInstance();
    _isNotificationEnabled = prefs.getBool('notification') ?? false;
    notifyListeners();
  }

  Future<void> toggleNotification() async {
    _isNotificationEnabled = !_isNotificationEnabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notification', _isNotificationEnabled);
    notifyListeners();

    // if (_isNotificationEnabled) {
    //   await LocalNotificationService.scheduleNotification(
    //     id: 1,
    //     title: 'Restaurant Reminder',
    //     body: 'It\'s time for lunch!',
    //     hour: 23,
    //     minute: 50,
    //   );
    // }
  }
}
