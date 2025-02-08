import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/detail/customer_review_provider.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/favorite/favorite_list_povider.dart';
import 'package:restaurant_app/provider/favorite/local_database_provider.dart';
import 'package:restaurant_app/provider/home/theme_provider.dart';
import 'package:restaurant_app/provider/main/index_nav_provider.dart';
import 'package:restaurant_app/provider/notification/local_notification_provider.dart';
import 'package:restaurant_app/provider/setting/notification_button_provider.dart';
import 'package:restaurant_app/screen/detail/detail_screen.dart';
import 'package:restaurant_app/screen/favorite/favorite_screen.dart';
import 'package:restaurant_app/screen/home/restaurant_list_provider.dart';
import 'package:restaurant_app/screen/main/main_screen.dart';
import 'package:restaurant_app/services/local_notification_service.dart';
import 'package:restaurant_app/services/shared_preferences_service.dart';
import 'package:restaurant_app/services/sqlite_service.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/style/theme/restaurant_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => ApiService(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(
            context.read<ApiService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantDetailProvider(
            context.read<ApiService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => CustomerReviewProvider(
            context.read<ApiService>(),
          ),
        ),
        ChangeNotifierProvider(create: (context) => ThemeProvider(SharedPreferencesService(prefs))),
        ChangeNotifierProvider(create: (context) => IndexNavProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteListProvider(SqliteService())),
        Provider(
          create: (context) => SqliteService(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalDatabaseProvider(
            context.read<SqliteService>(),
          ),
        ),
        Provider(
         create: (context) => LocalNotificationService()..init(),
       ),
        ChangeNotifierProvider(create: (context) => NotificationButtonProvider()),
        ChangeNotifierProvider(
         create: (context) => LocalNotificationProvider(
           context.read<LocalNotificationService>(),
         )..requestPermissions(),
       ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, value, child) {
        return MaterialApp(
          title: 'Restaurant App',
          initialRoute: NavigationRoute.mainRoute.name,
          theme: RestaurantTheme.lightTheme,
          darkTheme: RestaurantTheme.darkTheme,
          themeMode: value.themeMode,
          debugShowCheckedModeBanner: false,
          routes: {
            NavigationRoute.mainRoute.name: (context) => const MainScreen(),
            NavigationRoute.detailRoute.name: (context) => DetailScreen(
                  restaurantId:
                      ModalRoute.of(context)?.settings.arguments as String,
                ),
            NavigationRoute.favoriteRoute.name: (context) => FavoriteScreen()
          },
        );
      },
    );
  }
}
