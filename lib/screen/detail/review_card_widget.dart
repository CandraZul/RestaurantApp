import 'package:flutter/material.dart';

class ReviewCardWidget extends StatelessWidget {
  const ReviewCardWidget({
    super.key,
    required this.name,
    required this.review,
    required this.date,
  });

  final String name;
  final String review;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              color: Colors.blue,
              size: 30,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "$name",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      " ($date)",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 5), 
                Text(
                  review,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 3, 
                  overflow: TextOverflow.ellipsis, 
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
