import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail/customer_review_provider.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/static/customer_review_result_state.dart';

class AddReviewDialog extends StatelessWidget {
  final String restaurantId;

  const AddReviewDialog({
    super.key,
    required this.restaurantId,
  });

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final reviewController = TextEditingController();

    return AlertDialog(
      title: const Text('Add Review'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: reviewController,
            decoration: const InputDecoration(labelText: 'Review'),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            final provider = Provider.of<CustomerReviewProvider>(context, listen: false);
            await provider.addCustomerReview(
              restaurantId,
              nameController.text,
              reviewController.text,
            );
            // ignore: use_build_context_synchronously
            context.read<RestaurantDetailProvider>().fetchRestaurantDetail(restaurantId);

            final state = provider.resultState;
            if (state is CustomerReviewLoadedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Review added successfully!')),
              );
            } else if (state is CustomerReviewErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.error}')),
              );
            }

            Navigator.pop(context);
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
