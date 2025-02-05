import 'package:restaurant_app/data/model/customer_review.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String address;
  final double rating;
  final List<Category> categories;
  final Menus menus;
  final List<CustomerReview> customerReviews;

  Restaurant(
      {required this.id,
      required this.name,
      required this.description,
      required this.pictureId,
      required this.city,
      required this.address,
      required this.rating,
      required this.categories,
      required this.menus,
      required this.customerReviews});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"] ?? '',
        pictureId: json["pictureId"],
        city: json["city"],
        address: json["address"] != null
            ? json["address"]
            : "",
        rating: (json["rating"] is int)
            ? (json["rating"] as int).toDouble()
            : json["rating"],
        categories: json["categories"] != null
            ? List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x)))
            : <Category>[],
        menus: json["menus"] != null
            ? Menus.fromJson(json["menus"])
            : Menus(foods: [], drinks: []),
        customerReviews: json["customerReviews"] != null
            ? List<CustomerReview>.from(
                json["customerReviews"]!.map((x) => CustomerReview.fromJson(x)))
            : <CustomerReview>[]);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'pictureId': pictureId,
      'city' : city,
      'rating' : rating
    };
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
