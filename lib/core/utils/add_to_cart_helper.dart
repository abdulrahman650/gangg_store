import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/core/services/service_locators.dart';
import 'package:gangg_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gangg_store/features/cart/presentation/cubit/cart_state.dart';

class CartHelper {
  CartHelper._();

  static final CartCubit _cartCubit = getIt<CartCubit>();

  static void addToCart({
    required BuildContext context,
    required String productId,
    required int quantity,
    String? productName,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return BlocProvider.value(
          value: _cartCubit,
          child: BlocListener<CartCubit, CartState>(
            listener: (context, state) {
              if (state is CartActionSuccess) {
                Navigator.of(context, rootNavigator: true).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      productName == null
                          ? "Item added to cart successfully"
                          : "$productName added to cart",
                    ),
                  ),
                );
              }

              if (state is CartActionFailure) {
                Navigator.of(context, rootNavigator: true).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(state.message),
                  ),
                );
              }
            },
            child: AlertDialog(
              title: const Text("Add to Cart"),
              content: Text(
                quantity == 1
                    ? "Adding item to cart..."
                    : "Adding $quantity items...",
              ),
            ),
          ),
        );
      },
    );

    _cartCubit.addToCart(
      productId: productId,
      quantity: quantity,
    );
  }
}