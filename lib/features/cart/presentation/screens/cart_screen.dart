import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/core/services/service_locators.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/core/utils/default_elevated_button.dart';
import 'package:gangg_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gangg_store/features/cart/presentation/cubit/cart_state.dart';
import 'package:gangg_store/features/cart/presentation/widget/cart_item.dart';
import 'package:gangg_store/features/cart/presentation/widget/subtotal.dart';

import '../../../../core/theme/theme_cubit.dart';
import '../../../search/presentation/screens/search_screen.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartCubit>().getCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.primary,
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: context.isDark
            ? Theme.of(context).scaffoldBackgroundColor
            : AppColors.backgroundWhite,
        elevation: 0,
        title: Text(
          'Gang Store',
          style: textTheme.headlineSmall?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: AppColors.primary,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SearchScreen(),
                ),
              );
            },
          ),
        ],
      ),
        body: BlocListener<CartCubit, CartState>(
            listenWhen: (previous, current) => current is GetCartFailure,
            listener: (context, state) {
              if (state is GetCartFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: BlocBuilder<CartCubit, CartState>(
                buildWhen: (previous, current) =>
                previous.runtimeType != current.runtimeType,
                builder: (context, state) {
                  if (state is CartLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is! GetCartSuccess) {
                    return const SizedBox();
                  }

                  final cart = state.cart;


                  if (cart.cartItems.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.card_travel,
                            size: 64,
                            color: AppColors.darkGray,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No Product yet',
                            style: textTheme.titleLarge?.copyWith(
                              color: AppColors.darkGray,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Add products to your Cart',
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.darkGray,
                            ),
                          ),
                        ],
                      ),
                    );
              }

              double subtotal = 0;

              for (final item in cart.cartItems) {
                subtotal += item.totalPrice;
              }

              final shipping = 50.0;
              final total = subtotal + shipping;

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    Text("Shopping Bag", style: textTheme.headlineSmall),

                    const SizedBox(height: 6),

                    Text(
                      "${cart.cartItems.length} items in your cart",
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.darkGray,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Expanded(
                      child: ListView(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cart.cartItems.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 15),
                            itemBuilder: (_, index) {
                              return CartItem(
                                item: cart.cartItems[index],
                              );
                            },
                          ),

                          const SizedBox(height: 25),



                          const SizedBox(height: 25),

                          Subtotal(subtotal: subtotal, total: total, ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),

                    DefaultElevatedButton(
                      label: "Proceed to Checkout",
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      onPressed: () {},
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          })
      ),
    );
  }
}
