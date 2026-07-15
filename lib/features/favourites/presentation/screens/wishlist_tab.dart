import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/core/services/service_locators.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/features/favourites/presentation/cubit/wishlist_cubit.dart';
import 'package:gangg_store/features/favourites/presentation/cubit/wishlist_state.dart';
import 'package:gangg_store/features/home/presentation/widgets/product_card.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocBuilder<WishlistCubit, WishlistState>(
          builder: (context, state) {
            final favorites = getIt<WishlistCubit>().getFavorites();

            if (favorites.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.favorite_border,
                      size: 64,
                      color: AppColors.darkGray,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No favorites yet',
                      style: textTheme.titleLarge?.copyWith(
                        color: AppColors.darkGray,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add products to your wishlist',
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.darkGray,
                      ),
                    ),
                  ],
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.65,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return ProductCard(product: favorites[index]);
              },
            );
          },
        ),
      ),
    );
  }
}

