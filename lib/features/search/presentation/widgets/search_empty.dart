import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SearchEmptyWidget extends StatelessWidget {
  const SearchEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 90),
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            color: AppColors.primary.withOpacity(.6),
            size: 70,
          ),
          const SizedBox(height: 18),
          const Text(
            "No Products Found",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Try searching with another keyword.",
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }
}