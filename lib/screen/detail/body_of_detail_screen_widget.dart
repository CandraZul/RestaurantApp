import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/screen/detail/menu_card_widget.dart';
import 'package:restaurant_app/screen/detail/review_card_widget.dart';
import 'package:restaurant_app/screen/detail/review_dialog.dart';

class BodyOfDetailScreenWidget extends StatefulWidget {
  const BodyOfDetailScreenWidget({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  State<BodyOfDetailScreenWidget> createState() =>
      _BodyOfDetailScreenWidgetState();
}

class _BodyOfDetailScreenWidgetState extends State<BodyOfDetailScreenWidget> {
  void _showReviewDialog(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddReviewDialog(
          restaurantId: id,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Hero(
              tag: widget.restaurant.pictureId,
              child: Image.network(
                "${ApiService.smallImageUrl}/${widget.restaurant.pictureId}",
                fit: BoxFit.cover,
              ),
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
                        widget.restaurant.name,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        widget.restaurant.city,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                      Text(
                        widget.restaurant.address,
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
                      widget.restaurant.rating.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox.square(dimension: 16),
            Text(
              widget.restaurant.description,
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
                itemCount: widget.restaurant.menus.foods.length,
                itemBuilder: (context, index) {
                  final name = widget.restaurant.menus.foods[index].name;
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
                itemCount: widget.restaurant.menus.drinks.length,
                itemBuilder: (context, index) {
                  final name = widget.restaurant.menus.drinks[index].name;
                  return MenuCardWidget(
                    name: name,
                    type: "drinks",
                  );
                },
              ),
            ),
            const SizedBox.square(dimension: 16),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "Reviews",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.left,
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed:  () => _showReviewDialog(widget.restaurant.id),
              )
            ]),
            const SizedBox.square(dimension: 10),
            Column(
              children: widget.restaurant.customerReviews.map(
                (customerReview) {
                  return ReviewCardWidget(
                    name: customerReview.name,
                    review: customerReview.review,
                    date: customerReview.date,
                  );
                },
              ).toList(),
            )
          ],
        ),
      ),
    );
  }
}
