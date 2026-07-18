import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/core/services/service_locators.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/core/theme/theme_cubit.dart';
import 'package:gangg_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gangg_store/features/cart/presentation/cubit/cart_state.dart';
import 'package:gangg_store/features/cart/presentation/screens/cart_screen.dart';
import 'package:gangg_store/features/home/data/model/product_model.dart';
import 'package:gangg_store/features/home/presentation/widgets/product_card.dart';
import 'package:gangg_store/features/prodeuct_details/presentation/cubit/product_details_cubit.dart';
import 'package:gangg_store/features/prodeuct_details/presentation/cubit/product_details_state.dart';
import 'package:gangg_store/features/prodeuct_details/presentation/widgets/bottom_navigation.dart';
import 'package:gangg_store/features/prodeuct_details/presentation/widgets/quantity_and_price.dart';
import 'package:gangg_store/features/search/presentation/screens/search_screen.dart';
import 'package:gangg_store/features/prodeuct_details/presentation/widgets/product_reviews_section.dart';
import '../../../../core/widgets/network_image_with_shimmer.dart';
import '../widgets/product_loading.dart';
import '../../../reviews/presentation/cubit/review_cubit.dart';
import '../../../reviews/presentation/cubit/review_state.dart';

class ProductDetailScreen extends StatelessWidget {
  final String? productId;
  final ProductModel? product;

  const ProductDetailScreen({
    super.key,
    this.productId,
    this.product,
  }) : assert(
          productId != null || product != null,
          'Either productId or product must be provided',
        );

  @override
  Widget build(BuildContext context) {
    if (product != null) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              final cubit = getIt<ProductDetailsCubit>();
              cubit.setProductDirectly(product!);
              return cubit;
            },
          ),
          BlocProvider(
            create: (_) => getIt<ReviewCubit>()
              ..getReviews(productId: product!.id),
          ),

        ],
        child: BlocListener<CartCubit, CartState>(
          listener: (context, state) {
            if (state is GetCartSuccess) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Item added to cart successfully'),
                  duration: Duration(seconds: 2),
                ),
              );
            } else if (state is GetCartFailure) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: _ProductDetailsView(product: product!),
        ),
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          getIt<ProductDetailsCubit>()..fetchProductDetails(productId!),
        ),

        BlocProvider(
          create: (_) => getIt<ReviewCubit>()
            ..getReviews(productId: productId!),
        ),

      ],
      child: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is GetCartSuccess) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Item added to cart successfully'),
                duration: Duration(seconds: 2),
              ),
            );
          } else if (state is GetCartFailure) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoading) {
              return const ProductLoading();
            }

            if (state is ProductDetailsError) {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(state.message),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<ProductDetailsCubit>().fetchProductDetails(productId!);
                        },
                        child: const Text('Retry',style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is ProductDetailsLoaded) {
              return _ProductDetailsView(
                product: state.product,
                state: state,
              );
            }

            return const ProductLoading();
          },
        ),
      ),
    );
  }
}

class _ProductDetailsView extends StatelessWidget {
  final ProductModel product;
  final ProductDetailsLoaded? state;

  const _ProductDetailsView({
    super.key,
    required this.product,
    this.state,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final hasDiscount = product.discountPercentage > 0;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.card_travel),
            color: AppColors.primary,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Product Image
          Hero(
            tag: product.id,
            child: NetworkImageWithShimmer(
              imageUrl: product.coverPictureUrl,
              width: double.infinity,
              height: 320,
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.categories.isNotEmpty
                    ? product.categories.first.toUpperCase()
                    : 'PRECISION COLLECTION',
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.darkGray,
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: AppColors.primary, size: 16),
                      Text(
                        ' ${product.rating > 0 ? product.rating.toStringAsFixed(1) : '4.9'}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    ' (${product.reviewsCount > 0 ? product.reviewsCount : 128} reviews)',
                    style: const TextStyle(
                      // FontSize: 11,
                      color: AppColors.darkGray,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Product Name
          Text(
            product.name,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // Price
          Row(
            children: [
              Text(
                hasDiscount
                    ? product.formattedDiscountedPrice
                    : product.formattedPrice,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 10),
              if (hasDiscount) ...[
                Text(
                  product.formattedPrice,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.darkGray.withAlpha(160),
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.simony,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${product.discountPercentage.toInt()}% OFF',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 20),

          // Description
          Text(
            'DESCRIPTION',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.description ??
                'Experience the pinnacle of luxury. Designed for the modern explorer who demands both technical excellence and refined aesthetic presence.',
            style: textTheme.bodyMedium?.copyWith(color: AppColors.darkGray),
          ),
          const SizedBox(height: 20),

          // Color & Stock Info
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                product.stock > 0
                    ? 'In Stock (${product.stock})'
                    : 'Out of Stock',
                style: TextStyle(
                  color: product.stock > 0
                      ? Colors.green
                      : Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          const QuantityAndPrice(),
          const SizedBox(height: 25),
          ///reviews
          BlocBuilder<ReviewCubit, ReviewState>(
            builder: (context, reviewState) {
              if (reviewState is ReviewLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (reviewState is ReviewSuccess) {
                return ProductReviewsSection(
                  product: product,
              reviews: reviewState.reviews,
                );
              }

              if (reviewState is ReviewError) {
                return Center(
                  child: Text(reviewState.message),
                );
              }

              return const SizedBox();
            },
          ),
          const SizedBox(height: 25),
          // Similar Products
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Similar Products',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Similar Products List
          if (state != null)
            state!.similarProducts.isEmpty
                ? const Center(
              child: Text("No similar products"),
            )
                : SizedBox(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state!.similarProducts.length,
                itemBuilder: (context, index) {
                  final similarProduct = state!.similarProducts[index];

                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: 180,
                      child: ProductCard(
                        product: similarProduct,
                      ),
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }

}
