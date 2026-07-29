import 'package:flutter/material.dart';
import 'package:frontend/models/brew.dart';
import 'package:frontend/config/theme.dart';

class BrewCard extends StatelessWidget {
  final Brew brew;
  final VoidCallback onEdit;
  
  const BrewCard({
    super.key,
    required this.brew,
    required this.onEdit,
  });

  Color _getRatingColor(int rating) {
    switch (rating) {
      case 5:
        return AppColors.rating5;
      case 4:
        return AppColors.rating4;
      case 3:
        return AppColors.rating3;
      case 2:
        return AppColors.rating2;
      case 1:
      default:
        return AppColors.rating1;
      

    }
  }

  Widget _buildTag({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.textSecondary.withOpacity(0.4)),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              // rating circle with 
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _getRatingColor(brew.rating),
                  border: Border.all(color: Colors.black12, width: 2),
                ),
                child: Center(
                  child: Text(
                    '${brew.rating}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 14),

              // main details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      brew.roasterName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // tags row
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        // Method Tag
                        _buildTag(
                          child: Text(
                            brew.brewMethod,
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12, 
                            ),
                          ),
                        ), 

                        // coffee weight tag
                        _buildTag(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.coffee,
                                size: 12,
                                color: AppColors.primaryAccent,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                '${brew.coffeeWeight.toInt()}',
                                style: TextStyle(
                                  color: AppColors.textSecondary, 
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // water weight tag
                        _buildTag(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.water_drop,
                                size: 12,
                                color: Colors.blueAccent[100],
                              ),
                              const SizedBox(width: 2),
                              Text(
                                '${brew.waterWeight.toInt()}',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          )
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // edit pencil icon
              IconButton(
                icon: const Icon(Icons.edit_note_rounded, size: 28),
                color: AppColors.primaryAccent,
                onPressed: onEdit,
              )
            ],
          ),
        )
      ],
    );
  }
}