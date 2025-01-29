import 'dart:convert';
import 'dart:io'; 
import 'dart:async'; 
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

  Future<http.Response> _makeRequest(Future<http.Response> Function() request) async {
    try {
      return await request().timeout(const Duration(seconds: 10));
    } on SocketException {
      throw Exception("No internet connection. Please check your network.");
    } on TimeoutException {
      throw Exception("Request timed out. Please try again.");
    } on HttpException {
      throw Exception("Could not connect to the server.");
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
  }

  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await _makeRequest(() => http.get(Uri.parse("$_baseUrl/list")));

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load restaurant list (Status Code: ${response.statusCode})");
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await _makeRequest(() => http.get(Uri.parse("$_baseUrl/detail/$id")));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load restaurant detail (Status Code: ${response.statusCode})");
    }
  }

  Future<RestaurantSearchResponse> searchRestaurant(String query) async {
    final response = await _makeRequest(() => http.get(Uri.parse("$_baseUrl/search?q=$query")));

    if (response.statusCode == 200) {
      return RestaurantSearchResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load search results (Status Code: ${response.statusCode})");
    }
  }

  Future<CustomerReviewResponse> addReview(String id, String name, String review) async {
    final response = await _makeRequest(() => http.post(
          Uri.parse("$_baseUrl/review"),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'id': id, 'name': name, 'review': review}),
        ));

    if (response.statusCode == 201) {
      return CustomerReviewResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to post review (Status Code: ${response.statusCode})");
    }
  }
}
