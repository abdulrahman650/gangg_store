import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/core/services/cache_helper.dart';
import 'package:gangg_store/core/services/cache_keys.dart';
import 'package:gangg_store/core/services/service_locators.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/core/theme/theme_cubit.dart';
import 'package:gangg_store/core/utils/guest_guard.dart';
import 'package:gangg_store/features/category/presentation/cubit/category_cubit.dart';
import 'package:gangg_store/features/category/presentation/cubit/category_stata.dart';
import 'package:gangg_store/features/category/presentation/screens/category_screen.dart';
import 'package:gangg_store/features/home/presentation/widgets/category_item.dart';
import 'package:gangg_store/features/home/presentation/widgets/shimmer/category_loading_shimmer.dart';

import '../../../layout/presentation/screens/layout_screen.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  late final CategoryCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = getIt<CategoryCubit>();
    cubit.getCategories();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isGuest = CacheHelper.getData(CacheKeys.isGuest) == true;

    if (isGuest) {
      return const SizedBox.shrink();
    }

    return BlocProvider.value(
      value: cubit,
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
                    Layout.of(context)?.changeTab(1);
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
              return const CategoryLoadingShimmer();
            }

            if (state is CategoryFailure) {
              return SizedBox(
                height: 85,
                child: Center(
                  child: Text(
                    state.error,
                    textAlign: TextAlign.center,
                  ),
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
                            Layout.of(context)?.changeTab(1);
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