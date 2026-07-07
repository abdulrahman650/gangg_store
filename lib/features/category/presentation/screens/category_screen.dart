import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/category_item.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme text = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 42,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  _CategoryChip(
                    title: 'Filters',
                    icon: Icons.tune,
                  ),
                  _CategoryChip(
                    title: 'Sort',
                    icon: Icons.swap_vert,
                  ),
                  _CategoryChip(
                    title: 'All',
                    isSelected: true,
                  ),
                  _CategoryChip(
                    title: 'New In',
                  ),

                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Expanded(
                          child: CategoryItem(
                            title: 'Watches',
                            subtitle: '240 Items',
                            imageAsset: 'assets/images/watch_category.png',
                            height: 175,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: CategoryItem(
                            title: 'Leather',
                            subtitle: '165 Items',
                            imageAsset: 'assets/images/bag_category.png',
                            height: 175,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const CategoryItem(
                      title: 'Fine Jewelry',
                      subtitle: 'Curated Collection',
                      imageAsset: 'assets/images/jewelry_category.png',
                      height: 190,
                      isWide: true,
                    ),

                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        Expanded(
                          child: CategoryItem(
                            title: 'Eyewear',
                            subtitle: '92 Items',
                            imageAsset: 'assets/images/glasses_category.png',
                            height: 170,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: CategoryItem(
                            title: 'Fragrance',
                            subtitle: '45 Items',
                            imageAsset: 'assets/images/fragrance_category.png',
                            height: 170,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: const [
                        Expanded(
                          child: CategoryItem(
                            title: 'Accessories',
                            subtitle: '132 Items',
                            imageAsset:
                                'assets/images/accessories_category.png',
                            height: 165,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: SizedBox(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    const CategoryItem(
                      title: 'Silk & Ties',
                      subtitle: 'Exquisite Silk',
                      imageAsset: 'assets/images/silk_category.png',
                      height: 155,
                      isWide: true,
                    ),
                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String title;
  final IconData? icon;
  final bool isSelected;

  const _CategoryChip({
    required this.title,
    this.icon,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme text = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.gray,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 13,
              color: isSelected ? AppColors.white : AppColors.darkGray,
            ),
            const SizedBox(width: 5),
          ],
          Text(
            title,
            style: text.titleSmall?.copyWith(
              color: isSelected ? AppColors.white : AppColors.darkGray,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
