import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/detail/customer_review_provider.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/favorite/favorite_list_povider.dart';
import 'package:restaurant_app/provider/favorite/local_database_provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/home/theme_provider.dart';
import 'package:restaurant_app/provider/main/index_nav_provider.dart';
import 'package:restaurant_app/provider/notification/notification_provider.dart';
import 'package:restaurant_app/provider/setting/notification_button_provider.dart';
import 'package:restaurant_app/screen/detail/detail_screen.dart';
import 'package:restaurant_app/screen/favorite/favorite_screen.dart';
import 'package:restaurant_app/screen/main/main_screen.dart';
import 'package:restaurant_app/services/shared_preferences_service.dart';
import 'package:restaurant_app/services/sqlite_service.dart';
import 'package:restaurant_app/services/workmanager_service.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/style/theme/restaurant_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantApp extends StatelessWidget {
  final SharedPreferences prefs;

  const RestaurantApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _buildProviders(),
      child: const RestaurantAppView(),
    );
  }

  List<SingleChildWidget> _buildProviders() {
    final apiService = ApiService();
    final sqliteService = SqliteService();
    final workManagerService = WorkmanagerService();

    return [
      Provider(create: (_) => apiService),
      ChangeNotifierProvider(create: (_) => RestaurantListProvider(apiService)),
      ChangeNotifierProvider(create: (_) => RestaurantDetailProvider(apiService)),
      ChangeNotifierProvider(create: (_) => CustomerReviewProvider(apiService)),
      ChangeNotifierProvider(create: (_) => ThemeProvider(SharedPreferencesService(prefs))),
      ChangeNotifierProvider(create: (_) => IndexNavProvider()),
      ChangeNotifierProvider(create: (_) => FavoriteListProvider(sqliteService)),
      Provider(create: (_) => sqliteService),
      ChangeNotifierProvider(create: (_) => LocalDatabaseProvider(sqliteService)),
      Provider(create: (_) => workManagerService),
      ChangeNotifierProvider(create: (_) => NotificationButtonProvider()),
      ChangeNotifierProvider(create: (_) => NotificationProvider(prefs)),
    ];
  }
}

class RestaurantAppView extends StatelessWidget {
  const RestaurantAppView({super.key});

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
