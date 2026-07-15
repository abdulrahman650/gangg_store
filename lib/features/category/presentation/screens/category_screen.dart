import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/core/services/service_locators.dart';
import '../cubit/category_cubit.dart';
import '../cubit/category_stata.dart';
import '../widgets/category_cart.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CategoryCubit>()..getCategories(),
      child: const _CategoryScreenBody(),
    );
  }
}

class _CategoryScreenBody extends StatelessWidget {
  const _CategoryScreenBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CategoryFailure) {
            return Center(
              child: Text(state.error),
            );
          }

          if (state is CategorySuccess) {
            if (state.categories.isEmpty) {
              return const Center(
                child: Text("No Categories Found"),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.categories.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: .9,
              ),
              itemBuilder: (context, index) {
                final category = state.categories[index];

                return CategoryCart(
                  title: category.name,
                  subtitle: category.description,
                  imageAsset: category.coverPictureUrl,
                  height: 190,
                  onTap: () {
                    // هنفتح شاشة المنتجات الخاصة بالكاتيجوري بعدين
                  },
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}