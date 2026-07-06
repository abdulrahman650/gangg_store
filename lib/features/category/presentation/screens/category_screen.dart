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
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/arrowBack.svg',
                    width: 18,
                    height: 18,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Gang Store',
                    style: text.titleMedium?.copyWith(
                      color: AppColors.primary,
                      fontSize: 17,
                    ),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/icons/search.svg',
                    width: 18,
                    height: 18,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 14),
                  SvgPicture.asset(
                    'assets/icons/bag.svg',
                    width: 18,
                    height: 18,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),

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
                  _CategoryChip(
                    title: 'Luxury',
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

            const _BottomNavBar(),
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
              color: isSelected ? AppColors.white : AppColors.primary,
            ),
            const SizedBox(width: 5),
          ],
          Text(
            title,
            style: text.titleSmall?.copyWith(
              color: isSelected ? AppColors.white : AppColors.primary,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _BottomNavItem(
            label: 'Home',
            asset: 'assets/icons/Home.svg',
          ),
          _BottomNavItem(
            label: 'Category',
            asset: 'assets/icons/category.svg',
            isActive: true,
          ),
          _BottomNavItem(
            label: 'Wishlist',
            asset: 'assets/icons/love.svg',
          ),
          _BottomNavItem(
            label: 'Profile',
            asset: 'assets/icons/profile.svg',
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final String label;
  final String asset;
  final bool isActive;

  const _BottomNavItem({
    required this.label,
    required this.asset,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = isActive ? AppColors.primary : AppColors.black;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          asset,
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(
            color,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            color: color,
          ),
        ),
      ],
    );
  }
}