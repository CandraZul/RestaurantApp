import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/screen/detail/menu_card_widget.dart';
import 'package:restaurant_app/screen/detail/review_card_widget.dart';

class BodyOfDetailScreenWidget extends StatelessWidget {
  const BodyOfDetailScreenWidget({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(
              "${ApiService.smallImageUrl}/${restaurant.pictureId}",
              fit: BoxFit.cover,
            ),
            const SizedBox.square(dimension: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        restaurant.city,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    const SizedBox.square(dimension: 4),
                    Text(
                      restaurant.rating.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox.square(dimension: 16),
            Text(
              restaurant.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox.square(dimension: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Menu",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox.square(dimension: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Foods",
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox.square(dimension: 8),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: restaurant.menus.foods.length,
                itemBuilder: (context, index) {
                  final name = restaurant.menus.foods[index].name;
                  return MenuCardWidget(name: name, type: "foods");
                },
              ),
            ),
            const SizedBox.square(dimension: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Drinks",
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox.square(dimension: 8),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: restaurant.menus.foods.length,
                itemBuilder: (context, index) {
                  final name = restaurant.menus.drinks[index].name;
                  return MenuCardWidget(
                    name: name,
                    type: "drinks",
                  );
                },
              ),
            ),
            const SizedBox.square(dimension: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Reviews",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox.square(dimension: 10),
            Column(
              children: restaurant.customerReviews.map((customerReview){
              return ReviewCardWidget(
                name: customerReview.name, 
                review: customerReview.review,
                date: customerReview.date,
              );
            },).toList(),
          )
          ],
        ),
      ),
    );
  }
}


