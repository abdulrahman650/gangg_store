import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import '../cubit/product_details_cubit.dart';
import '../cubit/product_details_state.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              builder: (context, state) {
                return InkWell(
                  onTap: () {
                    if (state is ProductDetailsLoaded) {
                      context.read<ProductDetailsCubit>().toggleFavorite();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.gray),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      color: AppColors.white,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 12),
            Expanded(
              child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                builder: (context, state) {
                  final bool isLoaded = state is ProductDetailsLoaded;
                  final bool inStock = isLoaded && state.product.stock > 0;

                  return ElevatedButton.icon(
                    onPressed: inStock
                        ? () => context.read<ProductDetailsCubit>().addToCart()
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: inStock ? AppColors.primary : AppColors.gray,
                      minimumSize: const Size(double.infinity, 54),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: inStock ? AppColors.white : AppColors.darkGray,
                      size: 20,
                    ),
                    label: Text(
                      inStock ? 'Add to Cart' : 'Out of Stock',
                      style: TextStyle(
                        color: inStock ? AppColors.white : AppColors.darkGray,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}