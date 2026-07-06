import 'package:flutter/material.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/features/home/presentation/widgets/category.dart';
import 'package:gangg_store/features/home/presentation/widgets/create_account_bar.dart';
import 'package:gangg_store/features/home/presentation/widgets/discount_card.dart';
import 'package:gangg_store/features/home/presentation/widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final products = [
    {'title': 'Obsidian Navigator XL', 'price': '\$1,250.00'},
    {'title': 'Heritage Forest Tote', 'price': '\$2,400.00'},
    {'title': 'Midnight Chrono', 'price': '\$850.00'},
    {'title': 'Classic Leather Satchel', 'price': '\$1,100.00'},
    {'title': 'Obsidian Navigator XL', 'price': '\$1,250.00'},
    {'title': 'Heritage Forest Tote', 'price': '\$2,400.00'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: false,
              backgroundColor: AppColors.backgroundWhite,
              elevation: 0,
              title: const Text(
                'Gang Store',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              actions: [
                IconButton(
                  icon: IconButton(
                    // color: Colors.black,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: AppColors.primary,
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    // Search Bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.gray,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for accessories...',
                          hintStyle: TextStyle(
                            color: AppColors.black,
                            fontSize: 14,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.black,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Create Account Banner
                    CreateAccountBar(),
                    const SizedBox(height: 25),

                    // Categories
                    Category(),
                    const SizedBox(height: 20),

                    // 50% Off
                    DiscountCard(),
                    const SizedBox(height: 25),

                    // Featured Products
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Featured Products',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'See More',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),

            // Products
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.65,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final p = products[index % products.length];
                  return ProductCard(title: p['title']!, price: p['price']!);
                }, childCount: products.length),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 30)),
          ],
        ),
      ),
    );
  }
}
