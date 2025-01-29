import 'package:flutter/material.dart';

class MenuCardWidget extends StatelessWidget {
  const MenuCardWidget({
    super.key,
    required this.name,
    required this.type
  });

  final String name;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
             type == "foods"
             ? Icons.restaurant
             : Icons.local_drink, 
              size: 40,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                name,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                textAlign: TextAlign.center,
                
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}