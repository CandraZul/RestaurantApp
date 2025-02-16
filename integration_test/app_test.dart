import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:restaurant_app/restaurant_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'robot/home_screen_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferences prefs;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  });

  testWidgets('Load UI -> Search Restaurant -> Tap on Restaurant',
      (tester) async {
    final homeScreenRobot = HomeScreenRobot(tester);

    await tester.pumpWidget(RestaurantApp(prefs: prefs));
    if (find.byKey(homeScreenRobot.loadingIndicatorKey).evaluate().isNotEmpty) {
      await homeScreenRobot.waitForLoading();
    }
    await tester.pumpAndSettle();

    await homeScreenRobot.searchRestaurant("Melting");
    if (find.byKey(homeScreenRobot.loadingIndicatorKey).evaluate().isNotEmpty) {
      await homeScreenRobot.waitForLoading();
    }
    await tester.pumpAndSettle();

    await homeScreenRobot.tapFirstRestaurant();
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('restaurantDetailPage')), findsOneWidget);
  });
}
