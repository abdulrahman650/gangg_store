import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.gray),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.favorite_border,
                  color: AppColors.white,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: AppColors.white,
                  size: 20,
                ),
                label: const Text(
                  'Add to Cart',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
