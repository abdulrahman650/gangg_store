

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/core/services/service_locators.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/features/favourites/presentation/cubit/wishlist_cubit.dart';
import '../../../../core/utils/add_to_cart_helper.dart';
import '../../../favourites/presentation/cubit/wishlist_state.dart';
import '../cubit/product_details_cubit.dart';
import '../cubit/product_details_state.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              builder: (context, productState) {
                if (productState is! ProductDetailsLoaded) {
                  return const SizedBox.shrink();
                }

                final product = productState.product;

                return BlocSelector<WishlistCubit, WishlistState, bool>(
                  selector: (_) {
                    return context.read<WishlistCubit>().isFavorite(product.id);
                  },
                  builder: (context, isFavorite) {
                    return Material(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          context.read<WishlistCubit>().toggleFavorite(product);
                        },
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.gray.withOpacity(.35),
                            ),
                          ),
                          child: Icon(
                            isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: isFavorite
                                ? Colors.red
                                : AppColors.darkGray,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(width: 12),
            Expanded(
              child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                builder: (context, state) {
                  if (state is! ProductDetailsLoaded) {
                    return const SizedBox(height: 56);
                  }

                  final inStock = state.product.stock > 0;

                  return SizedBox(
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: inStock
                          ? () {
                        CartHelper.addToCart(
                          context: context,
                          productId: state.product.id,
                          quantity: state.quantity,
                          productName: state.product.name,
                        );
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: inStock
                            ? AppColors.primary
                            : AppColors.gray,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: Icon(
                        Icons.shopping_bag_outlined,
                        color: inStock
                            ? Colors.white
                            : AppColors.darkGray,
                      ),
                      label: Text(
                        inStock
                            ? "Add To Cart"
                            : "Out of Stock",
                        style: TextStyle(
                          color: inStock
                              ? Colors.white
                              : AppColors.darkGray,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
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