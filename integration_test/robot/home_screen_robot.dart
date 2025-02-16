import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class HomeScreenRobot {
  final WidgetTester tester;

  const HomeScreenRobot(this.tester);

  final searchFieldKey = const ValueKey('searchField');
  final restaurantListKey = const ValueKey('restaurantList');
  final loadingIndicatorKey = const ValueKey('loadingIndicator');
  final errorMessageKey = const ValueKey('errorMessage');

  Future<void> loadUI(Widget widget) async {
    await tester.pumpWidget(widget);
  }

  Future<void> waitForLoading() async {
    while (find.byKey(loadingIndicatorKey).evaluate().isEmpty) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    while (find.byKey(loadingIndicatorKey).evaluate().isNotEmpty) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  Future<void> searchRestaurant(String query) async {
    await tester.tap(find.byKey(searchFieldKey));
    await tester.enterText(find.byKey(searchFieldKey), query);
    await tester.testTextInput.receiveAction(TextInputAction.done);
  }

  Future<void> tapFirstRestaurant() async {
    await tester.tap(find.byKey(Key('restaurantItem_0')));
    await tester.pumpAndSettle();
  }
}
