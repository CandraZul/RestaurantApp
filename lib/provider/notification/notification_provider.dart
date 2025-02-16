import 'package:flutter/material.dart';
import 'package:restaurant_app/services/workmanager_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider extends ChangeNotifier {
  final SharedPreferences _local;
  final WorkmanagerService _workmanagerService = WorkmanagerService();
  bool _isNotificationEnabled = false;

  bool get isNotificationEnabled => _isNotificationEnabled;

  NotificationProvider(this._local){
    _loadNotificationStatus();
  }

  Future<void> _loadNotificationStatus() async {
    _isNotificationEnabled = _local.getBool('daily_reminder') ?? false;
    notifyListeners();
  }

  Future<void> toggleNotification(bool value) async {
    _isNotificationEnabled = value;
    await _local.setBool('daily_reminder', value);

    if (value) {
      await _workmanagerService.startDailyNotification();
    } else {
      await _workmanagerService.stopDailyNotification();
    }

    notifyListeners();
  }
}
