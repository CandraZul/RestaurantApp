import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/favorite/favorite_list_povider.dart';
import 'package:restaurant_app/screen/home/restaurant_card_widget.dart';
import 'package:restaurant_app/static/navigation_route.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite List"),
      ),
      body: Consumer<FavoriteListProvider>(
        builder: (context, value, child) {
          final favoriteList = value.favoriteList;

          return switch (favoriteList.isNotEmpty) {
            true => ListView.builder(
                itemCount: favoriteList.length,
                itemBuilder: (context, index) {
                  final restaurant = favoriteList[index];

                  return RestaurantCard(
                    restaurant: restaurant,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        NavigationRoute.detailRoute.name,
                        arguments: restaurant.id,
                      );
                    },
                  );
                },
              ),
            _ => const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No Favorited Restaurant"),
                  ],
                ),
              )
          };
        },
      ),
    );
  }
}
