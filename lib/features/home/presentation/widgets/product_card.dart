import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/core/services/service_locators.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gangg_store/features/cart/presentation/cubit/cart_state.dart';
import 'package:gangg_store/features/home/data/model/product_model.dart';
import 'package:gangg_store/features/prodeuct_details/presentation/screens/product_details_screen.dart';
import 'package:gangg_store/features/favourites/presentation/cubit/wishlist_cubit.dart';
import '../../../../core/utils/guest_guard.dart';
import '../../../favourites/presentation/cubit/wishlist_state.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final hasDiscount = product.discountPercentage > 0;

    return InkWell(
      onTap: () {
        GuestGuard.run(
          context,
          onAuthenticated: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailScreen(productId: product.id),
              ),
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.gray,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.network(
                        product.coverPictureUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.center,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: AppColors.gray,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.gray,
                            child: const Icon(
                              Icons.image_not_supported,
                              color: AppColors.darkGray,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Discount Badge
                  if (hasDiscount)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '-${product.discountPercentage.toInt()}%',
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  // Favorite Button
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        GuestGuard.run(
                          context,
                          onAuthenticated: () {
                            getIt<WishlistCubit>().toggleFavorite(product);
                          },
                        );
                      },
                      child: BlocBuilder<WishlistCubit, WishlistState>(
                        builder: (context, state) {
                          final isFavorite = getIt<WishlistCubit>().isFavorite(product.id);
                          return Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              size: 16,
                              color: isFavorite ? Colors.red : AppColors.black,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 12),
                      Text(
                        ' ${product.rating > 0 ? product.rating.toStringAsFixed(1) : 'New'}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.black,
                        ),
                      ),
                      if (product.reviewsCount > 0)
                        Text(
                          ' (${product.reviewsCount})',
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.darkGray,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Price
                  if (hasDiscount) ...[
                    Text(
                      product.formattedPrice,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.darkGray.withAlpha(160),
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Text(
                      product.formattedDiscountedPrice,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ] else
                    Text(
                      product.formattedPrice,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        GuestGuard.run(
                          context,
                          onAuthenticated: () {
                            _showAddToCartDialog(context);
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 6),
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddToCartDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return BlocListener<CartCubit, CartState>(
          listener: (context, state) {
            if (state is GetCartSuccess) {
              Navigator.of(context, rootNavigator: true).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.name} added to cart'),
                  duration: const Duration(seconds: 2),
                ),
              );
            } else if (state is GetCartFailure) {
              Navigator.of(context, rootNavigator: true).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: AlertDialog(
            title: const Text('Add to Cart'),
            content: const Text('Adding item to cart...'),
            backgroundColor: Theme.of(dialogContext).scaffoldBackgroundColor,
          ),
        );
      },
    );

    context.read<CartCubit>().addToCart(
      productId: product.id,
      quantity: 1,
    );
  }
}
