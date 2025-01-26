import 'package:flutter/material.dart';
import 'package:restaurant_app/screen/detail/detail_screen.dart';
import 'package:restaurant_app/screen/home/home_screen.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/style/theme/restaurant_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      initialRoute: NavigationRoute.mainRoute.name,
      theme: RestaurantTheme.lightTheme,
      darkTheme: RestaurantTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const HomeScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
              // tourismId: ModalRoute.of(context)?.settings.arguments as int,
            ),
      },
    );
  }
}
