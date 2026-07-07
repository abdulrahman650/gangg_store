import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/features/home/presentation/widgets/product_card.dart';
import 'package:gangg_store/features/prodeuct_details/presentation/widgets/bottom_navigation.dart';

import 'package:gangg_store/features/prodeuct_details/presentation/widgets/quantity_and_price.dart';

import '../../../../core/theme/theme_cubit.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../../search/presentation/screens/search_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.primary,
          onPressed: () {
            Navigator.pop(context);
          },
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
          SizedBox(
            height: 320,
            child: ListView.builder(
              primary: false,
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(right: 16),
                  width: 280,
                  decoration: BoxDecoration(
                    color: AppColors.gray,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Image.network(
                    'https://api.ecom.longines.com/media/catalog/product/w/a/watch-collection-longines-spirit-zulu-time-1925-l3-803-5-53-6-fdc6b9-hero.png?w=960',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    alignment: Alignment.center,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),

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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                'PRECISION COLLECTION',
                style: textTheme.bodyMedium?.copyWith(
          color: AppColors.darkGray,
                ),
              ),
              Column(
                children: const [
                  Row(
                    children: [  Icon(Icons.star, color: AppColors.primary, size: 16),
                      Text(
                        ' 4.9',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,
                            color: AppColors.primary),
                      ),],
                  ),

                  Text(
                    ' (128 reviews)',
                    style: TextStyle(fontSize: 11, color: AppColors.darkGray),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
           Text(
            'Chrono-Master Titanium',
            style: textTheme.headlineSmall?.copyWith(
              // color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              const Text(
                '\$2,450.00',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '\$3,100.00',
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
                child: const Text(
                  '20% OFF',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

           Text(
            'DESCRIPTION',
            style: textTheme.titleLarge?.copyWith(
              // color: AppColors.black,
              fontWeight: FontWeight.w400,
              fontSize: 16
            ),
          ),
          const SizedBox(height: 8),
           Text(
            'Experience the pinnacle of luxury horology. The Chrono-Master Titanium combines aerospace-grade materials with a hand-assembled Swiss movement. Designed for the modern explorer who demands both technical excellence and refined aesthetic presence.',
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.darkGray,
            ),
          ),
          const SizedBox(height: 20),

          QuantityAndPrice(),
          const SizedBox(height: 25),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                'Similar Products',
                style: textTheme.titleLarge?.copyWith(
                  // color: AppColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16
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
                    child: ProductCard(
                      title: 'Chrono-Master Titanium',
                      price: '\$2,450.00',
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),

      bottomNavigationBar: BottomNavigation(),
    );
  }
}
