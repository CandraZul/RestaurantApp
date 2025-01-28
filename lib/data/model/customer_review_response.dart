import 'package:restaurant_app/data/model/customer_review.dart';

class CustomerReviewResponse {
  final bool error;
  final String message;
  final List<CustomerReview> customerReviews;

  CustomerReviewResponse(
      {required this.error,
      required this.message,
      required this.customerReviews});

  factory CustomerReviewResponse.fromJson(Map<String, dynamic> json) {
    return CustomerReviewResponse(
      error: json["error"], 
      message: json["message"], 
      customerReviews: json["customerReviews"] != null
          ? List<CustomerReview>.from(json["customerReviews"]!.map((x) => CustomerReview.fromJson(x)))
          : <CustomerReview>[]
    );
  }
}
