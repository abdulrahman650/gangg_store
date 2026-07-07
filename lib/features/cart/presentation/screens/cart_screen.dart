import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/core/utils/default_elevated_button.dart';
import 'package:gangg_store/features/cart/presentation/widget/cart_item.dart';
import 'package:gangg_store/features/cart/presentation/widget/subtotal.dart';

import '../../../../core/theme/theme_cubit.dart';
import '../../../search/presentation/screens/search_screen.dart';
import '../widget/coupon-section.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar: AppBar(
          leading:   IconButton(
            icon: const Icon(Icons.arrow_back),
            color: AppColors.primary,
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
          ),
          backgroundColor:  context.isDark
              ?  Theme.of(context).scaffoldBackgroundColor : AppColors.backgroundWhite ,
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
          //   currentScreen == 0
          //       ? "Home"
          //       : currentScreen == 1
          //           ? "Category"
          //           : currentScreen == 2
          //               ? "Wishlist"
          //               : "Profile",
          //   style: const TextStyle(
          //     color: AppColors.primary,
          //     fontSize: 20,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // centerTitle: true,
        ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 10),

              Text(
                "Shopping Bag",
                style: textTheme.headlineSmall,
              ),

              const SizedBox(height: 6),

              Text(
                "3 items in your cart",
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
                      itemCount: 3,
                      separatorBuilder: (_, __) =>
                      const SizedBox(height: 15),
                      itemBuilder: (_, index) {
                        return CartItem();
                      },
                    ),

                    const SizedBox(height: 25),

                    CouponSection(
                      onApply: () {},
                    ),

                    const SizedBox(height: 25),

                    const Subtotal(),

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
      ),
    );
  }
}