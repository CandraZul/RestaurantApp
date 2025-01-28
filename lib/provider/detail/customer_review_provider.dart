import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/static/customer_review_result_state.dart';

class CustomerReviewProvider extends ChangeNotifier {
  final ApiService _apiServices;

  CustomerReviewProvider(
    this._apiServices,
  );

  CustomerReviewResultState _resultState = CustomerReviewNoneState();

  CustomerReviewResultState get resultState => _resultState;

  Future<void> addCustomerReview(String id, String name, String review) async {
    try {
      _resultState = CustomerReviewLoadingState();
      notifyListeners();

      final result = await _apiServices.addReview(id, name, review);

      if (result.error) {
        _resultState = CustomerReviewErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = CustomerReviewLoadedState(result.customerReviews);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = CustomerReviewErrorState(e.toString());
      notifyListeners();
    }
  }
}
