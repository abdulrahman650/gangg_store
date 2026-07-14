import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/core/services/service_locators.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gangg_store/features/cart/presentation/cubit/cart_state.dart';
import 'package:gangg_store/features/favourites/presentation/cubit/wishlist_cubit.dart';
import 'package:gangg_store/features/favourites/presentation/cubit/wishlist_state.dart';
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
                final product = state is ProductDetailsLoaded ? state.product : null;
                if (product == null) return const SizedBox.shrink();
                
                final isFavorite = getIt<WishlistCubit>().isFavorite(product.id);
                return InkWell(
                  onTap: () {
                    if (state is ProductDetailsLoaded) {
                      getIt<WishlistCubit>().toggleFavorite(product);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.gray),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : AppColors.white,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 12),
            Expanded(
              child: BlocListener<CartCubit, CartState>(
                listener: (context, state) {
                  if (state is AddToCartSuccess) {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Item added to cart successfully",
                        ),
                      ),
                    );
                  }

                  if (state is GetCartFailure) {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                  builder: (context, state) {
                    final bool isLoaded = state is ProductDetailsLoaded;
                    final bool inStock = isLoaded && state.product.stock > 0;

                    return ElevatedButton.icon(
                      onPressed: inStock
                          ? () => _handleAddToCart(context, state)
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
            ),
          ],
        ),
      ),
    );
  }

  void _handleAddToCart(BuildContext context, ProductDetailsState state) {
    if (state is ProductDetailsLoaded) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Add to Cart'),
            content: Row(
              children: [
                const CircularProgressIndicator(color: AppColors.primary),
                const SizedBox(width: 16),
                Expanded(
                  child: Text('Adding ${state.quantity} item(s) to cart...'),
                ),
              ],
            ),
            backgroundColor: Theme.of(dialogContext).scaffoldBackgroundColor,
          );
        },
      );

      context.read<ProductDetailsCubit>().addToCart();
    }
  }
}