import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_cubit.dart';
import '../../../core/utils/default_text_form_field.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor:Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.isDark
            ?  Theme.of(context).scaffoldBackgroundColor : AppColors.backgroundWhite ,
        elevation: 0,
        title: Text(
          'Gang Store',
          style: textTheme.headlineSmall?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        actions: [

          IconButton(
            icon: const Icon(Icons.card_travel),
            color: AppColors.primary,
            onPressed: () {
              // Handle cart button press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // 🔍 Search Bar
            DefaultTextFormField(
              hintText: 'Search for Gang accessories...',
              prefixIconImageName: 'search', // ضيف ايكون search.svg في assets/icons/
              fillColor: AppColors.gray.withOpacity(0.5),
              onChanged: (value) {
                // Handle search
              },
            ),

            const SizedBox(height:70),

            // 🏷️ Section Title
            Text(
              'TRENDING CATEGORIES',
              style: textTheme.titleMedium?.copyWith(
                color: AppColors.darkGray,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 16),

            // 📦 Categories Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.1,
              children: [
                _buildCategoryCard(
                  title: 'Timepieces',
                  subtitle: 'Curated Selection',
                  imagePath: 'assets/images/watch.png',
                  isDark: true,
                ),
                _buildCategoryCard(
                  title: 'Eyewear',
                  subtitle: 'New Arrivals',
                  imagePath: 'assets/images/glassess.png',
                  isDark: false,
                ),
                _buildCategoryCard(
                  title: 'Fine Leather',
                  subtitle: 'Handcrafted excellence from Milan',
                  imagePath: 'assets/images/bag.png',
                  isDark: true,
                  isFullWidth: true,
                ),
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // 🎨 Category Card Widget
  Widget _buildCategoryCard({
    required String title,
    required String subtitle,
    required String imagePath,
    required bool isDark,
    bool isFullWidth = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isDark ? AppColors.black : AppColors.gray,
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: isDark
              ? ColorFilter.mode(
            AppColors.black.withOpacity(0.3),
            BlendMode.darken,
          )
              : null,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: isDark
              ? LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              AppColors.black.withOpacity(0.7),
            ],
          )
              : null,
        ),
        padding: const EdgeInsets.all(16),
        alignment: Alignment.bottomLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}