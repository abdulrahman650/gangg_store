import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/core/services/cache_helper.dart';
import 'package:gangg_store/core/services/cache_keys.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/core/utils/default_text_form_field.dart';
import 'package:gangg_store/features/home/presentation/cubit/home_cubit.dart';
import 'package:gangg_store/features/home/presentation/cubit/home_state.dart';
import 'package:gangg_store/features/home/presentation/widgets/category.dart';
import 'package:gangg_store/features/home/presentation/widgets/create_account_bar.dart';
import 'package:gangg_store/features/home/presentation/widgets/discount_card.dart';
import 'package:gangg_store/features/home/presentation/widgets/product_card.dart';

import '../../../../core/services/service_locators.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../search/presentation/cubit/search_cubit.dart';
import '../../../search/presentation/screens/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (state is HomeError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<HomeCubit>().fetchHomeData();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      child: const Text('Retry', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
            }

            if (state is HomeSuccess) {
              return RefreshIndicator(
                onRefresh: () => context.read<HomeCubit>().refreshHomeData(),
                color: AppColors.primary,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            // Search Bar
                            InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider(
                                      create: (_) => getIt<SearchCubit>()..loadProducts(),
                                      child: const SearchScreen(),
                                    ),
                                  ),
                                );
                              },
                              child: IgnorePointer(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: AppColors.gray,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: DefaultTextFormField(
                                    hintText: 'Search for Gang accessories...',
                                    prefixIconImageName: 'search',
                                    fillColor: AppColors.gray.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Create Account Banner
                            if (CacheHelper.getData(CacheKeys.isGuest) == true)
                              const CreateAccountBar(),
                            const SizedBox(height: 25),

                            // Categories
                            if (CacheHelper.getData(CacheKeys.isGuest) != true) ...[
                              const Category(),
                              const SizedBox(height: 20),
                            ],

                            // Offers - show first 4 only
                            if (state.offers.isNotEmpty)
                              DiscountCard(
                                offers: state.offers.take(4).toList(),
                              ),
                            const SizedBox(height: 25),

                            // Featured Products Header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Text(
                                  'Featured Products',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: context.isDark
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Navigate to all products
                                  },
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

                    // Products Grid - show first 10 only
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.65,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final products = state.products.take(10).toList();
                            if (index >= products.length) return null;
                            final product = products[index];
                            return ProductCard(product: product);
                          },
                          childCount: state.products.take(10).length,
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 30)),
                  ],
                ),
              );
            }

            // Initial state - fetch data
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<HomeCubit>().fetchHomeData();
            });
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          },
        ),
      ),
    );
  }
}