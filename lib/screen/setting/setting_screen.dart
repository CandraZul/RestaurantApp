import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/notification/local_notification_provider.dart';
import 'package:restaurant_app/provider/setting/notification_button_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Future<void> _requestPermission() async {
    context.read<LocalNotificationProvider>().requestPermissions();
  }

  Future<void> _showNotification() async {
    context.read<LocalNotificationProvider>().showNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("Restaurant Notification"),
            subtitle: Text("Enable lunch notification"),
            trailing: Switch(
              value: context
                  .watch<NotificationButtonProvider>()
                  .isNotificationEnabled,
              onChanged: (bool value) {
                context.read<NotificationButtonProvider>().toggleNotification();
                _requestPermission();
                _showNotification();
              },
            ),
          ),
        ],
      ),
    );
  }
}
