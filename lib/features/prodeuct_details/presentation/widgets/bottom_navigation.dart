

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/core/services/service_locators.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/features/favourites/presentation/cubit/wishlist_cubit.dart';
import '../../../../core/utils/add_to_cart_helper.dart';
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
              builder: (context, state) {
                final product =
                state is ProductDetailsLoaded ? state.product : null;

                if (product == null) {
                  return const SizedBox.shrink();
                }

                final isFavorite =
                getIt<WishlistCubit>().isFavorite(product.id);

                return InkWell(
                  onTap: () {
                    getIt<WishlistCubit>().toggleFavorite(product);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.lightGray,
                      border: Border.all(color: AppColors.gray),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color:
                      isFavorite ? Colors.red : AppColors.darkGray,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(width: 12),
            Expanded(
              child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                builder: (context, state) {
                  final loaded = state is ProductDetailsLoaded;
                  final inStock = loaded && state.product.stock > 0;

                  return ElevatedButton.icon(
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
                      backgroundColor:
                      inStock ? AppColors.primary : AppColors.gray,
                      minimumSize: const Size(double.infinity, 54),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: inStock
                          ? Colors.white
                          : AppColors.darkGray,
                    ),
                    label: Text(
                      inStock ? "Add to Cart" : "Out of Stock",
                      style: TextStyle(
                        color: inStock
                            ? Colors.white
                            : AppColors.darkGray,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  );
                },
              ),
            ),
            // Expanded(
            //   child: BlocListener<CartCubit, CartState>(
            //     listener: (context, state) {
            //       if (state is CartActionSuccess) {
            //         if (_dialogOpened && Navigator.canPop(context)) {
            //           Navigator.pop(context);
            //           _dialogOpened = false;
            //         }
            //
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           const SnackBar(
            //             content:
            //             Text("Item added to cart successfully"),
            //           ),
            //         );
            //       }
            //
            //       if (state is CartActionFailure) {
            //         if (_dialogOpened && Navigator.canPop(context)) {
            //           Navigator.pop(context);
            //           _dialogOpened = false;
            //         }
            //
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           SnackBar(
            //             backgroundColor: Colors.red,
            //             content: Text(state.message),
            //           ),
            //         );
            //       }
            //     },
            //     child: BlocBuilder<ProductDetailsCubit,
            //         ProductDetailsState>(
            //       builder: (context, state) {
            //         final loaded =
            //         state is ProductDetailsLoaded;
            //
            //         final inStock =
            //             loaded && state.product.stock > 0;
            //
            //         return ElevatedButton.icon(
            //           onPressed: inStock
            //               ? () {
            //             CartHelper.addToCart(
            //               context: context,
            //               productId: state.product.id,
            //               quantity: state.quantity,
            //               productName: state.product.name,
            //             );
            //           }
            //               : null,
            //           style: ElevatedButton.styleFrom(
            //             backgroundColor:
            //             inStock ? AppColors.primary : AppColors.gray,
            //             minimumSize: const Size(double.infinity, 54),
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(16),
            //             ),
            //           ),
            //           icon: Icon(
            //             Icons.shopping_cart_outlined,
            //             color: inStock
            //                 ? Colors.white
            //                 : AppColors.darkGray,
            //           ),
            //           label: Text(
            //             inStock ? "Add to Cart" : "Out of Stock",
            //             style: TextStyle(
            //               color: inStock
            //                   ? Colors.white
            //                   : AppColors.darkGray,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 16,
            //             ),
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}