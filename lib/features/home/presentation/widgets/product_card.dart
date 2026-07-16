import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/core/services/service_locators.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/features/home/data/model/product_model.dart';
import 'package:gangg_store/features/prodeuct_details/presentation/screens/product_details_screen.dart';
import 'package:gangg_store/features/favourites/presentation/cubit/wishlist_cubit.dart';
import '../../../../core/utils/add_to_cart_helper.dart';
import '../../../../core/utils/guest_guard.dart';
import '../../../favourites/presentation/cubit/wishlist_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
class ProductCard extends StatefulWidget {
  final ProductModel product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {

  @override
  Widget build(BuildContext context) {
    final hasDiscount = widget.product.discountPercentage > 0;

    return InkWell(
      onTap: () {
        GuestGuard.run(
          context,
          onAuthenticated: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailScreen(productId: widget.product.id),
              ),
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ///Image
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: AppColors.gray,
                  //     borderRadius: const BorderRadius.vertical(
                  //       top: Radius.circular(16),
                  //     ),
                  //   ),
                  //   child: ClipRRect(
                  //     borderRadius: const BorderRadius.vertical(
                  //       top: Radius.circular(16),
                  //     ),
                  //     child: Image.network(
                  //       product.coverPictureUrl,
                  //       fit: BoxFit.cover,
                  //       width: double.infinity,
                  //       height: double.infinity,
                  //       alignment: Alignment.center,
                  //       loadingBuilder: (context, child, loadingProgress) {
                  //         if (loadingProgress == null) return child;
                  //         return Container(
                  //           color: AppColors.gray,
                  //           child: const Center(
                  //             child: CircularProgressIndicator(
                  //               color: AppColors.primary,
                  //             ),
                  //           ),
                  //         );
                  //       },
                  //       errorBuilder: (context, error, stackTrace) {
                  //         return Container(
                  //           color: AppColors.gray,
                  //           child: const Icon(
                  //             Icons.image_not_supported,
                  //             color: AppColors.darkGray,
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                  // Discount Badge
                  _ProductImage(imageUrl: widget.product.imageUrl),
                  if (hasDiscount)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '-${widget.product.discountPercentage.toInt()}%',
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  // Favorite Button
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        GuestGuard.run(
                          context,
                          onAuthenticated: () {
                            getIt<WishlistCubit>().toggleFavorite(widget.product);
                          },
                        );
                      },
                      child: BlocBuilder<WishlistCubit, WishlistState>(
                        builder: (context, state) {
                          final isFavorite = getIt<WishlistCubit>().isFavorite(widget.product.id);
                          return Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              size: 16,
                              color: isFavorite ? Colors.red : AppColors.black,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 12),
                      Text(
                        ' ${widget.product.rating > 0 ? widget.product.rating.toStringAsFixed(1) : 'New'}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.black,
                        ),
                      ),
                      if (widget.product.reviewsCount > 0)
                        Text(
                          ' (${widget.product.reviewsCount})',
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.darkGray,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Price
                  if (hasDiscount) ...[
                    Text(
                      widget.product.formattedPrice,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.darkGray.withAlpha(160),
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Text(
                      widget.product.formattedDiscountedPrice,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ] else
                    Text(
                      widget.product.formattedPrice,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        GuestGuard.run(
                          context,
                          onAuthenticated: () {
                            CartHelper.addToCart(
                              context: context,
                              productId: widget.product.id,
                              quantity: 1,
                              productName: widget.product.name,
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 6),
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}



class _ProductImage extends StatefulWidget {
  final String imageUrl;

  const _ProductImage({
    required this.imageUrl,
  });

  @override
  State<_ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<_ProductImage> {
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    final imageUrl =
    _hasError ? ProductModel.fallbackImageUrl : widget.imageUrl;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(16),
      ),
      child: CachedNetworkImage(
        imageUrl: widget.imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        fadeInDuration: const Duration(milliseconds: 250),
        fadeOutDuration: Duration.zero,
        placeholder: (context, url) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(color: Colors.white),
          );
        },
        errorWidget: (context, url, error) {
          return Image.asset(
            "assets/images/jewelry_category.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          );
        },
      )
    );
  }
}