import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/detail/favorite_icon_provider.dart';
import 'package:restaurant_app/provider/favorite/favorite_list_povider.dart';

class FavoriteIconWidget extends StatefulWidget {
  final Restaurant restaurant;
  const FavoriteIconWidget({
    super.key,
    required this.restaurant,
  });

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  @override
  void initState() {
    final favoriteListProvider = context.read<FavoriteListProvider>();
    final favoriteIconProvider = context.read<FavoriteIconProvider>();

    Future.microtask(() {
      final restaurantInList =
          favoriteListProvider.checkItemFavorite(widget.restaurant);
      favoriteIconProvider.isFavorited = restaurantInList;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final favoriteListProvider = context.read<FavoriteListProvider>();
        final favoriteIconProvider = context.read<FavoriteIconProvider>();
        final isFavorited = favoriteIconProvider.isFavorited;

        if (!isFavorited) {
          favoriteListProvider.addFavorite(widget.restaurant);
        } else {
          favoriteListProvider.removeFavorite(widget.restaurant);
        }
        favoriteIconProvider.isFavorited = !isFavorited;
      },
      icon: Icon(
        context.watch<FavoriteIconProvider>().isFavorited
            ? Icons.favorite
            : Icons.favorite_outline,
        color: Colors.pink,
      ),
    );
  }
}
