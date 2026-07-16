import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/core/theme/theme_cubit.dart';
import 'package:gangg_store/features/home/data/model/product_model.dart';
import 'package:shimmer/shimmer.dart';

class SearchProductItem extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;

  const SearchProductItem({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: context.isDark
              ? Colors.grey.shade900
              : Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            Hero(
              tag: product.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  product.imageUrl,
                  width: 85,
                  height: 85,
                  fit: BoxFit.cover,
                  loadingBuilder: (_, child, loading) {
                    if (loading == null) return child;

                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 85,
                        height: 85,
                        color: Colors.white,
                      ),
                    );
                  },
                  errorBuilder: (_, __, ___) {
                    return Container(
                      width: 85,
                      height: 85,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.image_not_supported),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    product.displayName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: text.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    product.categories.isEmpty
                        ? "Accessories"
                        : product.categories.first,
                    style: text.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [

                      if (product.discountPercentage > 0)
                        Text(
                          product.formattedPrice,
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),

                      if (product.discountPercentage > 0)
                        const SizedBox(width: 8),

                      Text(
                        product.formattedDiscountedPrice,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: AppColors.primary,
            )
          ],
        ),
      ),
    );
  }
}