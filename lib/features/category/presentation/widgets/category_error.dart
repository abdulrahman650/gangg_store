import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';

class CategoryError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const CategoryError({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline,
            size: 70,
            color: Colors.red,
          ),
          const SizedBox(height: 15),
          Text(
            message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            onPressed: onRetry,
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}