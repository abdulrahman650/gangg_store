import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/features/cart/data/model/cart_item_model.dart';
import 'package:gangg_store/features/cart/presentation/cubit/cart_cubit.dart';

class CartItem extends StatefulWidget {
  final CartItemModel item;
  const CartItem({super.key, 
  required this.item, 
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  
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
              widget.item.productCoverUrl,
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
                  widget.item.productName,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  "stock:${widget.item.productStock}",
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.darkGray,
                  ),
                ),

                const SizedBox(height: 16),

                Container(
                  height: 38,
                  width: 115,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 18,
                          onPressed: () {
                            context.read<CartCubit>().decrement(
                            cartItemId: widget.item.itemId,
                             quantity: 1.toString());
                          },
                          icon:
                          SvgPicture.asset("assets/icons/delete.svg"),
                        ),
                      ),

                      Text(
                        widget.item.quantity.toString(),
                        style: textTheme.bodyMedium,
                      ),

                      Expanded(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 18,
                          onPressed: () {
                            context.read<CartCubit>().addToCart(productId: widget.item.productId,
                             quantity: 1);
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

          const SizedBox(width: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  context.read<CartCubit>().deleteCartItem(
                  cartItemId: widget.item.itemId);
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.grey,
                  size: 20,
                )
              ),

              const SizedBox(height: 40),

              Text(
                "\$${widget.item.totalPrice}",
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