import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/favorite/favorite_list_povider.dart';
import 'package:restaurant_app/provider/home/theme_provider.dart';
import 'package:restaurant_app/screen/home/restaurant_card_widget.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/services/local_notification_service.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<RestaurantListProvider>().fetchRestaurantList();
      context.read<FavoriteListProvider>().loadFavoritesFromDatabase();
    });
  }

  @override
  void dispose() {
    selectNotificationStream.close();
    didReceiveLocalNotificationStream.close();
    super.dispose();
  }

  void _onSearch(String query) {
    if (query.isNotEmpty) {
      context.read<RestaurantListProvider>().searchRestaurant(query);
    } else {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Restaurant",
        ),
        actions: [
          Consumer<ThemeProvider>(builder: (context, value, child) {
            return IconButton(
                key: const Key('themeButton'),
                onPressed: () {
                  value.toggleTheme();
                },
                icon: Icon(
                  key: const Key('themeIcon'),
                    value.isDarkMode ? Icons.dark_mode : Icons.light_mode));
          })
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              key: const Key('searchField'),
              controller: searchController,
              onChanged: _onSearch,
              decoration: const InputDecoration(
                hintText: 'Search here...',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
            ),
          ),
          Expanded(
            child: Consumer<RestaurantListProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  RestaurantListLoadingState() => const Center(
                      child: CircularProgressIndicator(
                        key: Key('loadingIndicator'),
                      ),
                    ),
                  RestaurantListLoadedState(data: var restaurantList) =>
                    ListView.builder(
                      key: const Key('restaurantList'),
                      itemCount: restaurantList.length,
                      itemBuilder: (context, index) {
                        final restaurant = restaurantList[index];

                        return RestaurantCard(
                          key: Key('restaurantItem_$index'),
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
                  RestaurantListErrorState(error: var message) => Center(
                      child: Text(
                        message,
                        key: const Key('errorMessage'),
                      ),
                    ),
                  _ => const SizedBox(),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}
