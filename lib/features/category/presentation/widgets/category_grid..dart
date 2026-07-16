import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/category_cubit.dart';
import '../cubit/category_stata.dart';
import 'category_cart.dart';
import 'category_error.dart';
import 'category_empty.dart';
import 'shimmer/category_grid_shimmer.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const CategoryGridShimmer();
        }

        if (state is CategoryFailure) {
          return CategoryError(
            message: state.error,
            onRetry: () {
              context.read<CategoryCubit>().getCategories();
            },
          );
        }

        if (state is CategorySuccess) {
          if (state.categories.isEmpty) {
            return const CategoryEmpty();
          }

          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: state.categories.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: .82,
            ),
            itemBuilder: (context, index) {
              final category = state.categories[index];

              return CategoryCart(
                title: category.name,
                subtitle: category.description,
                imageAsset: category.coverPictureUrl,
                height: 190,
                onTap: () {},
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}