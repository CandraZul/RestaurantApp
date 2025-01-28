import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/customer_review_response.dart';
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/data/model/restaurant_search_response.dart';

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev/";

  static String get smallImageUrl => "$_baseUrl/images/small";
  static String get mediumImageUrl => "$_baseUrl/images/medium";
  static String get largeImageUrl => "$_baseUrl/images/large";

  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw ("Failed to load restaurant list");
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw ("Failed to load restaurant detail");
    }
  }

  Future<RestaurantSearchResponse> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));

    if (response.statusCode == 200) {
      return RestaurantSearchResponse.fromJson(jsonDecode(response.body));
    } else {
      throw ("Failed to load restaurant list");
    }
  }

  Future<CustomerReviewResponse> addReview(String id, String name, String review) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/review"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'id': id,
        'name': name,
        'review': review,
      }),
    );

    if (response.statusCode == 201) {
      return CustomerReviewResponse.fromJson(jsonDecode(response.body));
    } else {
      throw ("Failed post review");
    }
  }
}
