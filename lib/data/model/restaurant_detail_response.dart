import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantDetailResponse {
  final bool error;
  final String message;
  final Restaurant restaurant;
  final List<Category> categories;
  final Menus menus;
  final List<CustomerReview> customerReviews;

  RestaurantDetailResponse(
      {required this.error,
      required this.message,
      required this.restaurant,
      required this.categories,
      required this.menus,
      required this.customerReviews});

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantDetailResponse(
        error: json["error"],
        message: json["message"],
        restaurant: json["restaurant"],
        categories: json["categories"] != null
            ? List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x)))
            : <Category>[],
        menus: Menus.fromJson(json["menus"]) ,
        customerReviews: json["customerReviews"] != null
            ? List<CustomerReview>.from(json["customerReviews"]!.map((x) => CustomerReview.fromJson(x)))
            : <CustomerReview>[]);
  }
}

class CustomerReview {
  final String name;
  final String review;
  final String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) {
    return CustomerReview(
      name: json['name'],
      review: json['review'],
      date: json['date'],
    );
  }
}

class Menus {
  final List<MenuItem> foods;
  final List<MenuItem> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods: (json['foods'] as List)
          .map((item) => MenuItem.fromJson(item))
          .toList(),
      drinks: (json['drinks'] as List)
          .map((item) => MenuItem.fromJson(item))
          .toList(),
    );
  }
}

class MenuItem {
  final String name;

  MenuItem({required this.name});

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(name: json['name']);
  }
}

class Category {
  final String name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(name: json["name"]);
  }
}
