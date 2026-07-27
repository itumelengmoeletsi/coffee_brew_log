import 'package:flutter/material.dart';
import '../models/brew.dart';

class BrewCard extends StatelessWidget {
  final Brew brew;
  final VoidCallback onDelete;

  const BrewCard({
    super.key,
    required this.brew,
    required this.onDelete
  }); 

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Rating in a circle 
            const Icon(Icons.circle, size: 12, color: colors.blueGrey),
            const SizedBox(width: 8)

            // Name of brew
            Expanded(
              child: Column(
                
              ),
            )
            // Method
            // grain weight
            // water weight
            // with the rating on the left, name in the center and everything beneath the name 
            // and the edit button on the right
          ],
        ),
      ),
    );
  }
}