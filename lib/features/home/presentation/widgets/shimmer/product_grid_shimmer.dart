import 'package:flutter/material.dart';
import 'package:gangg_store/features/home/presentation/widgets/shimmer/product_cart_shimmer.dart';



class ProductGridShimmer extends StatelessWidget {
  const ProductGridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: .65,
      ),
      itemBuilder: (_, __) => const ProductCardShimmer(),
    );
  }
}