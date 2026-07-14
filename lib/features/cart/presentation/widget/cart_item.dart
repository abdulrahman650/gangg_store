import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/features/cart/data/model/cart_item_model.dart';
import 'package:gangg_store/features/cart/presentation/cubit/cart_cubit.dart';

class CartItem extends StatelessWidget {
  final CartItemModel item;

  const CartItem({
    super.key,
    required this.item,
  });

  Future<void> _increment(BuildContext context) async {
    await context.read<CartCubit>().updateQuantity(
      cartItemId: item.itemId,
      quantity: item.quantity + 1,
    );
  }

  Future<void> _decrement(BuildContext context) async {
    if (item.quantity == 1) {
      await context.read<CartCubit>().deleteCartItem(
        cartItemId: item.itemId,
      );
    } else {
      await context.read<CartCubit>().updateQuantity(
        cartItemId: item.itemId,
        quantity: item.quantity - 1,
      );
    }
  }

  Future<void> _delete(BuildContext context) async {
    await context.read<CartCubit>().deleteCartItem(
      cartItemId: item.itemId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightGray,
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

                const SizedBox(height: 4),

                Text(
                  "Stock : ${item.productStock}",
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.darkGray,
                  ),
                ),

                const SizedBox(height: 16),

                Container(
                  height: 38,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => _decrement(context),
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
                          onPressed: () => _increment(context),
                          icon: const Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () => _delete(context),
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
    );
  }
}