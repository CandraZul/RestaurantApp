import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/customer_review.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late MockApiService mockApiService;
  late RestaurantListProvider provider;

  setUp(() {
    mockApiService = MockApiService();
    provider = RestaurantListProvider(mockApiService);
  });

  group("restaurant list provider", () {
    test('should emit loading state initially when fetching data', () async {
      when(mockApiService.getRestaurantList).thenAnswer((_) async =>
          RestaurantListResponse(
              error: false, restaurants: [], message: '', count: 0));

      provider.fetchRestaurantList();
      expect(provider.resultState, isA<RestaurantListLoadingState>());
    });

    test('should change state to error if API returns error', () async {
      when(mockApiService.getRestaurantList).thenAnswer((_) async =>
          RestaurantListResponse(
              error: true, message: "API Error", count: 0, restaurants: []));

      await provider.fetchRestaurantList();
      expect(provider.resultState, isA<RestaurantListErrorState>());
      expect((provider.resultState as RestaurantListErrorState).error,
          "API Error");
    });

    test('should update state to loaded if API returns success', () async {
      final mockRestaurants = [
        Restaurant(
            id: 'id',
            name: 'Restaurant 1',
            description: 'description',
            pictureId: 'pictureId',
            city: 'city',
            address: 'address',
            rating: 1,
            categories: <Category>[],
            menus: Menus(foods: <MenuItem>[], drinks: <MenuItem>[]),
            customerReviews: <CustomerReview>[]),
        Restaurant(
            id: 'id',
            name: 'Restaurant 2',
            description: 'description',
            pictureId: 'pictureId',
            city: 'city',
            address: 'address',
            rating: 1,
            categories: <Category>[],
            menus: Menus(foods: <MenuItem>[], drinks: <MenuItem>[]),
            customerReviews: <CustomerReview>[])
      ];
      
      when(mockApiService.getRestaurantList).thenAnswer((_) async =>
          RestaurantListResponse(
              error: false,
              restaurants: mockRestaurants,
              message: '',
              count: 0));

      await provider.fetchRestaurantList();
      expect(provider.resultState, isA<RestaurantListLoadedState>());
      expect(
          (provider.resultState as RestaurantListLoadedState).data.length, 2);
    });
  });
}
