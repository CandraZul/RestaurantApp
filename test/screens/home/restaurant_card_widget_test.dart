import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:restaurant_app/data/model/customer_review.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/screen/home/restaurant_card_widget.dart';

void main() {
  late Restaurant restaurant;
  late bool wasTapped;
  late Widget widget;

  setUp(() {
    wasTapped = false;
    restaurant = Restaurant(
        id: 'id',
        name: 'name',
        description: 'description',
        pictureId: 'pictureId',
        city: 'city',
        rating: 1.0,
        menus: Menus(foods: [], drinks: []),
        customerReviews: <CustomerReview>[],
        address: '',
        categories: []);

    widget = MaterialApp(
        home: Scaffold(
      body: RestaurantCard(
        restaurant: restaurant,
        onTap: () => wasTapped = true,
      ),
    ));
  });

  group("restaurant card widget", () {
    testWidgets("show minimum restaurant information correctly",
        (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(widget);

        expect(find.text(restaurant.name), findsOneWidget);
        expect(find.text(restaurant.city), findsOneWidget);
        expect(find.text(restaurant.rating.toString()), findsOneWidget);
        expect(find.byType(Image), findsOneWidget);
      });
    });

    testWidgets("should call onTap when tapped", (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(widget);

        await tester.tap(find.byType(RestaurantCard));
        await tester.pump();

        expect(wasTapped, true);
      });
    });
  });
}
