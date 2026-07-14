import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/core/services/service_locators.dart'; // <-- import getIt
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/core/theme/theme_cubit.dart';
import 'package:gangg_store/features/cart/presentation/screens/cart_screen.dart';
import 'package:gangg_store/features/home/data/model/product_model.dart';
import 'package:gangg_store/features/home/presentation/widgets/product_card.dart';
import 'package:gangg_store/features/prodeuct_details/presentation/cubit/product_details_cubit.dart';
import 'package:gangg_store/features/prodeuct_details/presentation/cubit/product_details_state.dart';
import 'package:gangg_store/features/prodeuct_details/presentation/widgets/bottom_navigation.dart';
import 'package:gangg_store/features/prodeuct_details/presentation/widgets/quantity_and_price.dart';
import 'package:gangg_store/features/search/presentation/screens/search_screen.dart';

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
    // If we have product object, use it directly without API call
    if (product != null) {
      return BlocProvider(
        create: (context) => getIt<ProductDetailsCubit>() // <-- استخدم getIt
          ..emit(ProductDetailsLoaded(
            product: product!,
          )),
        child: _ProductDetailsView(product: product!),
      );
    }

    // Otherwise fetch by ID
    return BlocProvider(
      create: (context) => getIt<ProductDetailsCubit>() // <-- استخدم getIt
        ..fetchProductDetails(productId!),
      child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            );
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
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is ProductDetailsLoaded) {
            return _ProductDetailsView(product: state.product);
          }

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        },
      ),
    );
  }
}

class _ProductDetailsView extends StatelessWidget {
  final ProductModel product;

  const _ProductDetailsView({required this.product});

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
          // Product Image Carousel
          SizedBox(
            height: 320,
            child: ListView.builder(
              primary: false,
              scrollDirection: Axis.horizontal,
              itemCount: product.productPictures.isNotEmpty
                  ? product.productPictures.length
                  : 1,
              itemBuilder: (BuildContext context, int index) {
                final imageUrl = product.productPictures.isNotEmpty
                    ? product.productPictures[index]
                    : product.coverPictureUrl;
                return Container(
                  margin: const EdgeInsets.only(right: 16),
                  width: 280,
                  decoration: BoxDecoration(
                    color: AppColors.gray,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      alignment: Alignment.center,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.gray,
                          child: const Icon(
                            Icons.image_not_supported,
                            color: AppColors.darkGray,
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),

          // Page Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 16,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: AppColors.gray,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: AppColors.gray,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Category & Rating
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
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: _getColorFromString(product.color),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.gray),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Color: ${product.color}',
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.darkGray,
                ),
              ),
              const Spacer(),
              Text(
                product.stock > 0
                    ? 'In Stock (${product.stock})'
                    : 'Out of Stock',
                style: TextStyle(
                  color: product.stock > 0 ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          const QuantityAndPrice(),
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
          SizedBox(
            height: 280,
            child: ListView.builder(
              primary: false,
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 180,
                    child: ProductCard(product: product),
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

  Color _getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'silver':
        return Colors.grey;
      case 'gold':
        return Colors.amber;
      case 'navy':
        return const Color(0xFF000080);
      case 'grey':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}