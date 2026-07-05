import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/features/home/presentation/widgets/category_item.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            GestureDetector(
              onTap: () {},
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
              CategoryItem(icon: Icons.backpack_outlined, label: 'Bags'),
              CategoryItem(icon: Icons.watch, label: 'Watches'),
              CategoryItem(icon: Icons.diamond_outlined, label: 'Jewelry'),
              CategoryItem(icon: Icons.g_mobiledata, label: 'Eyewear'),
              CategoryItem(icon: Icons.accessibility, label: 'Belts'),
              CategoryItem(icon: Icons.backpack_outlined, label: 'Bags'),
              CategoryItem(icon: Icons.watch, label: 'Watches'),
              CategoryItem(icon: Icons.diamond_outlined, label: 'Jewelry'),
              CategoryItem(icon: Icons.g_mobiledata, label: 'Eyewear'),
              CategoryItem(icon: Icons.accessibility, label: 'Belts'),
            ],
          ),
        ),
      ],
    );
  }
}
