import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/core/services/cache_helper.dart';
import 'package:gangg_store/core/services/cache_keys.dart';
import 'package:gangg_store/core/services/service_locators.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/core/theme/theme_cubit.dart';
import 'package:gangg_store/core/utils/default_text_form_field.dart';
import 'package:gangg_store/features/home/data/model/offer_model.dart';
import 'package:gangg_store/features/home/presentation/widgets/category.dart';
import 'package:gangg_store/features/home/presentation/widgets/create_account_bar.dart';
import 'package:gangg_store/features/home/presentation/widgets/discount_card.dart';
import 'package:gangg_store/features/search/presentation/cubit/search_cubit.dart';
import 'package:gangg_store/features/search/presentation/screens/search_screen.dart';

class HomeHeader extends StatelessWidget {
  final List<OfferModel> offers;

  const HomeHeader({
    super.key,
    required this.offers,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),

          /// Search
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
                  fillColor: AppColors.gray.withOpacity(.5),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// Guest Banner
          if (CacheHelper.getData(CacheKeys.isGuest) == true)
            const CreateAccountBar(),

          const SizedBox(height: 25),

          /// Categories
          if (CacheHelper.getData(CacheKeys.isGuest) != true) ...[
            const Category(),
            const SizedBox(height: 20),
          ],

          /// Offers
          if (offers.isNotEmpty)
            DiscountCard(
              offers: offers.take(4).toList(),
            ),

          const SizedBox(height: 25),

          /// Featured Header
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
                onTap: () {},
                child: const Text(
                  'See More',
                  style: TextStyle(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),
        ],
      ),
    );
  }
}