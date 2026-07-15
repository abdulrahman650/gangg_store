import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/features/category/presentation/screens/category_screen.dart';
import 'package:gangg_store/features/home/presentation/widgets/category_item.dart';

import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/utils/guest_guard.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Categories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.isDark
                    ? AppColors.white
                    : AppColors.black,
              ),
            ),
            GestureDetector(
              onTap: () {
                GuestGuard.run(context, onAuthenticated: () {});
              },
              child: const Text(
                'View All',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),

        SizedBox(
          height: 85,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              CategoryItem(IconImageName: 'bag', label: 'Bags'),
              CategoryItem(IconImageName: 'watch', label: 'Watches'),
              CategoryItem(IconImageName: 'jewelry', label: 'Jewelry'),
              CategoryItem(IconImageName: 'glasses', label: 'Eyewear'),
              CategoryItem(IconImageName: "belts", label: 'Belts'),
            ],
          ),
        ),
      ],
    );
  }
}
