import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/notification/notification_provider.dart';
import 'package:restaurant_app/services/workmanager_service.dart';
import 'package:workmanager/workmanager.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

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
            trailing: Consumer<NotificationProvider>(
              builder: (context, notificationProvider, child) {
                return Switch(
                  value: notificationProvider.isNotificationEnabled, 
                  onChanged: (bool value) async {
                    await notificationProvider.toggleNotification(value);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
