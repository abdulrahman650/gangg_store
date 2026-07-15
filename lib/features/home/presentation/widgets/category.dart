import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/core/theme/theme_cubit.dart';
import 'package:gangg_store/core/utils/guest_guard.dart';
import 'package:gangg_store/core/services/service_locators.dart';

import '../../../category/presentation/cubit/category_cubit.dart';
import '../../../category/presentation/cubit/category_stata.dart';
import '../../../category/presentation/screens/category_screen.dart';
import 'category_item.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CategoryCubit>()..getCategories(),
      child: const _CategoryView(),
    );
  }
}

class _CategoryView extends StatelessWidget {
  const _CategoryView();

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
                GuestGuard.run(
                  context,
                  onAuthenticated: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CategoryScreen(),
                      ),
                    );
                  },
                );
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

        BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const SizedBox(
                height: 85,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (state is CategoryFailure) {
              return SizedBox(
                height: 85,
                child: Center(
                  child: Text(state.error),
                ),
              );
            }

            if (state is CategorySuccess) {
              return SizedBox(
                height: 85,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    final category = state.categories[index];

                    return CategoryItem(
                      label: category.name,
                      imageUrl: category.coverPictureUrl,
                      onTap: () {
                        GuestGuard.run(
                          context,
                          onAuthenticated: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CategoryScreen(
                                  // selectedCategory: category.name,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}