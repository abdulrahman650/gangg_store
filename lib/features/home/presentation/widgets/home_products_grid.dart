import 'package:flutter/material.dart';
import 'package:gangg_store/features/home/data/model/product_model.dart';
import 'package:gangg_store/features/home/presentation/widgets/product_card.dart';

class HomeProductsGrid extends StatelessWidget {
  final List<ProductModel> products;

  const HomeProductsGrid({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    final displayProducts = products.take(10).toList();

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: .65,
        ),
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            return ProductCard(
              product: displayProducts[index],
            );
          },
          childCount: displayProducts.length,
        ),
      ),
    );
  }
}