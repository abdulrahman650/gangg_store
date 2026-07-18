import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/service_locators.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/utils/default_text_form_field.dart';

import '../../../cart/presentation/screens/cart_screen.dart';
import '../../../home/data/model/product_model.dart';
import '../../../prodeuct_details/presentation/screens/product_details_screen.dart';

import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';

import '../widgets/product_search_item.dart';
import '../widgets/search_empty.dart';
import '../widgets/search_product_shimmer.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (_) => getIt<SearchCubit>()..loadProducts(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,

            appBar: AppBar(
              backgroundColor: context.isDark
                  ? Theme.of(context).scaffoldBackgroundColor
                  : AppColors.backgroundWhite,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: AppColors.primary,
                onPressed: () => Navigator.pop(context),
              ),
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
                  icon: const Icon(Icons.card_travel),
                  color: AppColors.primary,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CartScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),

            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  /// Search Field
                  DefaultTextFormField(
                    hintText: 'Search for Gang accessories...',
                    prefixIconImageName: 'search',
                    fillColor: AppColors.gray.withOpacity(.5),
                    onChanged: (value) {
                      context.read<SearchCubit>().onSearchChanged(value);
                    },
                  ),

                  const SizedBox(height: 24),

                  BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      if (state is SearchLoading) {
                        return const SearchProductShimmer();
                      }

                      if (state is SearchError) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 80),
                            child: Text(state.message),
                          ),
                        );
                      }

                      if (state is SearchLoaded) {
                        /// أول ما الشاشة تفتح
                        if (state.query.isEmpty) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "TRENDING CATEGORIES",
                                style: textTheme.titleMedium?.copyWith(
                                  color: AppColors.darkGray,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
                                  fontSize: 12,
                                ),
                              ),

                              const SizedBox(height: 16),

                              GridView.count(
                                shrinkWrap: true,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 1.05,
                                children: [
                                  _buildCategoryCard(
                                    title: "Timepieces",
                                    subtitle: "Curated Selection",
                                    imagePath:
                                    "assets/images/watch.png",
                                    isDark: true,
                                  ),
                                  _buildCategoryCard(
                                    title: "Eyewear",
                                    subtitle: "New Arrivals",
                                    imagePath:
                                    "assets/images/glassess.png",
                                    isDark: false,
                                  ),
                                  _buildCategoryCard(
                                    title: "Fine Leather",
                                    subtitle:
                                    "Handcrafted excellence",
                                    imagePath:
                                    "assets/images/bag.png",
                                    isDark: true,
                                  ),
                                ],
                              ),
                            ],
                          );
                        }

                        /// مفيش نتائج
                        if (state.filteredProducts.isEmpty) {
                          return const SearchEmptyWidget();
                        }

                        /// النتائج
                        return ListView.separated(
                          shrinkWrap: true,
                          physics:
                          const NeverScrollableScrollPhysics(),
                          itemCount: state.filteredProducts.length,
                          separatorBuilder: (_, __) =>
                          const SizedBox(height: 4),
                          itemBuilder: (_, index) {
                            final ProductModel product =
                            state.filteredProducts[index];

                            return SearchProductItem(
                              product: product,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ProductDetailScreen(
                                          productId: product.id,
                                        ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }

                      return const SizedBox();
                    },
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryCard({
    required String title,
    required String subtitle,
    required String imagePath,
    required bool isDark,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(.75),
            ],
          ),
        ),
        padding: const EdgeInsets.all(14),
        alignment: Alignment.bottomLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}