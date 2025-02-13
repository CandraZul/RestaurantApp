import 'dart:math';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/services/local_notification_service.dart';
import 'package:workmanager/workmanager.dart';

const String dailyTaskName = "daily-notification ";
final _apiService = ApiService();

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == dailyTaskName) {
      await WorkmanagerService.showNotification();
    }
    return Future.value(true);
  });
}

class WorkmanagerService {
  static final flutterNotificationService = LocalNotificationService();

  void init() {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    flutterNotificationService.init();
  }

  Future<void> startDailyNotification() async {
    await flutterNotificationService.requestPermissions();
    final now = DateTime.now();
    final targetTime = DateTime(now.year, now.month, now.day, 10, 0);
    final initialDelay = targetTime.isBefore(now)
        ? targetTime.add(const Duration(days: 1)).difference(now)
        : targetTime.difference(now);
    await Workmanager().registerPeriodicTask(
      dailyTaskName,
      dailyTaskName,
      frequency: const Duration(days: 1),
      initialDelay: initialDelay,
      constraints: Constraints(networkType: NetworkType.connected),
      inputData: {
        'title': 'Daily Reminder',
        'message': "Don't forget to take lunch",
        'time': now.toIso8601String()
      },
    );
  }

  static Future<void> showNotification() async {
    final response = await _apiService.getRestaurantList();
    if (!response.error) {
      final random = Random();
      final selectedRestaurant =
          response.restaurants[random.nextInt(response.restaurants.length)];
      final int id = DateTime.now().millisecondsSinceEpoch.remainder(100000);;
      await flutterNotificationService.showNotification(
          id: id,
          title: "Don't Miss Your Lunch Break!",
          body:
              'Looking for a place to eat? Check out ${selectedRestaurant.name} for a great meal today!',
          payload: selectedRestaurant.id);
    }
  }

  Future<void> stopDailyNotification() async {
    await Workmanager().cancelAll();
  }
}
