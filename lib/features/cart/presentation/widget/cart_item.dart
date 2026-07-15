import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/features/cart/data/model/cart_item_model.dart';
import 'package:gangg_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gangg_store/features/cart/presentation/cubit/cart_state.dart';

import '../../../../core/theme/theme_cubit.dart';

class CartItem extends StatelessWidget {
  final CartItemModel item;

  const CartItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (previous, current) {
        if (current is CartActionLoading) {
          return current.cartItemId == item.itemId;
        }
        return current is CartActionSuccess ||
            current is GetCartSuccess;
      },
      builder: (context, state) {
        final loading = state is CartActionLoading &&
            state.cartItemId == item.itemId;

        return AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: loading ? .6 : 1,
          child: IgnorePointer(
            ignoring: loading,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                // color: AppColors.lightGray,
                color: context.isDark
                    ? AppColors.darkGray
                    : AppColors.lightGray,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 90,
                      height: 90,
                      child: Image.network(
                        item.productCoverUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                        const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.productName,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          "Stock : ${item.productStock}",
                          style: textTheme.bodySmall?.copyWith(

                            color: context.isDark
                                ? AppColors.white
                                : AppColors.darkGray,
                          ),
                        ),

                        const SizedBox(height: 16),

                        Container(
                          width: 120,
                          height: 38,
                          decoration: BoxDecoration(

                            color: context.isDark
                                ? Colors.grey[500]
                                : AppColors.white,

                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: loading
                              ? const Center(
                            child: SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          )
                              : Row(
                            children: [
                              Expanded(
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    if (item.quantity > 1) {
                                      context.read<CartCubit>().updateQuantity(
                                        cartItemId: item.itemId,
                                        quantity: item.quantity - 1,
                                      );
                                    } else {
                                      context.read<CartCubit>().deleteCartItem(
                                        cartItemId: item.itemId,
                                      );
                                    }
                                  },

                                  icon: const Icon(Icons.remove),
                                ),
                              ),

                              Text(
                                item.quantity.toString(),
                                style: textTheme.bodyMedium,
                              ),

                              Expanded(
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    context
                                        .read<CartCubit>()
                                        .updateQuantity(
                                      cartItemId: item.itemId,
                                      quantity:
                                      item.quantity + 1,
                                    );
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 8),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      loading
                          ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                          : IconButton(
                        onPressed: () {
                          context
                              .read<CartCubit>()
                              .deleteCartItem(
                            cartItemId: item.itemId,
                          );
                        },
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 40),

                      Text(
                        "\$${item.totalPrice.toStringAsFixed(2)}",
                        style: textTheme.titleMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}